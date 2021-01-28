#!/bin/sh
export TOPIC=Radiostations
export MIBPATH=/net/mmx/mnt/boardbook/RSDB/VW_STL_DB.sqlite
export SDPATH=/$TOPIC/VW_STL_DB.sqlite 
export DESCRIPTION="This script will install a new Radiostation database"
export TYPE="file"
echo $DESCRIPTION
. /eso/hmi/engdefs/scripts/mqb/util_info.sh
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi
export BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC/
. /eso/hmi/engdefs/scripts/mqb/util_backup.sh
. /eso/hmi/engdefs/scripts/mqb/util_copy.sh

echo "Done. Now restart the unit."
exit 0
