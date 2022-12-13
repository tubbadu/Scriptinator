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

		text: i18n("The icon will be set everytime a command returns an output containing the following pattern:

```{PlasmoidIconStart}/home/path/to/icon.png{PlasmoidIconEnd}```

Accepted icon values are full paths (not relative paths) or icon names (`plasma`).

To change the tooltip the process is the same:

```{PlasmoidTooltipStart}this is the new tooltip!{PlasmoidTooltipEnd}```
		
NOTE! after changing preferences, if those doesn't apply immediately, just restart your session or run `plasmashell --replace` in a terminal (or in krunner, better)")
	}
}


