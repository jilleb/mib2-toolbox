#!/bin/sh

# Info
export TOPIC=CarPlay
export MIBPATH=/net/mmx/mnt/system/etc/ipod.cfg
export SDPATH=$TOPIC
export TYPE="file"

echo "This script will dump ipod.cfg"

# Include dump script
. /eso/hmi/engdefs/scripts/mqb/util_dump.sh
