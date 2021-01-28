#!/bin/sh

export TOPIC=Splashscreen
export MIBPATH=/eso/hmi/splashscreen/*.canim
export SDPATH=/$TOPIC/*.canim
export DESCRIPTION="This script will copy custom canim files from Splashscreen folder on your SD to the unit."
export TYPE="file"


echo $DESCRIPTION


. /eso/hmi/engdefs/scripts/mqb/util_info.sh

. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi

#Make backup folder
export BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC/

#include script to make backup
. /eso/hmi/engdefs/scripts/mqb/util_backup.sh

# include script tocopy file(s)
# remount everything as read-only again
. /eso/hmi/engdefs/scripts/mqb/util_copy.sh


echo "Done. Now restart the unit."
exit 0