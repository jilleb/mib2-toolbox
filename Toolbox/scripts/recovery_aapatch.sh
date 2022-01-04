#!/bin/sh
# This script is meant to recover gal.json
# author: Jille & Olli
##########################################
# Info
export TOPIC=AndroidAuto
export MIBPATH=/net/mmx/etc/eso/production/gal.json
export SDPATH=$TOPIC/gal.json
export TYPE="file"

echo "This script will recover patched AA config files."

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

# Include recovery script
. /eso/hmi/engdefs/scripts/mqb/util_recovery.sh
