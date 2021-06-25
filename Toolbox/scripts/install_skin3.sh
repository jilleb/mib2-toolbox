#!/bin/sh
# This script will will install skin files
# Author: Jille
########################################################################################

# Info
export SKINNAME=skin3
export TOPIC=Skinfiles
export MIBPATH=/eso/hmi/lsd/Resources/$SKINNAME/images.mcf
export SDPATH=/$TOPIC/$SKINNAME/images.mcf
export DESCRIPTION="This script will install $SKINNAME"
export TYPE="file"
export MOUNTPOINT=1

echo $DESCRIPTION

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

# Include SD card mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh

# Define backup folder
export BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC/$SKINNAME

# Include script to make backup
. /eso/hmi/engdefs/scripts/mqb/util_backup.sh

# Include script to copy file(s)
. /eso/hmi/engdefs/scripts/mqb/util_copy.sh

echo "Done. Now restart the unit."

exit 0