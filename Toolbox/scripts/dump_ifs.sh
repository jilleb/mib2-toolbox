#!/bin/sh

# Info
export TOPIC=IFS
export MIBPATH=/net/rcc/dev/fs0
export SDPATH=$TOPIC
export TYPE="file"

echo "This script will dump the ifs-root."

# Include dump script
. /eso/hmi/engdefs/scripts/mqb/util_dump.sh
