import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import org.kde.kirigami 2.4 as Kirigami

Item{
	property string text: ""
	property int titleNumber: 1
	height: lbl.height
	width: lbl.width
	Label{
		id: lbl
		textFormat: Text.RichText
		text: "<h" + titleNumber + ">" + parent.text + "</h" + titleNumber + ">"
		width: page2.width
	}
}
