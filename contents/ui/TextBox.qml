import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

// TODO add a horizontal scrollbar to that text gets never wrapped
Column{
	property alias label: lbl.text
	property alias text: txt.text
	property alias enabled: txt.enabled
	width: page.width
	Label {
		visible: text !== ""
		id: lbl
		wrapMode: Label.Wrap
		width: parent.width
	}
	TextField {
		id: txt
		width: parent.width
	}
}
