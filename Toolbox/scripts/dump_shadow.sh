#!/bin/sh

# Info
export TOPIC=Shadowfile
export MIBPATH=/net/mmx/mnt/system/etc/shadow
export SDPATH=$TOPIC
export TYPE="file"

echo "This script will dump TTS-audio alerts"

# Include dump script
. /eso/hmi/engdefs/scripts/mqb/util_dump.sh
