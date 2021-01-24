#!/bin/sh
#info
DESCRIPTION="This script will modify info.txt for each skin so you have user-selectable menu modes"

#Volumes/files
FILENAME=info.txt
RESOURCESPATH=/eso/hmi/lsd/Resources/

#Firmware/unit info:
VERSION="$(cat /net/rcc/dev/shmem/version.txt | grep "Current train" | sed 's/Current train = //g' | sed -e 's|["'\'']||g' | sed 's/\r//')"
FAZIT=$(cat /tmp/fazit-id);

echo $DESCRIPTION
echo FAZIT of this unit: $FAZIT
echo Firmware version: $VERSION

#Make app volume writable
echo Mounting app folder.
mount -uw /mnt/app

echo "Start patching"

echo "Patching skin1 info.txt" 
sed -i 's/UserSwitchableMenuMode=false/UserSwitchableMenuMode=true/g' $RESOURCESPATH/skin1/$FILENAME
echo "Patching skin2 info.txt" 
sed -i 's/UserSwitchableMenuMode=false/UserSwitchableMenuMode=true/g' $RESOURCESPATH/skin2/$FILENAME
echo "Patching skin3 info.txt" 
sed -i 's/UserSwitchableMenuMode=false/UserSwitchableMenuMode=true/g' $RESOURCESPATH/skin3/$FILENAME
echo "Patching skin4 info.txt" 
sed -i 's/UserSwitchableMenuMode=false/UserSwitchableMenuMode=true/g' $RESOURCESPATH/skin4/$FILENAME
echo "Patching skin5 info.txt" 
sed -i 's/UserSwitchableMenuMode=false/UserSwitchableMenuMode=true/g' $RESOURCESPATH/skin5/$FILENAME
echo "Patching skin6 info.txt" 
sed -i 's/UserSwitchableMenuMode=false/UserSwitchableMenuMode=true/g' $RESOURCESPATH/skin6/$FILENAME


#make readonly again
mount -ur /mnt/app

echo "---------------------------"
echo Done patching. After restart, you will have an additional setting in the SCREEN settings.

exit 0
