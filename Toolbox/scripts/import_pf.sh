#!/bin/sh
SCRIPTDIR=$( cd -P -- "$(dirname -- "$(command -v -- "$_")")" && pwd -P )

export TOPIC=Firewall
export MIBPATH=/net/mmx/mnt/system/etc/pf.conf
export SDPATH=/$TOPIC/pf.conf
export DESCRIPTION="This script will replace the pf.conf file with the pf.conf file in Custom/${TOPIC}/pf.conf."
export TYPE="file"


echo $DESCRIPTION


. ${SCRIPTDIR}/util_info.sh
. ${SCRIPTDIR}/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi

#Make backup folder
export BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC/

#include script to make backup
. ${SCRIPTDIR}/util_backup.sh

# include script tocopy file(s)
# remount everything as read-only again
. ${SCRIPTDIR}/util_copy.sh


echo "Done. Now restart the unit."
exit 0