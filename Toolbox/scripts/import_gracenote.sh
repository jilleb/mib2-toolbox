#!/bin/sh
# Info
export TOPIC=Gracenote
export MIBPATH=/net/mmx/mnt/gracenotedb
export SDPATH=$TOPIC
export TYPE="folder"

echo "This script will import Gracenote files"

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

#include script to make backup
. /eso/hmi/engdefs/scripts/mqb/util_backup.sh

# include script tocopy file(s) and remount everything as read-only again
. /eso/hmi/engdefs/scripts/mqb/util_copy.sh

echo "Done. Now restart the unit."
exit 0
