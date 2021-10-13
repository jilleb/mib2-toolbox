#!/bin/sh
# Info
export TOPIC=GoogleEarth
export MIBPATH=/net/mmx/mnt/app/gemib
export SDPATH=$TOPIC
export TYPE="folder"

echo "This script will patch Google Earth (CarNet service) files to enable 3d terrain and buildings"

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

#include script to make backup
. /eso/hmi/engdefs/scripts/mqb/util_backup.sh
 
#Only start patching when a backup is there
if [ -d $BACKUPFOLDER ]; then
    echo "Start patching..."
	
	# Include writeable system mount script
	. /eso/hmi/engdefs/scripts/mqb/util_mountsys.sh
	
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

# Include back to read-only system mount script
. /eso/hmi/engdefs/scripts/mqb/util_unmountsys.sh

echo "---------------------------"
echo "Done patching. Your Google Earth maps now have 3d buildings and terrain"
echo "It's possible that your navigation performance has suffered from this."
echo "If you don't like it, run the recovery script."

exit 0
