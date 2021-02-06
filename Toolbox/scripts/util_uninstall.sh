#!/bin/sh

#Info
DESCRIPTION="This script will uninstall the MIB Toolbox"

echo $DESCRIPTION

. /eso/hmi/engdefs/scripts/mqb/util_info.sh

mount -uw /mnt/app

echo "Deleting old mqbcoding.esd pre v4.1"
rm /mnt/app/eso/hmi/engdefs/mqbcoding.esd
rm -rv /mnt/app/eso/hmi/engdefs/mqbcoding.esd.*

echo "Deleting Toolbox GreenMenus"
rm -rv /mnt/app/eso/hmi/engdefs/mqb*.esd
rm -rv /mnt/app/eso/hmi/engdefs/mqb*.esd.*

echo "Deleting old MIB Toolbox scripts pre v4.1"
rm -rv /mnt/app/eso/bin/PhoneCustomer/*.sh
rm -rv /mnt/app/eso/bin/PhoneCustomer/default/*.sh
rm -rv /mnt/app/eso/bin/PhoneCustomer/scripts

echo "Deleting MIB Toolbox scripts"
rm -rv /mnt/app/eso/hmi/engdefs/scripts/mqb/*.sh
rm -rv /mnt/app/eso/hmi/engdefs/scripts/mqb

mount -ur /mnt/app

echo "Uninstall complete. Please reboot unit."

exit 0