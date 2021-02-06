#!/bin/sh

#Info
DESCRIPTION="This script will cleanup old MIB Toolbox installations."

echo $DESCRIPTION

. /eso/hmi/engdefs/scripts/mqb/util_info.sh
mount -uw /mnt/app

echo "Deleting old mqbcoding.esd pre v4.1"
rm /mnt/app/eso/hmi/engdefs/mqbcoding.esd
rm -r /mnt/app/eso/hmi/engdefs/mqbcoding.esd.*

echo "Deleting old MIB Toolbox scripts pre v4.1"
rm -r /mnt/app/eso/bin/PhoneCustomer/*.sh
rm -r /mnt/app/eso/bin/PhoneCustomer/default/*.sh
rm -r /mnt/app/eso/bin/PhoneCustomer/default/scripts

mount -ur /mnt/app

echo "Cleanup complete."

exit 0