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
		
		property string iconPath: ""
		property string dynamicTooltip: ""
		property string outputText: ""

		Component.onCompleted: {
			onStartup();
			//plasmoid.addEventListener('ConfigChanged', configChanged);
		}

		/*function configChanged(){ //TODO FIX
			root.initScript = plasmoid.readConfig("initScript");
			root.
			Script = plasmoid.readConfig("onClickScript");
			root.onClickIcon = plasmoid.readConfig("onClickIcon");
			root.wheelUpScript = plasmoid.readConfig("wheelUpScript");
			root.wheelDownScript = plasmoid.readConfig("wheelDownScript");
		}*/
		
		function onStartup(){
			dynamicTooltip = customTooltip;
			iconPath = customIcon;
			executable.exec(initScript);
		}

		PlasmaCore.DataSource {
			id: executable
			engine: "executable"
			connectedSources: []
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
					connectSource(cmd)
				}
			}
			signal exited(string cmd, int exitCode, int exitStatus, string stdout, string stderr)
		}

		Connections {
			target: executable
			onExited: {
				outputText = stdout.replace('\n', '');
				if(outputText.includes("{PlasmoidIconStart}") && outputText.includes("{PlasmoidIconEnd}")) {
					iconPath = outputText.substring(outputText.search("{PlasmoidIconStart}") + 19, outputText.search("{PlasmoidIconEnd}"));
				}
				if(outputText.includes("{PlasmoidTooltipStart}") && outputText.includes("{PlasmoidTooltipEnd}")) {
					dynamicTooltip = outputText.substring(outputText.search("{PlasmoidTooltipStart}") + 22, outputText.search("{PlasmoidTooltipEnd}"));
				}
			}
		}

		MouseArea {
			id: mouseArea
			anchors.fill: parent
			hoverEnabled: true// config.clickEnabled

			//cursorShape: output.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
			
			onClicked: {
				if(onClickIcon != ""){
					parent.iconPath = onClickIcon;
				}
				executable.exec(onClickScript)
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
					executable.exec(wheelUpScript)
				}
				while (wheelDelta <= -120) {
					wheelDelta += 120
					//WheelDown
					executable.exec(wheelDownScript);
				}
				wheel.accepted = true
			}
			
			// ADD HERE THE POSSIBILITY TO CHANGE THE TOOLTIP EVERYTIME MOUSE IS OVER
			onEntered: { // on mouse over
				executable.exec(onMouseOverScript);
			}
			
			PlasmaCore.ToolTipArea { // documentation here: https://api.kde.org/frameworks-api/frameworks-apidocs/frameworks/plasma-framework/html/classToolTip.html
				id: tooltip
				timeout: -1
				anchors.fill: parent
				subText: customTooltipCheck? dynamicTooltip : outputText
				enabled: showTooltip
				//textFormat: RichText // doesn't work... anyone knows why????
			}
		}

		PlasmaCore.IconItem {
			anchors.fill: parent
			source: iconPath
		}

		Timer{
			running: timeout != 0
			interval: Math.trunc(timeout * 1000)
			repeat: true
			triggeredOnStart: true
			onTriggered: {
				executable.exec(periodicScript)
			}
		}

		
		
		Plasmoid.backgroundHints: showBackground ? PlasmaCore.Types.DefaultBackground : PlasmaCore.Types.NoBackground
		
		Layout.maximumHeight: setHeight == 0 ? parent.Height : setHeight
		Layout.minimumHeight: setHeight == 0 ? parent.Height : setHeight
		
		Layout.maximumWidth: setWidth == 0 ? parent.Width : setWidth
		Layout.minimumWidth: setWidth == 0 ? parent.Width : setWidth
}
