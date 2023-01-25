import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import org.kde.kirigami 2.4 as Kirigami

Kirigami.FormLayout {
	id: page2

	Label{
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
	}
}
