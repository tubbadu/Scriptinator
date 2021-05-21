import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import org.kde.kirigami 2.4 as Kirigami

Kirigami.FormLayout {
	id: page

	property alias cfg_initScript: initScript.text
	property alias cfg_onClickScript: onClickScript.text
	property alias cfg_wheelUpScript: wheelUpScript.text
	property alias cfg_wheelDownScript: wheelDownScript.text
	property alias cfg_showBackground: showBackground.checked
	property alias cfg_showTooltip: showTooltip.checked

	property alias cfg_customTooltip: customTooltip.text
	property alias cfg_customTooltipCheck: customTooltipCheck.checked


	Label {
	text: i18n("The icon will be set everytime a command return an output containing:\n\n{PlasmoidIconStart}/home/path/to/icon.png{PlasmoidIconEnd}\n\nplease use the full path.\n")
	}
	TextField {
		id: initScript
		Kirigami.FormData.label: i18n("Init script (to be run just once at the startup)")
	}
	TextField {
		id: onClickScript
		Kirigami.FormData.label: i18n("OnClick script:")
	}
	TextField {
		id: wheelUpScript
		Kirigami.FormData.label: i18n("WheelUp script:")
	}
	TextField {
		id: wheelDownScript
		Kirigami.FormData.label: i18n("WheelDown script:")
	}
	CheckBox {
		id: showBackground
		text: i18n("Show background")
	}
	CheckBox {
		id: showTooltip
		text: i18n("Show tooltip")
	}
	CheckBox {
		id: customTooltipCheck
		text: i18n("use custom tooltip instead of output")
	}
	TextField {
		id: customTooltip
		Kirigami.FormData.label: i18n("Custom tooltip")
	}
} 
