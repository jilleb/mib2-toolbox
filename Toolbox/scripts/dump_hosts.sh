#!/bin/sh

# Info
export TOPIC=Hosts
export MIBPATH=/net/mmx/mnt/system/etc/hosts
export SDPATH=$TOPIC
export TYPE="file"

echo "This script will dump the hosts file."

# Include dump script
. /eso/hmi/engdefs/scripts/mqb/util_dump.sh
