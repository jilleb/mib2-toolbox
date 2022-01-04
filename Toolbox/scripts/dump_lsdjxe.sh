#!/bin/sh

# Info
export TOPIC=LSD
export MIBPATH=/net/mmx/ifs/lsd.jxe
export SDPATH=$TOPIC
export TYPE="file"

echo "This script will dump lsd.jxe"

# Include dump script
. /eso/hmi/engdefs/scripts/mqb/util_dump.sh
