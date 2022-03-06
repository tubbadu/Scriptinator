import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import org.kde.kirigami 2.4 as Kirigami

Kirigami.FormLayout {
	id: page

	property alias cfg_initScript: initScript.text
	property alias cfg_onClickScript: onClickScript.text
	property alias cfg_onClickIcon: onClickIcon.text
	property alias cfg_wheelUpScript: wheelUpScript.text
	property alias cfg_wheelDownScript: wheelDownScript.text
	property alias cfg_onMouseOverScript: onMouseOverScript.text
	property alias cfg_customIcon: customIcon.text
	property alias cfg_showBackground: showBackground.checked
	property alias cfg_showTooltip: showTooltip.checked
	property alias cfg_setHeight: setHeight.value
	property alias cfg_setWidth: setWidth.value

	property alias cfg_customTooltip: customTooltip.text
	property alias cfg_customTooltipCheck: customTooltipCheck.checked

	TextField {
		id: customIcon
		Kirigami.FormData.label: i18n("Custom icon full path")
	}
	TextField {
		id: onClickIcon
		Kirigami.FormData.label: i18n("OnClick icon full path")
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
	TextField {
		id: onMouseOverScript
		Kirigami.FormData.label: i18n("OnMouseOver script:")
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
		text: i18n("use custom tooltip (if this option is disabled and the showTooltip option is enabled, the tooltip will be set to the full output of the last-run command)")
	}
	TextField {
		id: customTooltip
		Kirigami.FormData.label: i18n("Custom tooltip")
	}
	Label{
		text: i18n("choose custom height and width. If set to 0, it will be automatic")
	}
	RowLayout {
		id: setSize
		spacing: 6
		Label{
			text: i18n("Height")
		}
		SpinBox {
			id: setHeight
			//value: 0
			//Kirigami.FormData.label: i18n("Height")
		}
		Label{
			text: i18n("Width")
		}
		SpinBox {
			id: setWidth
			//value: 0
			//Kirigami.FormData.label: i18n("Width")
		}
	//	TextField {
	//		id: prova
	//		text: i18n("provaaa")
	//	}
	}
}
