#!/bin/sh

# Info
export TOPIC=GEM
export MIBPATH=/eso/hmi/lsd/jars/GEM.jar
export SDPATH=$TOPIC
export TYPE="file"

echo "This script will dump GEM.jar"

# Include dump script
. /eso/hmi/engdefs/scripts/mqb/util_dump.sh
