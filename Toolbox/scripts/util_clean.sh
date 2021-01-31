#!/bin/sh

#Info
DESCRIPTION="This script will cleanup old stuff, which isn't used anymore."

echo $DESCRIPTION

. /eso/hmi/engdefs/scripts/mqb/util_info.sh
mount -uw /mnt/app

echo "Deleting GreenMenus, which aren't used anymore."
rm /mnt/app/eso/hmi/engdefs/mqb-adaptions.esd
rm /mnt/app/eso/hmi/engdefs/mqb-rccAdaptions.esd

echo "Deleting scripts, which aren't used anymore."
rm /mnt/app/eso/hmi/engdefs/scripts/mqb/install_online.sh
rm /mnt/app/eso/hmi/engdefs/scripts/mqb/dump_online.sh

mount -ur /mnt/app

echo "Cleanup complete."

exit 0