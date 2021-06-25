#!/bin/ksh
# This script will will install skin files and ambienceColorMaps
# Author: lprot modified to MHI by Olli
########################################################################################

echo "This script will install custom skins (images.mcf) and/or"
echo "ambienceColorMap.res from Custom/Skinfiles/skinX folders"
echo

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

# Checkup for brands and if this is the correct script for the brand
if [[ $BRAND == "Audi" || $BRAND == "Porsche"  || $BRAND == "Bentley" || $BRAND == "Lamborghini" ]]; then
	echo "Wrong brand for this script detected: $BRAND. Aborting"
	exit 0
	
elif [[ $BRAND == "Volkswagen" || $BRAND == "Skoda" || $BRAND == "Seat" ]]; then
	echo "Correct brand for this script detected: $BRAND. Moving on..."
	
else
	echo "No brand detected. Aborting"
	exit 0
fi

# Include SD card mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh

export TYPE="file"
export MOUNTPOINT=1
WRITE=""

# Copy custom file(s) to unit
echo "Checking changes, please wait..."
for skin_folder in $VOLUME/Custom/Skinfiles/skin*; do
	#Extract skin folder name
	FOLDER=${skin_folder##*/}
	if [ -f $skin_folder/images.mcf ]; then
		export MIBPATH=/eso/hmi/lsd/Resources/$FOLDER/images.mcf
		if [ -n "$(cmp $skin_folder/images.mcf $MIBPATH)" ]; then
			export TOPIC=Skinfiles/$FOLDER
			export BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC
			# Make backup
			. /eso/hmi/engdefs/scripts/mqb/util_backup.sh
			if [ -z "$WRITE" ]; then
				# Mount system partition in read/write mode
				. /eso/hmi/engdefs/scripts/mqb/util_mountsys.sh
				WRITE=1
			fi
			echo "Replacing $FOLDER/images.mcf..."
			cp -f $skin_folder/images.mcf $MIBPATH
			echo "Done."
		fi
	fi
	if [ -f $skin_folder/ambienceColorMap.res ]; then
		export MIBPATH=/eso/hmi/lsd/Resources/$FOLDER/ambienceColorMap.res
		if [ -n "$(cmp $skin_folder/ambienceColorMap.res $MIBPATH)" ]; then
			export TOPIC=Skinfiles/$FOLDER
			export BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC
			# Make backup
			. /eso/hmi/engdefs/scripts/mqb/util_backup.sh
			if [ -z "$WRITE" ]; then
				# Mount system partition in read/write mode
				. /eso/hmi/engdefs/scripts/mqb/util_mountsys.sh
				WRITE=1
			fi
			echo "Replacing $FOLDER/ambienceColorMap.res..."
			cp -f $skin_folder/ambienceColorMap.res $MIBPATH
			echo "Done."
		fi
	fi
#	if [ -f $skin_folder/info.txt ]; then
#		export MIBPATH=/tsd/hmi/Resources/$FOLDER/info.txt
#		if [ -n "$(cmp $skin_folder/info.txt $MIBPATH)" ]; then
#			export TOPIC=skins/$FOLDER
#			export SDPATH=$TOPIC/info.txt
#			# Make backup
#			. /tsd/etc/persistence/esd/scripts/util_backup.sh
#			if [ -z "$WRITE" ]; then
#				# Mount system partition in read/write mode
#				. /tsd/etc/persistence/esd/scripts/util_mount.sh
#				WRITE=1
#			fi
#			echo "Replacing $FOLDER/info.txt..."
#			cp -f $skin_folder/info.txt $MIBPATH
#			echo "Done."
#		fi
#	fi
done

if [ -n "$WRITE" ]; then
	# Mount system partition in read/only mode
	. /eso/hmi/engdefs/scripts/mqb/util_unmountsys.sh
	echo
	echo "Done. Please restart the unit."
else
	echo
	echo "Done. No new skins/ambienceColorMaps were found."
fi
exit 0