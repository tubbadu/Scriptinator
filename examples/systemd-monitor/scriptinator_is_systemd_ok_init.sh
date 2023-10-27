#!/bin/sh

cd "$XDG_RUNTIME_DIR" || exit

echo -n > systemd-status.old

echo "{PlasmoidStatusStart}passive{PlasmoidStatusEnd}" # set to active if you want the icon not to hide in the tray
echo "{PlasmoidIconStart}system-run{PlasmoidIconEnd}"
echo "{PlasmoidTooltipStart}SystemD is running fine.{PlasmoidTooltipEnd}"
