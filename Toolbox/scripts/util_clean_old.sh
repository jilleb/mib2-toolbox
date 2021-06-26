#!/bin/sh
# Coded by Olli
# This script will cleanup old old MIB Toolbox installations
########################################################################################
#Info
export MIBPATH=/net/mmx/mnt/app/eso/hmi/engdefs/
export MIBPATH2=/net/rcc/mnt/efs-persist/SWDL/FileCopyInfo/

echo "This script will cleanup old pre v4.1 MIB Toolbox installations."

# Include writeable system mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsys.sh

echo "Deleting old mqbcoding.esd pre v4.1"
rm /mnt/app/eso/hmi/engdefs/mqbcoding.esd
rm -r /mnt/app/eso/hmi/engdefs/mqbcoding.esd.*

echo "Deleting old MIB Toolbox scripts pre v4.1"
rm -r /mnt/app/eso/bin/PhoneCustomer/*.sh
rm -r /mnt/app/eso/bin/PhoneCustomer/default/*.sh
rm -r /mnt/app/eso/bin/PhoneCustomer/default/scripts

echo "Deleting old Toolbox versions entry"
rm /net/rcc/mnt/efs-persist/SWDL/FileCopyInfo/MQB.info

# Include back to read-only system mount script
. /eso/hmi/engdefs/scripts/mqb/util_unmountsys.sh

echo "Cleanup complete."

exit 0