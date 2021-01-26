#!/bin/sh
export TOPIC=GoogleEarth
export MIBPATH=/gemib/
export SDPATH=/$TOPIC/gemib/
export DESCRIPTION="This script will patch Google Earth (CarNet service) files to enable 3d terrain and buildings"
export TYPE="folder"


echo $DESCRIPTION


. /eso/bin/PhoneCustomer/default/util_info.sh

. /eso/bin/PhoneCustomer/default/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi

#Make backup folder
export BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC/

#include script to make backup
. /eso/bin/PhoneCustomer/default/util_backup.sh

 
#Only start patching when a backup is there
if [ -d $BACKUPFOLDER ]; then
    echo Backup copied to $BACKUP
    echo "Start patching"
	mount -uw /mnt/app
	mount -uw $VOLUME
	mount -uw /mnt/system
	
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
