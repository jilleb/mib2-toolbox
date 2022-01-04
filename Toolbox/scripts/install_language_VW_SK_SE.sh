#!/bin/ksh
# This script will will install language files
# Author: lprot modified to MHI by Olli
################################################################
#Info
export TOPIC=Language

echo "This script will install custom language .res files."
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
CMP="/eso/hmi/engdefs/scripts/mqb/sbin/cmp"
WRITE=""

# Copy custom file(s) to unit
echo "Checking changes, please wait..."
for skin_folder in $VOLUME/Custom/Language/skin*; do
	#Extract skin folder name
	FOLDER=${skin_folder##*/}
	for language_file in $skin_folder/i18n/*.res; do
		#Extract language file name
		FILE=${language_file##*/}
		if [ -f $language_file ]; then
			export MIBPATH=/net/mmx/mnt/app/eso/hmi/lsd/Resources/$FOLDER/i18n/$FILE
			if [ -n "$($CMP $language_file $MIBPATH)" ]; then
				export TOPIC=Language/$FOLDER
				export BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC
				# Make backup
				. /eso/hmi/engdefs/scripts/mqb/util_backup.sh
				if [ -z "$WRITE" ]; then
					# Mount system partition in read/write mode
					. /eso/hmi/engdefs/scripts/mqb/util_mountsys.sh
					WRITE=1
				fi
				echo "Replacing $FOLDER/$FILE..."
				cp -f $language_file $MIBPATH
				echo "Done."
			fi
		fi
	done
done

if [ -n "$WRITE" ]; then
	# Mount system partition in read/only mode
	. /eso/hmi/engdefs/scripts/mqb/util_unmountsys.sh
	echo
	echo "Done. Please restart the unit."
else
	echo
	echo "Done. No new language files were found."
fi
exit 0