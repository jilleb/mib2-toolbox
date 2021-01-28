#!/bin/sh

#Info
DESCRIPTION="This script will uninstall the MIB Toolbox"

echo $DESCRIPTION

. /eso/hmi/engdefs/scripts/mqb/util_info.sh

mount -uw /mnt/app

echo "Deleting old mqbcoding.esd pre v4.1"
rm /mnt/app/eso/hmi/engdefs/mqbcoding.esd
rm -r /mnt/app/eso/hmi/engdefs/mqbcoding.esd.*

echo "Deleting Toolbox GreenMenus"
rm -r /mnt/app/eso/hmi/engdefs/mqb*.esd
rm -r /mnt/app/eso/hmi/engdefs/mqb*.esd.*

echo "Deleting old MIB Toolbox scripts pre v4.1"
rm -r /mnt/app/eso/bin/PhoneCustomer/*.sh
rm -r /mnt/app/eso/bin/PhoneCustomer/default/*.sh

echo "Deleting MIB Toolbox scripts"
rm -r /mnt/app/eso/hmi/engdefs/scripts/mqb/mqb*.sh

mount -ur /mnt/app

echo "Uninstall complete. Please reboot unit."

exit 0