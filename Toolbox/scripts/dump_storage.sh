#!/bin/sh

# Info
export TOPIC=Storage
export MIBPATH=/net/rcc/mnt/efs-persist/*.raw
export SDPATH=$TOPIC
export TYPE="file"

echo "This script will dump storage1.raw and storage2.raw"

# Include dump script
. /eso/hmi/engdefs/scripts/mqb/util_dump.sh
