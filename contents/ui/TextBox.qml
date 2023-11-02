import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import org.kde.kirigami 2.4 as Kirigami

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
