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
* **OnMouseOver**: *(experimental!)*
  
  * launches this command whenever the cursor comes over the widget. NOTE! It only works if the Show Tooltip option is DISABLED! 

---

## TODO

* I dunno if something comes to my mind I'll write it here
* add the possibility to use in the tooltip bash variable such as the username, the hour, ecc (PlasmoidTooltipStart ecc)
* onMouseOver works only if tooltip is disabled. fix.
* set initIcon and initTooltip more easily with two dedicated fields in config
