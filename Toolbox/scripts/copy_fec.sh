#!/bin/sh
export TOPIC=FEC
export MIBPATH=/net/rcc/mnt/efs-persist/FEC/FecContainer.fec
export SDPATH=$TOPIC/FecContainer.fec
export DESCRIPTION="This script will install a new FecContainer.fec"
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