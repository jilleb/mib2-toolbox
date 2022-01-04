#!/bin/sh
# This script is meant to recover language files
# Author: Jille & Olli & lprot
################################################
# Info
export TOPIC=Language

echo "This script will recover the backupped language files."

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

# Include SD card mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh

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

# Backup folder definition
BACKUP=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC
export MIBPATH=/net/mmx/mnt/app/eso/hmi/lsd/Resources/

# Include writeable system mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsys.sh

# Starting the recovery process
echo "Recovering all language files from backup folder to the unit"
echo "Please be patient..."
sleep 1

# Recover files
for skin_folder in $BACKUP/skin*; do
	#Extract skin folder name
	FOLDER=${skin_folder##*/}
	for language_file in $skin_folder/*.res; do
		#Extract language file name
		FILE=${language_file##*/}
		if [ -f $language_file ]; then
			echo "Recovering $FOLDER/i18n/$FILE..."
			cp -f $language_file $MIBPATH/$FOLDER/i18n/$FILE
			echo "Done."
			RECOVERY=yes
		fi
	done
done

# Include back to read-only system mount script
. /eso/hmi/engdefs/scripts/mqb/util_unmountsys.sh

# Conclusion
if [ -n "$RECOVERY" ]; then
	echo "Done. Please restart the unit"
else
	echo "No backups found. Nothing to recover"
fi

exit 0
