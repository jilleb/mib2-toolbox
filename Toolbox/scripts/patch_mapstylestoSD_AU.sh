#!/bin/sh
# Info
export TOPIC=MapStyles
export MIBPATH=/net/mmx/mnt/app/navigation

echo "This script will move Audi mapstyles to SD and activate to use styles from SD"

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

# Include SD card mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh

# Setting LoadStylesFromSDCard flag to activatethe possibility to use MapStyles from SD card
echo "Setting LoadStylesFromSDCard flag"
# Include writeable system mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsys.sh
touch /navigation/LoadStylesFromSDCard
# Include back to read-only system mount script
. /eso/hmi/engdefs/scripts/mqb/util_unmountsys.sh

#Copying MapStyles to SD-card
export MIBPATH=/net/mmx/mnt/system
# Include writeable system mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsys.sh
echo "Mounting Audi mapstyles iso"
mount -t cd /net/mmx.mibhigh.net/mnt/navdb/database/eu/mapStyles/1/navigation_styles_AU_EU.iso /mnt/tmp
echo "Copying Audi mapstyles files to SD"
cp -R -V /mnt/tmp/. $VOLUME/
# Include back to read-only system mount script
. /eso/hmi/engdefs/scripts/mqb/util_unmountsys.sh

echo "Done, please restart"

exit 0

