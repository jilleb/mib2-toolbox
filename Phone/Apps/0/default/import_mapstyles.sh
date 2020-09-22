#!/bin/sh
export TOPIC=Mapstyles
export MIBPATH=/net/mmx/mnt/navigation/app/resources/
export SDPATH=/$TOPIC/
export DESCRIPTION="This script will replace mapstyles"
export TYPE="folder"


echo $DESCRIPTION


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
