#!/bin/sh

# Info
export TOPIC=Sounds/Systemsounds
export MIBPATH=/net/rcc/mnt/efs-system/opt/audio/tones
export SDPATH=$TOPIC
export TYPE="folder"

echo "This script will dump system sounds"

# Include dump script
. /eso/hmi/engdefs/scripts/mqb/util_dump.sh
