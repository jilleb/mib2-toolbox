#!/bin/sh

# Info
export TOPIC=Persistence
export MIBPATH=/var/fw/persistence.sqlite
export SDPATH=$TOPIC
export TYPE="file"

echo "This script will dump the persistence database"

# Include dump script
. /eso/hmi/engdefs/scripts/mqb/util_dump.sh 
