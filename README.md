# Scriptinator

---

## install

to install just navigate to the downloaded Scriptinator folder and run

```bash
chmod +x install.sh
./install.sh
```

## usage

add the plasmoid to the desktop or to a panel, then right click on it and select *configure*:

* **introduction:** 
  
  > whenever a command is launched by the plasmoid, it searches the output of that command for a pattern like this:
  > 
  > ```
  > {PlasmoidIconStart}/home/path/to/icon.png{PlasmoidIconEnd}
  > {PlasmoidTooltipStart}some text here{PlasmoidTooltipEnd} 
  > ```
  > 
  > and then, if found, changes his icon and/or tooltip to the specified new value.
  > 
  > if no "formatted" output is returned, nothing is changed.
+ **custom icon full path:**
  
  > the icon specified here will be set as icon as soon as Plasmashell starts.
  > 
  > use the full icon, so don't do `~/icon.png` and `$HOME/icon.png` as they may not work.
* **init script:**
  
  > this script will be run just once when the plasmashell is started, so it could be useful to dynamically set an icon or a tooltip. You can do this with:
  > 
  > ```bash
  > echo '{PlasmoidIconStart}/home/path/to/icon.png{PlasmoidIconEnd}'  
  > echo '{PlasmoidTooltipStart}/home/path/to/icon.png{PlasmoidTooltipEnd}'  
  > ```
  > 
  > or by calling any script that return this string as an output (it could be not the only output).
  > 
  > NOTE: the icon is not changed unless an output respecting this pattern is returned by a script launched by Scriptinator.
+ **OnClick script, WheelUp script, WheelDown script:**
  
  > those script wil be run whenever you left-click or scroll up or down with the mouse overing onto the plasmoid. You can change the plasmoid icon as well, as explained above.

+ **OnMouseOverScript**:
  
  > launches this command whenever the cursor comes over the widget. You may want to use this to change the tooltip.

+ **Show Background:**
  
  > uncheck this to remove that black square around your widget.
  > 
  > Use it only if you use transparenced icons, otherwhise it will be unuseful.
  > 
  > NOTE! if this option is disabled and you accidentally set an icon to something that does not exist, the plasmoid will become completely invisible, so if you don't remember where was it placed you will lose it!

+ **Show tooltip:**
  
  > if this is checked, overing the mouse onto the widget will display a tooltip containing the output of the last command run (including the seticon string), or a custom tooltip as explained below.

+ **Use custom tooltip:**
  
  > check this if you want a custom tooltip (specified in the configuration of the plasmoid or set dynamically with a command).
  > 
  > Note: you can use HTML formatting for the tooltip, such as `<b>bold</b>` and so on, but CSS won't work.

+ **custom tooltip**:
  
  > specify here the custom tooltip. if the use custom tooltip option is disabled, this will not be shown (really strange, isn't it? XD)

+ **custom height and width**:
  
  > if set to 0, the plasmoid will determine its size automatically; otherwise, it will set his size to the specified one.
  > 
  > NOTE! you may set the height to a number and the width to 0 (or vice versa) to have one fixed dimension and an automatic one

NOTE! after changing preferences, if those doesn't apply immediately, just restart your session or launch `plasmashell --replace` in a terminal (or in krunner, better) 

---

## TODO

* I dunno if something comes to my mind I'll write it here
* add the double tooltip
* add the {PlasmoidTextStart} feature
* make the assigned shortcut work
