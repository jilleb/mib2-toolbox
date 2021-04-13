#!/bin/sh
export TOPIC=Skinfiles
export MIBPATH=/eso/hmi/lsd/images
export BRAND="$(/eso/bin/apps/pc i:0x286f058c:10 2> /dev/null)"
if [ $BRAND == "1" ]; then
	export BRAND=Volkswagen
elif [ $BRAND == "2" ]; then
	export BRAND=Audi
elif [ $BRAND == "3" ]; then
	export BRAND=Skoda
elif [ $BRAND == "4" ]; then
	export BRAND=Seat
elif [ $BRAND == "5" ]; then
	export BRAND=Porsche
elif [ $BRAND == "6" ]; then
	export BRAND=Bentley
elif [ $BRAND == "7" ]; then
	export BRAND=Lamborghini
fi
export SDPATH=/$TOPIC/$BRAND
export DESCRIPTION="This script will install $TOPIC"
export TYPE="folder"

echo $DESCRIPTION

. /eso/hmi/engdefs/scripts/mqb/util_info.sh
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi

# Checkup for brands and if this is the correct script for the brand
if [ $BRAND == "Volkswagen" ]; then
	echo "Wrong brand for this script detected: $BRAND. Aborting"
	exit 0
elif [ $BRAND == "Audi" ]; then
	echo "Correct brand for this script detected: $BRAND. Moving on..."
elif [ $BRAND == "Skoda" ]; then
	echo "Wrong brand for this script detected: $BRAND. Aborting"
	exit 0
elif [ $BRAND == "Seat" ]; then
	echo "Wrong brand for this script detected: $BRAND. Aborting"
	exit 0
elif [ $BRAND == "Porsche" ]; then
	echo "Correct brand for this script detected: $BRAND. Moving on..."
elif [ $BRAND == "Bentley" ]; then
	echo "Correct brand for this script detected: $BRAND. Moving on..."
elif [ $BRAND == "Lamborghini" ]; then
	echo "Correct brand for this script detected: $BRAND. Moving on..."
fi

#Make backup folder
export BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC/$BRAND

#include script to make backup
. /eso/hmi/engdefs/scripts/mqb/util_backup.sh

# include script tocopy file(s)
# remount everything as read-only again
. /eso/hmi/engdefs/scripts/mqb/util_copy.sh

echo "Done. Now restart the unit."
exit 0
