#!/bin/sh

# Info
export TOPIC=Bundles
export MIBPATH=/eso/bundles/*.jar
export SDPATH=$TOPIC
export TYPE="file"

echo "This script will dump all files in /eso/bundles/"

# Include dump script
. /eso/hmi/engdefs/scripts/mqb/util_dump.sh
