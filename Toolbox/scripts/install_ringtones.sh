#!/bin/sh
# Info
export TOPIC=Ringtones
export MIBPATH=/net/mmx/mnt/app/hb/ringtones
export SDPATH=$TOPIC/*.wav
export TYPE="file"

echo "This script will install Ringtones"

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

#include script to make backup
. /eso/hmi/engdefs/scripts/mqb/util_backup.sh

# include script tocopy file(s) and remount everything as read-only again
. /eso/hmi/engdefs/scripts/mqb/util_copy.sh

echo "Done. Now restart the unit."
exit 0
