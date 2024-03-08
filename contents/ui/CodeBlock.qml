import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami


Rectangle{
	property alias text: txtdt.text
	width: page2.width
	height: txtdt.height + 4
	color: Qt.rgba(0.5, 0.5, 0.5, 0.5)
	radius: 3
	ScrollView{
		anchors.fill: parent
		ScrollBar.vertical.policy: ScrollBar.AlwaysOff
		ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
		TextEdit{
			anchors.centerIn: parent
			id: txtdt
			font.family: "Noto Sans Mono"
			text: ""
			readOnly: true
			selectByMouse: true
			color: lbl.color
			Label{
				id: lbl // used just for color reference, may replace with more elegant solution
				visible: false
			}
		}
	}
}


/*
TextEdit{
	//QFontDatabase.FixedFont
	font.family: "Noto Sans Mono"
	text: ""
	readOnly: true
	selectByMouse: true
	color: lbl.color
	Label{
		id: lbl // used just for color reference, may replace with more elegant solution
		visible: false
	}
	
	Rectangle{
		//anchors.top: parent.top
		//anchors.bottom: parent.bottom
		anchors.centerIn: parent
		width: parent.width + 2
		height: parent.height
		color: Qt.rgba(0.5, 0.5, 0.5, 0.5)
		radius: 2
	}
}*/