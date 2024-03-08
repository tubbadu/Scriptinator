import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

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
