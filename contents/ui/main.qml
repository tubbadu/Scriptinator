import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item{
	Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation
		id: root
		property string initScript: Plasmoid.configuration.initScript
		property string onClickScript: Plasmoid.configuration.onClickScript
		property string wheelUpScript: Plasmoid.configuration.wheelUpScript
		property string wheelDownScript: Plasmoid.configuration.wheelDownScript
		property bool showBackground: Plasmoid.configuration.showBackground
		property bool showTooltip: Plasmoid.configuration.showTooltip
		property string customTooltip: Plasmoid.configuration.customTooltip
		property bool customTooltipCheck: Plasmoid.configuration.customTooltipCheck
		
		property string iconPath: ""
		property string outputText: ""

		Component.onCompleted: {
			executable.exec(initScript);
			plasmoid.addEventListener('ConfigChanged', configChanged);
		}

		function configChanged(){
			root.initScript = plasmoid.readConfig("initScript");
			root.onClickScript = plasmoid.readConfig("onClickScript");
			root.wheelUpScript = plasmoid.readConfig("wheelUpScript");
			root.wheelDownScript = plasmoid.readConfig("wheelDownScript");
			//executable.exec(initScript)
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
			}
		}

		MouseArea {
			id: mouseArea
			anchors.fill: parent
			hoverEnabled: true// config.clickEnabled

			//cursorShape: output.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
			
			onClicked: {
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
		}

		PlasmaCore.IconItem {
			anchors.fill: parent
			source: iconPath//wicon? "/home/tubbadu/Immagini/Wallpapers/knotes.png": "/home/tubbadu/Immagini/Wallpapers/logo_poli_blu.png"
		}

		PlasmaCore.ToolTipArea {
			anchors.fill: parent
			subText: customTooltipCheck? customTooltip : outputText
			enabled: showTooltip
		}
		
		Plasmoid.backgroundHints: showBackground ? PlasmaCore.Types.DefaultBackground : PlasmaCore.Types.NoBackground
}
