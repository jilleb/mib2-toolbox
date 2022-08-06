#!/bin/sh
# Info
export TOPIC=Systemsounds
export MIBPATH=/net/rcc/mnt/efs-system/opt/audio/tones
export SDPATH=$TOPIC/*.wav
export TYPE="file"

echo "This script will install Systemsounds"

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

#include script to make backup
. /eso/hmi/engdefs/scripts/mqb/util_backup.sh

# include script tocopy file(s) and remount everything as read-only again
. /eso/hmi/engdefs/scripts/mqb/util_copy.sh

echo "Done. Now restart the unit."
exit 0
