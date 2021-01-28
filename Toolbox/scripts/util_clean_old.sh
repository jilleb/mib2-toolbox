#!/bin/sh

#Info
DESCRIPTION="This script will cleanup old MIB Toolbox installations."

echo $DESCRIPTION


. /eso/hmi/engdefs/scripts/mqb/util_info.sh
mount -uw /mnt/app

echo "Deleting old mqbcoding.esd pre v4.1"
rm -v /mnt/app/eso/hmi/engdefs/mqbcoding.esd
rm -rv /mnt/app/eso/hmi/engdefs/mqbcoding.esd.*

echo "Deleting old MIB Toolbox scripts pre v4.1"
rm -rv /mnt/app/eso/bin/PhoneCustomer/*.sh
rm -rv /mnt/app/eso/bin/PhoneCustomer/default/*.sh

mount -ur /mnt/app

echo "Cleanup complete."

exit 0