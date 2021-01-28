#!/bin/sh

#Info
DESCRIPTION="This script will uninstall the MIB Toolbox"

echo $DESCRIPTION


. /eso/bin/PhoneCustomer/default/util_info.sh
mount -uw /mnt/app

echo "Deleting mqbcoding.esd"
rm /mnt/app/eso/hmi/engdefs/mqbcoding.esd

echo "Deleting MIB Toolbox scripts"
rm -r /mnt/app/eso/bin/PhoneCustomer/*.sh
rm -r /mnt/app/eso/bin/PhoneCustomer/default/*.sh

mount -ur /mnt/app

echo "Uninstall complete. Please reboot unit."

exit 0