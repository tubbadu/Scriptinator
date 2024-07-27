#!/usr/bin/env zsh

status_init() {
	status_list
	if [[ "$update_count" -eq 0 ]]; then
		echo '{PlasmoidIconStart}update-none{PlasmoidIconEnd}'
		echo '{PlasmoidStatusStart}passive{PlasmoidStatusEnd}'
	elif [[ "$update_count" -lt 10 ]]; then
		echo '{PlasmoidIconStart}update-low{PlasmoidIconEnd}'
		echo '{PlasmoidStatusStart}active{PlasmoidStatusEnd}'
	elif [[ "$update_count" -lt 30 ]]; then
		echo '{PlasmoidIconStart}update-medium{PlasmoidIconEnd}'
		echo '{PlasmoidStatusStart}active{PlasmoidStatusEnd}'
	elif [[ "$update_count" -ge 30 ]]; then
		echo '{PlasmoidIconStart}update-high{PlasmoidIconEnd}'
		echo '{PlasmoidStatusStart}active{PlasmoidStatusEnd}'
	else
		echo '{PlasmoidIconStart}question{PlasmoidIconEnd}'
		echo '{PlasmoidStatusStart}active{PlasmoidStatusEnd}'
	fi
}

status_list() {
	apt list --upgradable > "$update_lst"
	sed -i -e "s/^Listing.*$//" -e "s/^N: .*$//" -e "s/\/.*$//g" -e '/^\s*$/d' "$update_lst"
	if [[ -s "$update_list" ]]; then
		rm "$update_list"
	fi
	while IFS= read -r package_name; do
	description=$(dpkg -l | grep -E "^ii \s*$package_name " | awk -F '[[:space:]]{2,}' '{print $5}')
		if [[ -n "$description" ]]; then
			echo "* $package_name: $description" >> "$update_list"
		else
			echo "* $package_name: [No Description]" >> "$update_list"
		fi
	done < "$update_lst"
	sed -i 's/&/&amp;/g' "$update_list"
}

status_periodic() {
	status_list
	status_init
}

view_count() {
	local time="$(stat "$update_lst" | grep "Modify" | awk -F " " '{print $3}' | awk -F "." '{print $1}')"
	local ps="$(cat "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc" | sed -e "0,/^\s*customIcon=.*\s*$/d" -e "/^\s*wheelUpScript=.*\s*$/Q" | grep "timeout=" | awk -F "=" '{print $2}')"
	local ph="$((ps/60/60))"
	if [[ "$update_count" -gt 0 ]]; then
		kdialog --title "Software Updates" \
			--icon "system-software-update" \
			--passivepopup "<b>${update_count}</b> upgradable packages available as of <b>${time}</b> - checking <b>every $ph</b> hours..." 5
	else
		kdialog --title "Software Updates" \
			--icon "update-none" \
			--passivepopup "<b>No upgradable packages</b> available as of <b>${time}</b> - checking <b>every $ph</b> hours..." 5
	fi
}

view_list() {
	if [[ "$update_count" -eq 0 ]]; then
		kdialog --title "Software Updates" \
			--icon "update-none" \
			--passivepopup "<big><b>System is up to date\!</b></big>"
	elif [[ "$update_count" -eq 1 ]]; then
		kdialog --title "${update_count} Package Upgradable" \
			--icon "system-software-update" \
			--textbox "$update_list" \
			--geometry "430x150+1265+25"
	elif [[ "$update_count" -le 5 ]]; then
		kdialog --title "${update_count} Package Upgradable" \
			--icon "system-software-update" \
			--textbox "$update_list" \
			--geometry "430x300+1265+25"
	elif [[ "$update_count" -le 15 ]]; then
		kdialog --title "${update_count} Package Upgradable" \
			--icon "system-software-update" \
			--textbox "$update_list" \
			--geometry "430x500+1265+25"
	elif [[ "$update_count" -lt 20 ]]; then
		kdialog --title "${update_count} Packages Upgradable" \
			--icon "system-software-update" \
			--textbox "$update_list" \
			--geometry "430x600+1265+25"
	elif [[ "$update_count" -ge 20 ]]; then
		kdialog --title "${update_count} Packages Upgradable" \
			--icon "system-software-update" \
			--textbox "$update_list" \
			--geometry "430x800+1265+25"
	fi
}

