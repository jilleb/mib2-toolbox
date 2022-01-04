#!/bin/sh

# Info
export TOPIC=Gracenote
export MIBPATH=/net/mmx/mnt/gracenotedb
export SDPATH=$TOPIC
export TYPE="folder"

echo "This script will dump Gracenote DB"

# Include dump script
. /eso/hmi/engdefs/scripts/mqb/util_dump.sh
