#!/bin/sh

# Info
export TOPIC=Sounds/Ringtones
export MIBPATH=/net/mmx/mnt/app/hb/ringtones
export SDPATH=$TOPIC
export TYPE="folder"

echo "This script will dump telephone ringtones"

# Include dump script
. /eso/hmi/engdefs/scripts/mqb/util_dump.sh
