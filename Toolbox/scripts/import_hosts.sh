#!/bin/sh
# Info
export TOPIC=Hosts
export MIBPATH=/net/mmx/mnt/system/etc/hosts
export SDPATH=$TOPIC/hosts.txt
export TYPE="file"

echo "This script will replace the hosts file with the hosts file in Custom/Hosts/hosts.txt."

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

#include script to make backup
. /eso/hmi/engdefs/scripts/mqb/util_backup.sh

# include script tocopy file(s) and remount everything as read-only again
. /eso/hmi/engdefs/scripts/mqb/util_copy.sh

echo "Done. Now restart the unit."
exit 0