#!/bin/sh

# Info
export TOPIC=Engdefs
export MIBPATH=/eso/hmi/engdefs
export SDPATH=$TOPIC
export TYPE="folder"

echo "This script will dump all engdefs folder"

# Include dump script
. /eso/hmi/engdefs/scripts/mqb/util_dump.sh
