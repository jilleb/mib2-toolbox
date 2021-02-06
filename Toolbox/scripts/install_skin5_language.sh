#!/bin/sh
export SKINNAME=skin5
export TOPIC=Language
export MIBPATH=/eso/hmi/lsd/Resources/$SKINNAME/i18n/*.res
export SDPATH=/$TOPIC/$SKINNAME/*.res
export DESCRIPTION="This script will copy and replace language files"
export TYPE="file"

echo $DESCRIPTION
. /eso/hmi/engdefs/scripts/mqb/util_info.sh
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi

export BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC/$SKINNAME
. /eso/hmi/engdefs/scripts/mqb/util_backup.sh
. /eso/hmi/engdefs/scripts/mqb/util_copy.sh
echo "Done. Now restart the unit."
exit 0