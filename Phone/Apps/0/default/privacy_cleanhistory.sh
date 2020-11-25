#!/bin/sh
#info
DESCRIPTION="This script will remove all update logs from your SWDL menu"

#Volumes/files

LOGPATH=/net/rcc/mnt/efs-persist/SWDL/Log/


. /eso/bin/PhoneCustomer/default/util_info.sh

#Make app volume writable
echo Mounting app folder.
mount -uw /net/rcc/mnt/efs-persist
rm -R -f /net/rcc/mnt/efs-persist/SWDL/Log/
mkdir /net/rcc/mnt/efs-persist/SWDL/Log/

echo ""

#make readonly again
mount -ur /net/rcc/mnt/efs-persist

echo "---------------------------"
echo "Done. Your updates are now no longer visible"

exit 0
