#!/bin/sh

# Info
export TOPIC=FEC
export MIBPATH=/net/rcc/mnt/efs-persist/FEC
export SDPATH=$TOPIC
export TYPE="folder"

echo "This script will dump TTS-audio alerts"

# Include dump script
. /eso/hmi/engdefs/scripts/mqb/util_dump.sh
