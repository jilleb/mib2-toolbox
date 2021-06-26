#!/bin/sh
# Info
export TOPIC=GreenMenu
export MIBPATH=/net/mmx/mnt/app/eso/hmi/engdefs
export SDPATH=$TOPIC
export TYPE="folder"

echo "This script will copy custom ESD(Green Menu) files from GreenMenu folder on your SD to the unit."

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

#include script to make backup
. /eso/hmi/engdefs/scripts/mqb/util_backup.sh

# Include writeable system mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsys.sh

# Copying files
cp $VOLUME/Custom/$TOPIC/*.esd /eso/hmi/engdefs/
cp $VOLUME/Custom/$TOPIC/scripts/*.sh /eso/hmi/engdefs/scripts/mqb/
chmod a+rwx /eso/hmi/engdefs/scripts/mqb/*

# Include back to read-only system mount script
. /eso/hmi/engdefs/scripts/mqb/util_unmountsys.sh

echo "Done. Please restart green menu."

exit 0