updater_main() {
	if [[ "$update_count" -eq 0 ]]; then
		kdialog --icon "update-none" --title "Software Updates" --passivepopup "<big><b>System is up to date\!</b></big>"
	elif [[ "$update_count" -eq 1 ]]; then
		local update_list="$(cat "$update_list")"
		yad --form --columns=2 --title "Software Updates" --text="\nWould you like to perform the <b>software update below</b>,\nusing <b>one of the following applications</b>\?\n____________________________________________________________\n\n<i>${update_list}</i>\n" --image "update-low" --image-on-top \
			--field="<b>Discover</b>!system-software-update!Perform system software updates offline :fbtn" updater_discover \
			--field="<b>Konsole</b>!akonadiconsole!Perform software updates in terminal :fbtn" updater_konsole \
			--field="<b>Apper</b>!svn-update!Launch package manager :fbtn" updater_apper \
			--button="Close!dialog-ok" \
			--geometry="430x100+1265+25"
	elif [[ "$update_count" -le 5 ]]; then
		local update_list="$(cat "$update_list")"
		yad --form --columns=2 --title "Software Updates" --text="\nWould you like to perform the <b>${update_count} software updates</b> below,\nusing <b>one of the following applications</b>\?\n____________________________________________________________\n<i>${update_list}</i>" --image "update-low" --image-on-top \
			--field="<b>Discover</b>!system-software-update!Perform system software updates offline :fbtn" updater_discover \
			--field="<b>Konsole</b>!akonadiconsole!Perform software updates in terminal :fbtn" updater_konsole \
			--field="<b>Apper</b>!svn-update!Launch package manager :fbtn" updater_apper \
			--button="Close!dialog-ok" \
			--geometry="430x250+1265+25"
	elif [[ "$update_count" -le 15 ]]; then
		local update_list="$(cat "$update_list")"
		yad --form --columns=2 --title "Software Updates" --text="\nWould you like to perform the <b>${update_count} software updates</b> below,\nusing <b>one of the following applications</b>\?\n____________________________________________________________\n<i>${update_list}</i>" --image "update-medium" --image-on-top \
			--field="<b>Apper</b>!svn-update!Launch package manager :fbtn" updater_apper \
			--field="<b>Discover</b>!system-software-update!Perform system software updates offline :fbtn" updater_discover \
			--field="<b>Konsole</b>!akonadiconsole!Perform software updates in terminal :fbtn" updater_konsole \
			--button="Close!dialog-ok" \
			--geometry="430x450+1265+25"
	elif [[ "$update_count" -lt 20 ]]; then
		local update_list="$(cat "$update_list")"
		yad --form --columns=2 --title "Software Updates" --text="\nWould you like to perform the <b>${update_count} software updates</b> below,\nusing <b>one of the following applications</b>\?\n____________________________________________________________\n<i>${update_list}</i>" --image "update-medium" --image-on-top \
			--field="<b>View List</b>!format-list-unordered!Display a full list of pending updates :fbtn" view_list \
			--field="<b>Apper</b>!svn-update!Launch package manager :fbtn" updater_apper \
			--field="<b>Discover</b>!system-software-update!Perform system software updates offline :fbtn" updater_discover \
			--field="<b>Konsole</b>!akonadiconsole!Perform software updates in terminal :fbtn" updater_konsole \
			--button="Close!dialog-ok" \
			--geometry="430x550+1265+25"
	elif [[ "$update_count" -ge 20 ]]; then
		local update_list="$(cat "$update_list" | head -n 20)"
		yad --form --columns=2 --title "Software Updates" --text="\nWould you like to perform the <b>${update_count} software updates</b> available,\nusing <b>one of the following applications</b>\?\n____________________________________________________________\n<i>${update_list}</i>\n<b>.........</b>" --image "update-high" --image-on-top \
			--field="<b>View List</b>!format-list-unordered!Display a full list of pending updates :fbtn" view_list \
			--field="<b>Apper</b>!svn-update!Launch package manager :fbtn" updater_apper \
			--field="<b>Discover</b>!system-software-update!Perform system software updates offline :fbtn" updater_discover \
			--field="<b>Konsole</b>!akonadiconsole!Perform software updates in terminal :fbtn" updater_konsole \
			--button="Close!dialog-ok" \
			--geometry="430x750+1265+25"
	fi
}

updater_discover() {
	plasma-discover --mode update
	status_init
}

updater_apper() {
	sudo_password="$(kdialog --title "Authentication Required" --password "<b><big>Apper Package Manager</big></b><br><br>An application is attempting to perform an action that requires admin privileges. Authentication is required to perform this action." -- : 2>/dev/null)"
	if [[ ${?} != 0 || -z "${sudo_password}" ]]; then
		exit 4
	fi
	if ! sudo -kSp '' [ 1 ] <<<"${sudo_password}" 2>/dev/null; then
		exit 4
	fi
	sudo -Sp '' apper --updates <<<"${sudo_password}"
	status_init
}

updater_konsole() {
	konsole -e "bash -c 'sudo apt full-upgrade; $SHELL'" > /dev/null 2>&1
	status_init
}

main() {
	if [[ $# -eq 0 ]]; then
		echo "Usage: <script> <function>"
		kdialog --title "Software Updates" --passivepopup "<b>ERROR</b>: <i>command</i> and <i>function</i> required" --icon "system-software-update" &
		exit 1
	fi

	local func_name=$1
	shift

	if typeset -f "$func_name" > /dev/null; then
		local update_lst="$HOME/.local/share/plasmoid-scriptinator-software-updates-list.txt"
		local update_list="$HOME/.local/share/plasmoid-scriptinator-software-updates-list-detailed.txt"
		local update_count="$(cat "$update_lst" | wc -l)"
		local my_password="$(cat "$HOME/.local/bin/.pwd")"
		"$func_name"
	else
		echo "Error: Function '$func_name' not found"
		kdialog --title "Software Updates" --passivepopup "<b>ERROR</b>: Function <i>$func_name</i> not found" --icon "system-software-update" &
		exit 1
	fi

}

main "$@"
