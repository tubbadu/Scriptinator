import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import org.kde.kirigami 2.4 as Kirigami

Kirigami.FormLayout {
	id: page
	Layout.preferredWidth: 200

	property alias cfg_initScript: initScript.text
	property alias cfg_onClickScript: onClickScript.text
	property alias cfg_onClickIcon: onClickIcon.text
	property alias cfg_wheelUpScript: wheelUpScript.text
	property alias cfg_wheelDownScript: wheelDownScript.text
	property alias cfg_onMouseOverScript: onMouseOverScript.text
	property alias cfg_periodicScript: periodicScript.text
	property alias cfg_timeout: timeout.value
	property alias cfg_customIcon: customIcon.text
	property alias cfg_showBackground: showBackground.checked
	property alias cfg_showTooltip: showTooltip.checked
	property alias cfg_setHeight: setHeight.value
	property alias cfg_setWidth: setWidth.value

	property alias cfg_customTooltip: customTooltip.text
	property alias cfg_customTooltipCheck: customTooltipCheck.checked

	TextField {
		id: customIcon
		Kirigami.FormData.label: i18n("Custom icon full path (icon set at the startup)")
		Layout.fillWidth: true
	}
	TextField {
		id: onClickIcon
		Kirigami.FormData.label: i18n("OnClick icon full path (icon set when the widget is clicked, BEFORE the OnClick script is run)")
		Layout.fillWidth: true
	}
	TextField {
		id: initScript
		Kirigami.FormData.label: i18n("Init script (to be run just once at the startup)")
		Layout.fillWidth: true
	}
	TextField {
		id: periodicScript
		Kirigami.FormData.label: i18n("Periodic Script script (will be run periodically)")
		Layout.fillWidth: true
	}
	/*TextField {
		id: provaaa
		Kirigami.FormData.label: i18n("prova script")
		Layout.preferredWidth: 500
		Layout.fillWidth: false
		text: parent.width
	}*/
	
	RowLayout{
		SpinBox {
			id: timeout
			from: 0
			to: 100000
		}
		Label{
			text: i18n("Timeout to run Periodic Script (in seconds); set it to 0 to disable")
			Layout.fillWidth: true
			wrapMode: Text.Wrap
		}
		Layout.fillWidth: true
	}
	TextField {
		id: onClickScript
		Kirigami.FormData.label: i18n("OnClick script (to be run when the widget is clicked)")
		Layout.fillWidth: true
	}
	TextField {
		id: wheelUpScript
		Kirigami.FormData.label: i18n("WheelUp script (to be run when scrolling up with the mouse over the widget)")
		Layout.fillWidth: true
	}
	TextField {
		id: wheelDownScript
		Kirigami.FormData.label: i18n("WheelDown script (to be run when scrolling down with the mouse over the widget)")
		Layout.fillWidth: true
	}
	TextField {
		id: onMouseOverScript
		Kirigami.FormData.label: i18n("OnMouseOver script (to be run when the mouse hovers the widget)")
		Layout.fillWidth: true
	}
	CheckBox {
		id: showBackground
		text: i18n("Show background (this will only affect the widget if it is placed on the desktop)")
		Layout.fillWidth: true
	}
	CheckBox {
		id: showTooltip
		text: i18n("Show tooltip")
		Layout.fillWidth: true
	}
	CheckBox {
		id: customTooltipCheck
		text: i18n("Use custom tooltip (if this option is disabled and the show tooltip option is enabled, the tooltip will be set to the full output of the last run command)")
		Layout.fillWidth: true
	}
	TextField {
		id: customTooltip
		Kirigami.FormData.label: i18n("Custom tooltip")
		Layout.fillWidth: true
	}
	Label{
		text: i18n("Set custom height and width. If set to 0, it will be automatic (this will only affect the widget if it is placed in the desktop)")
		Layout.fillWidth: true
	}
	RowLayout {
		id: setSize
		spacing: 6
		Label{
			text: i18n("Height")
		}
		SpinBox {
			id: setHeight
			from: 0
			to: 3000
		}
		Label{
			text: i18n("Width")
		}
		SpinBox {
			id: setWidth
			from: 0
			to: 3000
		}
		Layout.fillWidth: true
	}
}
