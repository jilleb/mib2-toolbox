#!/bin/sh
# Info
export TOPIC=FEC
export MIBPATH=/net/rcc/mnt/efs-persist/FEC/FecContainer.fec
export SDPATH=$TOPIC/FecContainer.fec
export TYPE="file"

echo "This script will install a new FecContainer.fec"

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

#include script to make backup
. /eso/hmi/engdefs/scripts/mqb/util_backup.sh

# include script tocopy file(s) and remount everything as read-only again
. /eso/hmi/engdefs/scripts/mqb/util_copy.sh

echo "Done. Now restart the unit."
exit 0