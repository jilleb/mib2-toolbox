#!/bin/sh
# This script is meant to copy all  files from the source to MIB and backup the original ones
# author: Jille
#############################################################################################
# Info
export TOPIC=LSD
export MIBPATH=/net/mmx/ifs/lsd.jxe
export MIBPATH2=/net/mmx/mnt/app
export SDPATH=$TOPIC/lsd.jxe
export TYPE="file"

echo "This script will copy custom  lsd.jxe from SD to your unit."

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

#include script to make backup
. /eso/hmi/engdefs/scripts/mqb/util_backup.sh

# include script tocopy file(s) and remount everything as read-only again
. /eso/hmi/engdefs/scripts/mqb/util_copy.sh

echo "Done. Now restart the unit."
exit 0
