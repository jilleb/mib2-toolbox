#!/bin/sh
<<<<<<< Updated upstream
=======
# This script will install car-skin files only for AUDI, BENTLEY, LAMBORGHINI and PORSCHE
# Author:  Olli
########################################################################################

# Info
>>>>>>> Stashed changes
export TOPIC=Skinfiles
export MIBPATH=/eso/content.kzb
export DESCRIPTION="This script will install $TOPIC"
export TYPE="file"
<<<<<<< Updated upstream

echo $DESCRIPTION

. /eso/hmi/engdefs/scripts/mqb/util_info.sh
export SDPATH=/$TOPIC/$BRAND-Car

. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi

=======
export MOUNTPOINT=1

echo $DESCRIPTION

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh
export SDPATH=/$TOPIC/$BRAND-Car

>>>>>>> Stashed changes
# Checkup for brands and if this is the correct script for the brand
if [[ $BRAND == "Volkswagen" || $BRAND == "Skoda" || $BRAND == "Seat" ]]; then
	echo "Wrong brand for this script detected: $BRAND. Aborting"
	exit 0
	
elif [[ $BRAND == "Audi" || $BRAND == "Porsche"  || $BRAND == "Bentley" || $BRAND == "Lamborghini" ]]; then
	echo "Correct brand for this script detected: $BRAND. Moving on..."
	
else
	echo "No brand detected. Aborting"
	exit 0
fi

<<<<<<< Updated upstream
#Make backup folder
export BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC/$BRAND-Car

#include script to make backup
. /eso/hmi/engdefs/scripts/mqb/util_backup.sh

# include script tocopy file(s)
# remount everything as read-only again
=======
# Include SD card mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh

# Define backup folder
export BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC/$BRAND-Car

# Include script to make backup
. /eso/hmi/engdefs/scripts/mqb/util_backup.sh

# Include script to copy file(s)
>>>>>>> Stashed changes
. /eso/hmi/engdefs/scripts/mqb/util_copy.sh

echo "Done. Now restart the unit."
exit 0
