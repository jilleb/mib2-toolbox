#!/bin/sh
# Info
export TOPIC=Splashscreen
export MIBPATH=/eso/hmi/splashscreen
export SDPATH=$TOPIC/*.canim
export TYPE="file"

echo "This script will copy custom canim files from Splashscreen folder on your SD to the unit."

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

#include script to make backup
. /eso/hmi/engdefs/scripts/mqb/util_backup.sh

# include script tocopy file(s) and remount everything as read-only again
. /eso/hmi/engdefs/scripts/mqb/util_copy.sh

echo "Done. Now restart the unit."
exit 0