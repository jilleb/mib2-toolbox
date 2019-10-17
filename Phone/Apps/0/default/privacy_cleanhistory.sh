#!/bin/sh
#info
DESCRIPTION="This script will remove all update logs from your SWDL menu"

#Volumes/files

LOGPATH=/net/rcc/mnt/efs-persist/SWDL/Log/

#Firmware/unit info:
VERSION="$(cat /net/rcc/dev/shmem/version.txt | grep "Current train" | sed 's/Current train = //g' | sed -e 's|["'\'']||g' | sed 's/\r//')"
FAZIT=$(cat /tmp/fazit-id);

echo $DESCRIPTION
echo FAZIT of this unit: $FAZIT
echo Firmware version: $VERSION

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
