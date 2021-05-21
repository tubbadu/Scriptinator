# Scriptinator

---

## install

just copy these files into the `~/.local/share/plasma/plasmoids/` folder, than edit the `metadata.desktop` file changing the user folder:

```bash
Icon=/home/USER/.local/share/plasma/plasmoids/com.github.scriptinator/contents/img/scriptinator_border.png
```

 than refresh the plasma shell with

```bash
plasmashell --replace
```

or just reboot or whatever you like.

## usage

add the plasmoid to the desktop or to a panel, then right click on it and select *configure*:

* **init script:**
  
  * this script will be run just once when the plasmashell is started, so it could be useful to set an icon. You can do this with:
  
  * ```bash
    echo '{PlasmoidIconStart}/home/path/to/icon.png{PlasmoidIconEnd}'  
    ```
  
  * or calling any script that return this string as an output (it could be not the only output)
  
  * the icon is not changed unless an output respecting this pattern is returned by a script launched by Scriptinator.
+ **OnClick script, WheelUp script, WheelDown script:**
  
  + those script wil be run whenever you left-click or scroll up or down with the mouse overing onto the plasmoid. You can change the plasmoid icon as well, as explained above.

+ **Show Background:**
  
  + uncheck this to remove that black square around your widget. NOTE! if this option is disabled and you accidentally set an icon to something that does not exist, the plasmoid will become invisible, so if you don't remember where was it placed you will lose it! use it only if you use transparenced icons.

+ **Show tooltip:**
  
  + if this is checked, overing the mouse onto the widget will display a tooltip containing the output of the last command run (including the seticon string), or a custom tooltip as explained below.

+ **Use custom tooltip:**
  
  + check this if you want a custom tooltip (written in the textbox below the checkbox). NOTE! it must be checked the *show tooltip* in order to display it.

---

## TODO

* I dunno if something comes to my mind I'll write it here
* set custom dimension
