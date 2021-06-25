#!/bin/sh
#info
export TOPIC=AndroidAuto
export DESCRIPTION="This script will backup and patch AA config files."
export MIBPATH=/etc/eso/production/gal.json
export SDPATH=/$TOPIC/gal.json
export ORIGINAL=/etc/eso/production/
export FILENAME=gal.json
export SDPATH=/$TOPIC/gal.json


echo $DESCRIPTION

. /eso/hmi/engdefs/scripts/mqb/util_info.sh
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh

export BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC/

#include script to make backup
. /eso/hmi/engdefs/scripts/mqb/util_backup.sh

sleep .5

echo Mounting SD-card.
mount -uw $VOLUME

sleep .5

#Only start patching when a backup is there
if [ -d $BACKUPFOLDER ]; then
    echo Backup copied to $BACKUP
    echo "Start patching"
   
	mount -uw /mnt/app
	mount -uw $VOLUME
	mount -uw /mnt/system
	
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
