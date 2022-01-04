#!/bin/sh
# Info 
export TOPIC=Firewall
export MIBPATH=/net/mmx/mnt/system/etc/pf.conf
export SDPATH=$TOPIC/pf.conf
export TYPE="file"

echo "This script will replace the pf.conf file with the pf.conf file in Custom/${TOPIC}/pf.conf."

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

#include script to make backup
. /eso/hmi/engdefs/scripts/mqb/util_backup.sh

# include script tocopy file(s) and remount everything as read-only again
. /eso/hmi/engdefs/scripts/mqb/util_copy.sh

echo "Done. Now restart the unit."
exit 0