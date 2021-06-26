#!/bin/sh
export TOPIC=Radiostations
export MIBPATH=/net/mmx/mnt/boardbook/RSDB/VW_STL_DB.sqlite
export SDPATH=$TOPIC/VW_STL_DB.sqlite 
export TYPE="file"

echo "This script will install a new Radiostation database"

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

#include script to make backup
. /eso/hmi/engdefs/scripts/mqb/util_backup.sh

# include script tocopy file(s) and remount everything as read-only again
. /eso/hmi/engdefs/scripts/mqb/util_copy.sh

echo "Done. Now restart the unit."
exit 0
