#!/bin/sh

# Info
export TOPIC=Firewall
export MIBPATH=/net/mmx/mnt/system/etc/pf.conf
export SDPATH=$TOPIC
export TYPE="file"

echo "This script will dump the pf (firewall) config."

# Include dump script
. /eso/hmi/engdefs/scripts/mqb/util_dump.sh
