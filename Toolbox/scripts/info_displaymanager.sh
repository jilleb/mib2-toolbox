#!/bin/sh
# Info
export TOPIC=Displaymanager
export SDPATH=$TOPIC
export TYPE="file"
export LD_LIBRARY_PATH=/eso/lib
export IPL_CONFIG_DIR=/etc/eso/production

echo "This script will show and dump information about the displays"

# Include dump script
. /eso/hmi/engdefs/scripts/mqb/util_dump.sh
