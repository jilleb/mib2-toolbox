#!/bin/sh
export TOPIC=Hosts
export MIBPATH=/net/mmx/mnt/system/etc/hosts
export SDPATH=/$TOPIC/hosts.txt
export DESCRIPTION="This script will replace the hosts file with the hosts file in Custom/Hosts/hosts.txt."
export TYPE="file"


echo $DESCRIPTION


. /eso/bin/PhoneCustomer/default/util_info.sh

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