#!/bin/sh
#info
TOPIC=AndroidAuto
DESCRIPTION="This script will backup and patch AA config files."

#Volumes/files
VOLUME=/fs/sda0
FILENAME=gal.json
ORIGINAL=/etc/eso/production/

#Firmware/unit info:
VERSION="$(cat /net/rcc/dev/shmem/version.txt | grep "Current train" | sed 's/Current train = //g' | sed -e 's|["'\'']||g' | sed 's/\r//')"
FAZIT=$(cat /tmp/fazit-id);

echo $DESCRIPTION
echo FAZIT of this unit: $FAZIT
echo Firmware version: $VERSION

#Make app volume writable
echo Mounting app folder.
mount -uw /mnt/app
mount -uw /mnt/system

#Is there any SD-card inserted?
if [ -d /net/mmx/fs/sda0 ]; then
    echo SDA0 found
    VOLUME=/net/mmx/fs/sda0
elif [ -d /net/mmx/fs/sdb0 ] ; then
    echo SDB0 found
    VOLUME=/net/mmx/fs/sdb0
else 
    echo No SD-cards found.
    exit 0
fi

sleep .5

echo Mounting SD-card.
mount -uw $VOLUME

sleep .5

#Make backup folder
BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC


echo Making backup folders on SD-card.
mkdir -p $BACKUPFOLDER
touch $BACKUPFOLDER/DONT_TOUCH_ANYTHING_HERE
sleep .5
echo Copying gal.json to backup folder on SD-card.
echo
cp $ORIGINAL/$FILENAME $BACKUPFOLDER/$FILENAME
sleep .5
 
#Only start patching when a backup is there
if [ -d $BACKUPFOLDER ]; then
    echo Backup copied to $BACKUP
    echo "Start patching"
   
    sed -i 's/GOOGLE AUTOMOTIVE LINK CONFIGURATION FILE/MQBCODING GOOGLE AUTOMOTIVE LINK CONFIGURATION FILE/g' $ORIGINAL/$FILENAME
    
    echo Patching Car identity
    sed -i 's/\[brand\]/Google/g' $ORIGINAL/$FILENAME
    sed -i 's/\[car_class\]/Desktop Head Unit/g' $ORIGINAL/$FILENAME
    sed -i 's/\[car_generation\]//g' $ORIGINAL/$FILENAME
    sed -i 's/\[car_derivate\]//g' $ORIGINAL/$FILENAME
    sed -i 's/ (\[hmi_variant\])//g' $ORIGINAL/$FILENAME
    sed -i 's/\[branch\]_\[region\]/2015/g' $ORIGINAL/$FILENAME
    sed -i 's/\[car_id\]/0001/g' $ORIGINAL/$FILENAME
    sleep .5
    echo Patching Headunit information
    
    sed -i 's/\[first_tier_supplier\]/Google/g' $ORIGINAL/$FILENAME
    sed -i 's/\[project_id\]/Desktop Head Unit/g' $ORIGINAL/$FILENAME
    sed -i 's/\[train_version\]/2015-09-16-2258745/g' $ORIGINAL/$FILENAME
    sed -i 's/\[sw_version\]/1.0-windows/g' $ORIGINAL/$FILENAME
   
    sleep .5
    
else 
    echo "Backup not found. It's not safe to continue"
    echo "Please make sure your SD-card is writable"
    exit 0   
fi

#make readonly again
mount -ur /mnt/app
mount -ur $VOLUME
mount -ur /mnt/system

echo "---------------------------"
echo Done patching. Please re-connect your phone and enjoy custom apps.
echo If something does not work like it should, run the recovery script.
echo Backup is stored at $BACKUPFOLDER

exit 0
