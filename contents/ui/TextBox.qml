import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import org.kde.kirigami 2.4 as Kirigami

// TODO add a horizontal scrollbar to that text gets never wrapped
Column{
	property alias label: lbl.text
	property alias text: txt.text
	width: page.width
	Kirigami.Label {
		visible: text !== ""
		id: lbl
		//text: i18n("proviamo un po'")
		wrapMode: Kirigami.Label.Wrap
		width: parent.width
	}
	TextField {
		id: txt
		width: parent.width
	}
}