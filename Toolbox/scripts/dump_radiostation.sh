#!/bin/sh

# Info
export TOPIC=Radiostations
export MIBPATH=/net/mmx/mnt/boardbook/RSDB/VW_STL_DB.sqlite
export SDPATH=$TOPIC
export TYPE="file"

echo "This script will dump Radio Station DB"

# Include dump script
. /eso/hmi/engdefs/scripts/mqb/util_dump.sh
