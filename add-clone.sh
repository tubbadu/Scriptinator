
name=$1
comment=$2
icon=$3
plugin_name=$4

if [ -z "$name" ]
then
	echo "error: NAME is not defined"
	exit 1
fi

if [ -z "$icon" ]
then
	echo "error: ICON is not defined"
	exit 1
fi

if [ -z "$plugin_name" ]
then
	echo "error: PLUGIN_NAME is not defined"
	exit 1
fi

if [[ ! "$plugin_name" =~ ^[[:alnum:]]+$ ]];then
	echo "error: PLUGIN_NAME contains forbidden characters"
	exit 1
fi

templatefile="$HOME/.local/share/plasma/plasmoids/com.github.scriptinator/tray-metadata.desktop"
newdir="$HOME/.local/share/plasma/plasmoids/com.github.scriptinator.$plugin_name"
newfile="$newdir/metadata.desktop"

if [ ! -f "$templatefile" ]; then
	echo "error: $templatefile not found"
	exit 1
fi

if [ -d "$newdir" ]; then
	echo "error: $newdir already exists"
	exit 1
fi

if [ ! -f "$templatefile" ]; then
	echo "error: $templatefile not found"
	exit 1
fi

echo "all right!"

#create directory in the correct location
mkdir $newdir

# copy the file in the correct location
cp $templatefile $newfile

# replace info in the new file
sed -i "s/\$NAME/$name/g" $newfile
sed -i "s/\$COMMENT/$comment/g" $newfile
sed -i "s/\$ICON/$icon/g" $newfile
sed -i "s/\$PLUGIN_NAME/$plugin_name/g" $newfile

echo "done"