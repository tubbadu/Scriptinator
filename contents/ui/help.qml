import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import org.kde.kirigami 2.4 as Kirigami

Kirigami.FormLayout {
	id: page2
	Column{
		spacing: 3
		width: parent.width
		Title{
			text: "Introduction"
		}
		Paragraph{
			text: "Whenever a command is run by the plasmoid, it searches the output of that command for a pattern like this:"
		}
		CodeBlock{
			text: "{PlasmoidIconStart}/home/path/to/icon.png{PlasmoidIconEnd}\n"+
					"{PlasmoidTooltipStart}some text here{PlasmoidTooltipEnd}"
		}
		Paragraph{
			text: "And then, if found, it changes the icon and/or tooltip to the specified new value."
		}
		Paragraph{
			text: "If no \"formatted\" output is returned, nothing is changed."
		}
		Title{
			text: "Startup icon"
		}
		Paragraph{
			text: "The icon specified here will be set as the plasmoid icon as soon as plasmashell starts."
		}
		Title{
			text: "OnClick icon"
		}
		Paragraph{
			text: "The icon specified here will be set as the plasmoid icon when the plasmoid is (left-)clicked, and <b><i>before</b></i> the <i>OnClick script</i> is run."
		}
		Paragraph{
			text: "<b>NOTE:</b> Acceptable icon values are full paths (not relative paths or `~/icon.png`, `$HOME/icon.png` etc.) or system icon names (e.g. `plasma`)."
		}
		Title{
			text: "Startup script"
		}
		Paragraph{
			text: "This script will be run just once when the <i>plasmashell</i> is started, so it could be useful to dynamically set an icon or a tooltip here, which can be done like this:"
		}
		CodeBlock{
			text: "echo '{PlasmoidIconStart}/home/path/to/icon.png{PlasmoidIconEnd}'\n"+
					"echo '{PlasmoidTooltipStart}This is the new tooltip{PlasmoidTooltipEnd}'"
		}
		Paragraph{
			text: "They can be just part of the output, and not the only output."
		}
		Paragraph{
			text: "<b>NOTE:</b> The plasmoid does not change this icon unless an output in this format is returned by a script launched by it later."
		}
		Title{
			text: "OnClick script, WheelUp script, WheelDown script"
		}
		Paragraph{
			text: "These scripts will be run whenever you (left-)click or scroll up or down with the mouse on the plasmoid."
		}
		Paragraph{
			text: "You can also change the plasmoid icon as explained above."
		}
		Title{
			text: "OnMouseOver script"
		}
		Paragraph{
			text: "This script (or command) is launched whenever the cursor comes over the plasmoid. For example, it can be used to change the tooltip."
		}
		Title{
			text: "Show background"
		}
		Paragraph{
			text: "Uncheck this to remove that black square around the plasmoid (only if the plasmoid is placed on the desktop)."
		}
		Paragraph{
			text: "Use it only if you use transparent icons, otherwise it will be unuseful."
		}
		Paragraph{
			text: "<b>NOTE:</b> If this option is disabled, and you accidentally set an icon to something that does not exist, the plasmoid will become completely invisible; so, if you don't remember where it was placed, you might not be able to find it!"
		}
		Title{
			text: "Show tooltip"
		}
		Paragraph{
			text: "If this is checked, hovering the mouse on the plasmoid will display a tooltip containing the output of the last command run (including the set icon string), or a custom tooltip as explained below."
		}
		Title{
			text: "Use custom tooltip"
		}
		Paragraph{
			text: "Check this if you want a custom tooltip (specified in the configuration of the plasmoid or set dynamically with a command)."
		}
		Title{
			text: "Custom tooltip"
		}
		Paragraph{
			text: "Specify here the custom tooltip. If the Use custom tooltip option is disabled, this will not be shown."
		}
		Paragraph{ 
			text: "<b>NOTE:</b> You can use HTML formatting for the tooltip, such as `<b>bold</b>` and so on, but CSS won't work."
		}
		Title{
			text: "Custom Height and Width"
		}
		Paragraph{
			text: "If set to 0, the plasmoid will determine its size automatically; otherwise, it will set its size to the specified one (only if the plasmoid is placed on the desktop)."
		}
		Paragraph{
			text: "<b>NOTE:</b> You may set the height to a number, and the width to 0 (or vice versa) to have one fixed dimension, with the other set automatically."
		}
		Title{
			text: "System Tray"
		}
		Paragraph{
			text: "<i>Scriptinator</i> is also shown in the system tray, but it's disabled by default."
		}
		Paragraph{
			text: "You can right click the system tray, and select <i>Configure System Tray... > Entries</i>, scroll down to <i>Scriptinator</i>, and set it to <i>Show when relevant</i>."
		}
		Paragraph{
			text: "You can then change its state with:"
		}
		CodeBlock{
			text: "{PlasmoidStatusStart}insert new status here{PlasmoidStatusEnd}"
		}
		Paragraph{
			text: "There are four possible status values:\n"+
			"* `active` will keep Scriptinator visible in system tray\n"+
			"* `passive` will keep Scriptinator hidden in system tray, but visible in system tray popup window\n"+
			"* `attention` will draw attention to Scriptinator, displaying and making it pulsate\n"+
			"* `hidden` will always hide Scriptinator, even in system tray popup window"
		}
		Title{
			text: "Apply Settings"
		}
		Paragraph{
			text: "After changing the preferences, if the changes don't apply immediately, just restart your session or execute `plasmashell --replace` command in terminal (or, better, in <i>Krunner</i>)."
		}
	}
	
/*

Paragraph{
			text: ""
		}
Title{
			text: ""
		}
CodeBlock{
			text: ""
		}




*/
	/*Label{
		textFormat: Text.MarkdownText
		wrapMode: Text.Wrap
		Layout.preferredWidth: parent.width
		// TODO: better format this text, with color and so on

		text: i18n("The icon will be set every time a command returns an output containing the following pattern:

```{PlasmoidIconStart}/home/path/to/icon.png{PlasmoidIconEnd}```

Accepted icon values are full paths (not relative paths) or icon names (e.g. `plasma`).

To change the tooltip, the process is the same:

```{PlasmoidTooltipStart}this is the new tooltip!{PlasmoidTooltipEnd}```

Scriptinator is also shown in the system tray, but it's disabled by default: You can right click the system tray and select \"Configure System Tray...\" > \"Entries\", scroll down to Scriptinator, and set it to \"Show when relevant\".  
You can then change its state with:

```{PlasmoidStatusStart}insert new status here{PlasmoidStatusEnd}```

There are 4 possible status values:
* `active` will keep Scriptinator visible in the system tray
* `passive` will keep Scriptinator hidden in the system tray, but visible in system tray popup window 
* `attention` will draw attention to the plasmoid, displaying and making it pulse until a new status is set
* `hidden` will always hide Scriptinator, even in the system tray popup window

Using this in a Scriptinator placed on the desktop will have no effect 
		
NOTE! After changing preferences, if the hanges don't apply immediately, just restart your session or run `plasmashell --replace` in a terminal (or, better, in Krunner) without logging out.")
	}*/


}
