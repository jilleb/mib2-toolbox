#!/bin/sh

# Info
export TOPIC=Splashscreen
export MIBPATH=/eso/hmi/splashscreen/*.*
export SDPATH=$TOPIC
export TYPE="file"

echo "This script will dump all startup screens"

# Include dump script
. /eso/hmi/engdefs/scripts/mqb/util_dump.sh
