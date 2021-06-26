#!/bin/sh
# Info
export TOPIC=Menumode
export MIBPATH=/net/mmx/mnt/app/eso/hmi/lsd/Resources
export FILENAME=info.txt
export TYPE="file"

echo "This script will patch info.txt of the skins to activate menumode switcher"

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

echo "Start patching"

CMP="/eso/hmi/engdefs/scripts/mqb/sbin/cmp"
WRITE=""

for skin_folder in $MIBPATH/skin*; do
	#Extract skin folder name
	FOLDER=${skin_folder##*/}
	if [ -f $skin_folder/$FILENAME ]; then
		export MIBPATH=/net/mmx/mnt/app/eso/hmi/lsd/Resources/$FOLDER/$FILENAME
		if [ -n "$($CMP $skin_folder/images.mcf $MIBPATH)" ]; then
			export TOPIC=Skinfiles/$FOLDER
			export BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC
			# Make backup
			. /eso/hmi/engdefs/scripts/mqb/util_backup.sh
			if [ -z "$WRITE" ]; then
				# Mount system partition in read/write mode
				. /eso/hmi/engdefs/scripts/mqb/util_mountsys.sh
				WRITE=1
			fi
			echo "Patching $FOLDER/$FILENAME..."
			sed -i 's/UserSwitchableMenuMode=false/UserSwitchableMenuMode=true/g' $MIBPATH
			echo "Done."
		fi
	fi
done

if [ -n "$WRITE" ]; then
	# Mount system partition in read/only mode
	. /eso/hmi/engdefs/scripts/mqb/util_unmountsys.sh
	echo "---------------------------"
	echo "Done patching. After restart, you will have an additional setting in the SCREEN settings."
else
	echo "ERROR: Files already patched or not found."
fi

exit 0
