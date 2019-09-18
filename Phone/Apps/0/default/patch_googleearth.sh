#!/bin/sh
#info
TOPIC=GoogleEarth
DESCRIPTION="This script will patch Google Earth (CarNet service) files to enable 3d terrain and buildings"

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
echo Copying gemib.cfg to backup folder on SD-card.
cp /gemib/gemib.cfg $BACKUPFOLDER/gemib.cfg
sleep .5

echo Copying drivers.ini to backup folder on SD-card.
cp /gemib/drivers.ini $BACKUPFOLDER/drivers.ini
sleep .5
 
#Only start patching when a backup is there
if [ -d $BACKUPFOLDER ]; then
    echo Backup copied to $BACKUP
    echo "Start patching"
   
    echo "Patching gemib.cfg"
    sed -i 's/#MIBEARTH_USE_3DBUILDINGS=no/MIBEARTH_USE_3DBUILDINGS=yes/g' /gemib/gemib.cfg
    sleep .5
    echo "Patching drivers.ini" 
    sed -i 's/drawRockTree = false/drawRockTree = true/g' /gemib/drivers.ini
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
echo "Done patching. Your Google Earth maps now have 3d buildings and terrain"
echo "It's possible that your navigation performance has suffered from this."
echo "If you don't like it, run the recovery script."

exit 0
