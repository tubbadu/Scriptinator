#!/bin/sh

cd "$XDG_RUNTIME_DIR" || exit

systemctl --failed > systemd-status
systemctl --user --failed >> systemd-status

if ! cmp --quiet systemd-status systemd-status.old
then
    if grep failed systemd-status
    then
        echo "{PlasmoidStatusStart}active{PlasmoidStatusEnd}"
        echo "{PlasmoidIconStart}computer-fail-symbolic{PlasmoidIconEnd}"
        echo "{PlasmoidTooltipStart}"
        cat systemd-status
        echo "{PlasmoidTooltipEnd}"
    else
        cp systemd-status systemd-status.old
    fi
# else
    # do nothing
fi
