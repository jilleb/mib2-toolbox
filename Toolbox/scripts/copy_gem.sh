#!/bin/sh
export TOPIC=GEM
export MIBPATH=/net/mmx/mnt/app/eso/hmi/lsd/jars/GEM.jar
export SDPATH=$TOPIC/GEM.jar
export TYPE="file"
#export MOUNTPOINT=4

echo "This script will install GEM.jar"

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

#include script to make backup
. /eso/hmi/engdefs/scripts/mqb/util_backup.sh

# include script tocopy file(s) and remount everything as read-only again
. /eso/hmi/engdefs/scripts/mqb/util_copy.sh

echo "Done. Please restart the green menu."
exit 0