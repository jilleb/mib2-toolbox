#!/bin/sh
# Info
export TOPIC=AndroidAuto
export MIBPATH=/net/mmx/mnt/system/etc/eso/production/gal.json
export ORIGINAL=/etc/eso/production/
export FILENAME=gal.json
export SDPATH=$TOPIC/$FILENAME
export TYPE="file"

echo "This script will backup and patch AA config files."

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

# Include script to make backup
. /eso/hmi/engdefs/scripts/mqb/util_backup.sh

# Only start patching when a backup is present
if [ -f $BACKUPFOLDER/gal.json ]; then
    echo "Start patching"
	
	# Include writeable system mount script
	. /eso/hmi/engdefs/scripts/mqb/util_mountsys.sh
	
    sed -i 's/GOOGLE AUTOMOTIVE LINK CONFIGURATION FILE/MQBCODING GOOGLE AUTOMOTIVE LINK CONFIGURATION FILE/g' $ORIGINAL/$FILENAME
    
    echo "Patching Car identity"
    sed -i 's/\[brand\]/Google/g' $ORIGINAL/$FILENAME
    sed -i 's/\[car_class\]/Desktop Head Unit/g' $ORIGINAL/$FILENAME
    sed -i 's/\[car_generation\]//g' $ORIGINAL/$FILENAME
    sed -i 's/\[car_derivate\]//g' $ORIGINAL/$FILENAME
    sed -i 's/ (\[hmi_variant\])//g' $ORIGINAL/$FILENAME
    sed -i 's/\[branch\]_\[region\]/2015/g' $ORIGINAL/$FILENAME
    sed -i 's/\[car_id\]/0001/g' $ORIGINAL/$FILENAME
    sleep .5
	
    echo "Patching Headunit information"  
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

# Include back to read-only system mount script
. /eso/hmi/engdefs/scripts/mqb/util_unmountsys.sh

echo "---------------------------"
echo "Done patching. Please re-connect your phone and enjoy custom apps."
echo "If something does not work like it should, run the recovery script."
echo "Backup is stored at $BACKUPFOLDER"

exit 0
