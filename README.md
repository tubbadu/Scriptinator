# Scriptinator

---

## install

to install Scriptinator you can use the `install.sh` script:

```bash
git clone https://github.com/tubbadu/Scriptinator
cd Scriptinator
bash ./install.sh
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
  > and then, if found, changes its icon and/or tooltip to the specified new value.
  > 
  > if no "formatted" output is returned, nothing is changed.
+ **custom icon full path:**
  
  > the icon specified here will be set as the plasmoid icon as soon as plasmashell starts.
  > 
  > use the full icon path, so don't do `~/icon.png` and `$HOME/icon.png` as they may not work.
  > 
  > also system icon names can be used: `plasma`
* **init script:**
  
  > this script will be run just once when the plasmashell is started, so it could be useful to dynamically set an icon or a tooltip. You can do this with:
  > 
  > ```bash
  > echo '{PlasmoidIconStart}/home/path/to/icon.png{PlasmoidIconEnd}'  
  > echo '{PlasmoidTooltipStart}/home/path/to/icon.png{PlasmoidTooltipEnd}'  
  > ```
  > 
  > or by calling any script that returns such a string as output (it can be just part of the out, and not the only output).
  > 
  > NOTE: the icon is not changed unless an output in this pattern is returned by a script launched by Scriptinator.
+ **OnClick script, WheelUp script, WheelDown script:**
  
  > these scripts will be run whenever you (left-)click or scroll up or down with the mouse on the plasmoid. You can also change the plasmoid icon as explained above.

+ **OnMouseOver script**:
  
  > launches this command whenever the cursor comes over the widget. You may want to use this to change the tooltip.

+ **Show background:**
  
  > uncheck this to remove that black square around your widget (only if the widget is placed on the desktop).
  > 
  > Use it only if you use transparent icons, otherwhise it will be unuseful.
  > 
  > NOTE! If this option is disabled, and you accidentally set an icon to something that does not exist, the plasmoid will become completely invisible; so, if you don't remember where it was placed you will lose it!

+ **Show tooltip:**
  
  > if this is checked, hovering the mouse on the widget will display a tooltip containing the output of the last command run (including the seticon string), or a custom tooltip as explained below.

+ **Use custom tooltip:**
  
  > check this if you want a custom tooltip (specified in the configuration of the plasmoid or set dynamically with a command).
  > 
  > Note: You can use HTML formatting for the tooltip, such as `<b>bold</b>` and so on, but CSS won't work.

+ **Custom tooltip**:
  
  > specify here the custom tooltip. if the *use custom tooltip* option is disabled, this will not be shown (really strange, isn't it? XD)

+ **Custom Height and Width**:
  
  > if set to 0, the plasmoid will determine its size automatically; otherwise, it will set its size to the specified one (only if the widget is placed on the desktop).
  > 
  > NOTE: You may set the height to a number, and the width to 0 (or vice versa) to have one fixed dimension, with the other set automatically

Scriptinator is also shown in the system tray, but it's disabled by default: you can right click the system tray, and select *Configure System Tray...* > *Entries*, scroll down to Scriptinator, and set it to *Show when relevant*.

You can then change its state with:

```
{PlasmoidStatusStart}insert new status here{PlasmoidStatusEnd}
```

there are 4 possible status values:

* `active` will keep Scriptinator visible in the system tray

* `passive` will keep Scriptinator hidden in the system tray, but visible in system tray popup window

* `attention` will draw attention to the plasmoid, displaying and making it pulse until a new status is set

* `hidden` will always hide Scriptinator, even in the system tray popup window



NOTE! After changing preferences, if the changes don't apply immediately, just restart your session or launch `plasmashell --replace` in a terminal (or in krunner, better) 

---

## TODO

* [ ] I dunno; if something comes to my mind I'll write it here
* [ ] add the double tooltip
* [ ] add the {PlasmoidTextStart} feature
* [ ] make the assigned shortcut work
* [x] update *init script* description (not so clear)
* [ ] [difficult] control Scriptinator externally (like dbus or something like that)
- [ ] make a new UI for the help page, the current one is awful
- [ ] add the "attention for just a few seconds" status, which will set it to attention, and after a few seconds, to active
