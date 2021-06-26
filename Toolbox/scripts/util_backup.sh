# MIB2 utility script, part of the MIB High toolbox.
# Coded by Jille
# This script will make a backup if it's not already there
########################################################################################

# Include SD card mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh

# Special behaviour for brand specific skin files
if [[ $BRAND == "Audi" || $BRAND == "Porsche"  || $BRAND == "Bentley" || $BRAND == "Lamborghini" ]]; then
	if [ $TYPE = "file" ]; then
		export BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC/$BRAND-Car
	else
		export BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC/$BRAND
	fi
else
	# Normal backup folder
	export BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC
fi

echo "Making $TYPE backup..."
echo "Source: $MIBPATH"
echo "Destination: Backup/$VERSION/$FAZIT/$TOPIC"

if [ "$TYPE" = "folder" ]; then
	if [ -d "${BACKUPFOLDER}" ]; then
		echo "Backup already exists. Skipping..."
	else
		echo "Copying files, please wait..."
		mkdir -p ${BACKUPFOLDER}
		touch $BACKUPFOLDER/DONT_TOUCH_ANYTHING_HERE
		cp -r ${MIBPATH}/. ${BACKUPFOLDER}
		echo "Backup is done."
	fi
else
	FILENAME=${SDPATH##*/}
	if [ -f "$BACKUPFOLDER/$FILENAME" ]; then
		echo "Backup already exists. Skipping..."
	else
		echo "Copying file, please wait..."
		mkdir -p ${BACKUPFOLDER}
		touch $BACKUPFOLDER/DONT_TOUCH_ANYTHING_HERE
		cp ${MIBPATH} ${BACKUPFOLDER}/
		echo "Backup is done."
	fi
fi
sleep .5
