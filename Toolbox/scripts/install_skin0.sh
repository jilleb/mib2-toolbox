#!/bin/sh
export SKINNAME=skin0
export TOPIC=Skinfiles
export MIBPATH=/eso/hmi/lsd/Resources/$SKINNAME/images.mcf
export SDPATH=/$TOPIC/$SKINNAME/images.mcf
export DESCRIPTION="This script will install $SKINNAME"
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