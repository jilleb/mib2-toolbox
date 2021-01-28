#!/bin/sh
export SKINNAME=skin3
export TOPIC=Skinfiles
export MIBPATH=/eso/hmi/lsd/Resources/$SKINNAME/ambienceColorMap.res
export SDPATH=/$TOPIC/$SKINNAME/ambienceColorMap.res
export DESCRIPTION="This script will install colormaps for $SKINNAME"
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
export BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC/$SKINNAME

#include script to make backup
. /eso/hmi/engdefs/scripts/mqb/util_backup.sh


# include script tocopy file(s)
# remount everything as read-only again
. /eso/hmi/engdefs/scripts/mqb/util_copy.sh


echo "Done. Now restart the unit."
exit 0
