import QtQuick 
import QtQuick.Layouts 
import QtQuick.Controls 
import org.kde.plasma.plasmoid 
import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasma5support as Plasma5Support

PlasmoidItem {
		id: root
	
		preferredRepresentation: fullRepresentation
		property string initScript: plasmoid.configuration.initScript
		property string onClickScript: plasmoid.configuration.onClickScript
		property string onClickIcon: plasmoid.configuration.onClickIcon
		property string wheelUpScript: plasmoid.configuration.wheelUpScript
		property string wheelDownScript: plasmoid.configuration.wheelDownScript
		property string periodicScript: plasmoid.configuration.periodicScript
		property string onMouseOverScript: plasmoid.configuration.onMouseOverScript
		property string customIcon: plasmoid.configuration.customIcon
		property bool showBackground: plasmoid.configuration.showBackground
		property bool showTooltip: plasmoid.configuration.showTooltip
		property string customTooltipHead: plasmoid.configuration.customTooltipHead
		property string customTooltipBody: plasmoid.configuration.customTooltipBody
		property bool customTooltipCheck: plasmoid.configuration.customTooltipCheck
		property string customText: plasmoid.configuration.customText
		property int customTextAlign: plasmoid.configuration.customTextAlign? plasmoid.configuration.customTextAlign : Label.AlignVCenter

		//property int setHeight: plasmoid.configuration.setHeight
		//property int setWidth: plasmoid.configuration.setWidth
		property int timeout: plasmoid.configuration.timeout
		
		property string iconPath: root.customIcon
		property string dynamicTooltipHead: root.customTooltipHead
		property string dynamicTooltipBody: root.customTooltipBody
		property string status: "passive"
		property string text: root.customText

		property string lastOutput: ""
		property string lastCommand: ""

		Component.onCompleted: {
			executable.exec(root.initScript);
		}

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

		Plasma5Support.DataSource {
			id: executable
			engine: "executable"
			connectedSources: []
			property string setupCommand: 'function scriptinator_icon_set { echo "{PlasmoidIconStart}$@{PlasmoidIconEnd}";}; function scriptinator_tooltip_head_set { echo "{PlasmoidTooltipHeadStart}$@{PlasmoidTooltipHeadEnd}";}; function scriptinator_tooltip_body_set { echo "{PlasmoidTooltipBodyStart}$@{PlasmoidTooltipBodyEnd}";}; function scriptinator_status_set { echo "{PlasmoidStatusStart}$@{PlasmoidStatusEnd}";}; function scriptinator_text_set { echo "{PlasmoidTextStart}$@{PlasmoidTextEnd}";}; ' // this will allow to just run "scriptinator_icon_set plasma" to set the icon (same for tooltip, text and status)
			onNewData: {
				var exitCode = data["exit code"]
				var exitStatus = data["exit status"]
				var stdout = data["stdout"]
				var stderr = data["stderr"]
				exited(sourceName, exitCode, exitStatus, stdout, stderr)
				disconnectSource(sourceName) // cmd finished
			}
			function exec(cmd) {
				if (cmd) {
					connectSource(setupCommand + cmd)
				}
			}
			signal exited(string cmd, int exitCode, int exitStatus, string stdout, string stderr)
		}

		Connections {
			target: executable

			function extractFromTags(text, tag1, tag2) {
				const regex = new RegExp(tag1 + "(.*?)" + tag2, "g");
				const matches = text.match(regex);

				if (matches) {
					return matches.map(match => match.replace(tag1, '').replace(tag2, ''));
				}

				return [];
			}

			function extractIcon(text) {
				return extractFromTags(text, "{PlasmoidIconStart}", "{PlasmoidIconEnd}");
			}
			function extractText(text) {
				return extractFromTags(text, "{PlasmoidTextStart}", "{PlasmoidTextEnd}");
			}
			function extractTooltipHead(text) {
				return extractFromTags(text, "{PlasmoidTooltipHeadStart}", "{PlasmoidTooltipHeadEnd}");
			}
			function extractTooltipBody(text) {
				const ret = extractFromTags(text, "{PlasmoidTooltipBodyStart}", "{PlasmoidTooltipBodyEnd}");
				if(ret == []){
					return extractFromTags(text, "{PlasmoidTooltipStart}", "{PlasmoidTooltipEnd}"); // leaving this for backward compatibility! I'll remove it in the next versions'
				} else {
					return ret;
				}
			}
			function extractStatus(text) {
				return extractFromTags(text, "{PlasmoidStatusStart}", "{PlasmoidStatusEnd}");
			}
			function onExited(cmd, exitCode, exitStatus, stdout, stderr) {
				// slice(-1) is used to get the last one
				let icon = extractIcon(stdout).slice(-1)[0];
				let tooltipHead = extractTooltipHead(stdout).slice(-1)[0];
				let tooltipBody = extractTooltipBody(stdout).slice(-1)[0];
				let status = extractStatus(stdout).slice(-1)[0];
				let text = extractText(stdout).slice(-1)[0];

				if(icon) {
					root.iconPath = icon.trim();
				}
				if(tooltipHead) {
					root.dynamicTooltipHead = tooltipHead; // do not trim tooltip
				}
				if(tooltipBody) {
					root.dynamicTooltipBody = tooltipBody; // do not trim tooltip
				}
				if(status) {
					root.status = status.trim();
				}
				if(text) {
					console.warn(text, root.text)
					root.text = text; // do not trim text
					console.warn(text, root.text)
				}

				root.lastOutput = stdout;
				root.lastCommand = cmd.slice(executable.setupCommand.length);
			}
		}

		MouseArea {
			id: mouseArea
			anchors.fill: parent
			hoverEnabled: root.onMouseOverScript != ""

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

		Kirigami.Icon {
			anchors.fill: parent
			source: root.iconPath

			PlasmaCore.ToolTipArea { // documentation here: https://api.kde.org/frameworks-api/frameworks-apidocs/frameworks/plasma-framework/html/classToolTip.html // dead link
				id: tooltiparea
				timeout: -1
				anchors.fill: parent
				mainText: root.customTooltipCheck? root.dynamicTooltipHead : root.lastCommand
				subText: root.customTooltipCheck? root.dynamicTooltipBody : root.lastOutput
				enabled: root.showTooltip
			}

			Label {
				anchors.fill: parent
				verticalAlignment: root.customTextAlign
				horizontalAlignment: Text.AlignHCenter
				wrapMode: Label.Wrap
				text: root.text
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

		//Layout.preferredHeight: setHeight == 0 ? -1 : setHeight
		//Layout.preferredWidth: setWidth == 0 ? -1 : setWidth
}
