#!/bin/sh
# Coded by Jille & Olli
# This script will update the toolbox and also cleans up old stuff
##################################################################
# Info
export MIBPATH=/net/mmx/mnt/app/eso/hmi/engdefs/

echo "This script will update the toolbox and also cleans up old stuff"

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

# Include SD card mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh

# Include writeable system mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsys.sh

# Updating files
echo "Copying scripts from $VOLUME"
mkdir -p /eso/hmi/engdefs/scripts/mqb
cp -r $VOLUME/Toolbox/scripts/* /eso/hmi/engdefs/scripts/mqb
chmod a+rwx /eso/hmi/engdefs/scripts/mqb

echo "Copying Green Engineering Menus from $VOLUME"
cp $VOLUME/Toolbox/GEM/*.esd /eso/hmi/engdefs

# Include cleanup script
. /eso/hmi/engdefs/scripts/mqb/util_clean.sh

# Include back to read-only system mount script
. /eso/hmi/engdefs/scripts/mqb/util_unmountsys.sh

echo "Done. Please reopen the GreenMenu"

exit 0
