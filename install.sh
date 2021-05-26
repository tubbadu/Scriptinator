#!/usr/bin/bash
sed -i "s%Icon=/home/tubbadu/.local/share/plasma/plasmoids/com.github.scriptinator/contents/img/scriptinator_border.png%Icon=/home/$(whoami)/.local/share/plasma/plasmoids/com.github.scriptinator/contents/img/scriptinator_border.png%" ./metadata.desktop # change the icon path in the metadata file
plasmapkg2 --install . # install the plasmoid
