#!/bin/sh
export TOPIC=FEC
export MIBPATH=/net/rcc/mnt/efs-persist/FEC/FecContainer.fec
export SDPATH=$TOPIC/FecContainer.fec
export DESCRIPTION="This script will install a new FecContainer.fec"
export TYPE="file"
echo $DESCRIPTION
#include script to show and set unit info to variables $FAZIT and $VERSION
. /eso/bin/PhoneCustomer/default/util_info.sh
#include script to mount the sd-card and set variable $VOLUME as the SD-location
. /eso/bin/PhoneCustomer/default/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi
#Make backup folder
export BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC/
#include script to make backup
. /eso/bin/PhoneCustomer/default/util_backup.sh
# include script tocopy file(s)
# remount everything as read-only again
. /eso/bin/PhoneCustomer/default/util_copy.sh
echo "Done. Now restart the unit."
exit 0