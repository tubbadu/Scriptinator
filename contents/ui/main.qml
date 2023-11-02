import QtQuick.Layouts 1.0
import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
		id: root
	
	//	Text {
	//		text: customTooltipCheck? dynamicTooltip : outputText
	//		color: "white"
	//	}
	
		Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation
		property string initScript: Plasmoid.configuration.initScript
		property string onClickScript: Plasmoid.configuration.onClickScript
		property string onClickIcon: Plasmoid.configuration.onClickIcon
		property string wheelUpScript: Plasmoid.configuration.wheelUpScript
		property string wheelDownScript: Plasmoid.configuration.wheelDownScript
		property string periodicScript: Plasmoid.configuration.periodicScript
		property string onMouseOverScript: Plasmoid.configuration.onMouseOverScript
		property string customIcon: Plasmoid.configuration.customIcon
		property bool showBackground: Plasmoid.configuration.showBackground
		property bool showTooltip: Plasmoid.configuration.showTooltip
		property string customTooltip: Plasmoid.configuration.customTooltip
		property bool customTooltipCheck: Plasmoid.configuration.customTooltipCheck
		property int setHeight: Plasmoid.configuration.setHeight
		property int setWidth: Plasmoid.configuration.setWidth
		property int timeout: Plasmoid.configuration.timeout
		
		property string iconPath: root.customIcon
		property string dynamicTooltip: root.customTooltip
		property string status: "passive"

		property string outputText: ""

		onStatusChanged: {
			let getStatusCode = {
				"active": PlasmaCore.Types.ActiveStatus,
				"passive": PlasmaCore.Types.PassiveStatus,
				"attention": PlasmaCore.Types.NeedsAttentionStatus,
				"hidden": PlasmaCore.Types.Hidden
			}
			let newStatus = getStatusCode[root.status.toLowerCase()]
			if(newStatus === undefined){
				newStatus = getStatusCode["active"]
			}

			plasmoid.status = newStatus
		}

		PlasmaCore.DataSource {
			id: executable
			engine: "executable"
			connectedSources: []
			property string setupCommand: 'function scriptinator_icon_set { echo "{PlasmoidIconStart}$1{PlasmoidIconEnd}";}; function scriptinator_tooltip_set { echo "{PlasmoidTooltipStart}$1{PlasmoidTooltipEnd}";}; function scriptinator_icon_set { echo "{PlasmoidStatusStart}$1{PlasmoidStatusEnd}";}; ' // this will allow to just run "scriptinator_icon_set plasma" to set the icon (same for tooltip and status)
			onNewData: {
				var exitCode = data["exit code"]
				var exitStatus = data["exit status"]
				var stdout = data["stdout"]
				var stderr = data["stderr"]
				exited(sourceName, exitCode, exitStatus, stdout, stderr)
				disconnectSource(sourceName) // cmd finished
			}
			function exec(cmd) {
				console.warn("exec", cmd)
				if (cmd) {
					connectSource(setupCommand + cmd)
				}
			}
			signal exited(string cmd, int exitCode, int exitStatus, string stdout, string stderr)
		}

		Connections {
			target: executable

			function extractIcon(text) {
				const regex = /{PlasmoidIconStart}(.*?){PlasmoidIconEnd}/g;
				const matches = text.match(regex);

				if (matches) {
					return matches.map(match => match.replace('{PlasmoidIconStart}', '').replace('{PlasmoidIconEnd}', ''));
				}

				return [];
			}
			function extractTooltip(text) {
				const regex = /{PlasmoidTooltipStart}(.*?){PlasmoidTooltipEnd}/g;
				const matches = text.match(regex);

				if (matches) {
					return matches.map(match => match.replace('{PlasmoidIconStart}', '').replace('{PlasmoidIconEnd}', ''));
				}

				return [];
			}
			function extractStatus(text) {
				const regex = /{PlasmoidStatusStart}(.*?){PlasmoidStatusEnd}/g;
				const matches = text.match(regex);

				if (matches) {
					return matches.map(match => match.replace('{PlasmoidIconStart}', '').replace('{PlasmoidIconEnd}', ''));
				}

				return [];
			}
			function onExited(cmd, exitCode, exitStatus, stdout, stderr) {
				let icon = extractIcon(stdout).slice(-1)[0];
				let tooltip = extractTooltip(stdout).slice(-1);[0]
				let status = extractStatus(stdout).slice(-1)[0];

				if(icon) {
					root.iconPath = icon.trim();
				}
				if(tooltip) {
					root.dynamicTooltip = tooltip; // do not trim tooltip
				}
				if(status) {
					root.status = tooltip.trim();
				}

				root.outputText = stdout;
			}
		}

		MouseArea {
			id: mouseArea
			anchors.fill: parent
			hoverEnabled: config.onMouseOverScript != ""

			//cursorShape: output.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
			
			onClicked: {
				if(root.onClickIcon != ""){
					parent.iconPath = root.onClickIcon;
				}
				executable.exec(root.onClickScript)
			}

			property int wheelDelta: 0
			onWheel: {
				var delta = wheel.angleDelta.y || wheel.angleDelta.x
				wheelDelta += delta
				// Magic number 120 for common "one click"
				// See: http://qt-project.org/doc/qt-5/qml-qtquick-wheelevent.html#angleDelta-prop
				while (wheelDelta >= 120) {
					wheelDelta -= 120
					//WheelUp
					executable.exec(root.wheelUpScript)
				}
				while (wheelDelta <= -120) {
					wheelDelta += 120
					//WheelDown
					executable.exec(root.wheelDownScript);
				}
				wheel.accepted = true
			}
			
			onEntered: { // on mouse over
				executable.exec(root.onMouseOverScript);
			}
			

		}

		PlasmaCore.IconItem {
			anchors.fill: parent
			source: root.iconPath

			PlasmaCore.ToolTipArea { // documentation here: https://api.kde.org/frameworks-api/frameworks-apidocs/frameworks/plasma-framework/html/classToolTip.html
				id: tooltiparea
				timeout: -1
				anchors.fill: parent
				subText: root.customTooltipCheck? root.dynamicTooltip : root.outputText
				enabled: root.showTooltip
				//textFormat: RichText // doesn't work... anyone knows why????
			}
		}

		Timer{
			running: root.timeout != 0
			interval: Math.trunc(root.timeout * 1000)
			repeat: true
			triggeredOnStart: true
			onTriggered: {
				executable.exec(root.periodicScript)
			}
		}

		Plasmoid.backgroundHints: showBackground ? PlasmaCore.Types.DefaultBackground : PlasmaCore.Types.NoBackground
		
		/*Layout.maximumHeight: setHeight == 0 ? parent.Height : setHeight
		Layout.minimumHeight: setHeight == 0 ? parent.Height : setHeight
		
		Layout.maximumWidth: setWidth == 0 ? parent.Width : setWidth
		Layout.minimumWidth: setWidth == 0 ? parent.Width : setWidth*/
}
