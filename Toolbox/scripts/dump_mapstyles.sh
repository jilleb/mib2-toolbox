#!/bin/sh

# Info
export TOPIC=Mapstyles
export MIBPATH=/net/mmx/mnt/app/navigation/resources/app
export SDPATH=$TOPIC
export TYPE="folder"

echo "This script will dump Mapstyles"

# Include dump script
. /eso/hmi/engdefs/scripts/mqb/util_dump.sh
