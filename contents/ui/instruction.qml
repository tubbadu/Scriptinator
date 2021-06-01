import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import org.kde.kirigami 2.4 as Kirigami

Kirigami.FormLayout {
	id: page2


	Text {
		text: i18n("The icon will be set everytime a command return an output containing:")
		color: "white"
		styleColor: "black"
	}
	Text {
		text: i18n("> ```{PlasmoidIconStart}/home/path/to/icon.png{PlasmoidIconEnd}```")
		textFormat: Text.MarkdownText
		color: "white"
		styleColor: "black" 
	}
	Text {
		text: i18n("please use the full path.\nTo change the tooltip the process is the same:")
		color: "white"
		styleColor: "black" 
	}
	Text {
		text: i18n("> ```{PlasmoidTooltipStart}this is the new tooltip!{PlasmoidTooltipEnd}```")
		textFormat: Text.MarkdownText
		color: "white"
		styleColor: "black" 
	}
	Text {
		text: i18n("\nNOTE! after changing preferences, if those doesn't apply immediately, just restart your session or launch `plasmashell --replace` in a terminal (or in krunner, better)")
		textFormat: Text.MarkdownText
		color: "white"
		styleColor: "black" 
	}
}


