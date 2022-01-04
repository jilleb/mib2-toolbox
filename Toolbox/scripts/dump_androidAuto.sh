#!/bin/sh

# Info
export TOPIC=AndroidAuto
export MIBPATH=/etc/eso/production/gal.json
export SDPATH=$TOPIC
export TYPE="file"

echo "This script will dump Android Auto config file"

# Include dump script
. /eso/hmi/engdefs/scripts/mqb/util_dump.sh
