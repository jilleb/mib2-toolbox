#!/bin/sh
# This script is meant to copy all  files from the source to MIB and backup the original ones
# author: Jille
#############################################################################################
# Info
export TOPIC=LSD
export MIBPATH=/net/mmx/mnt/app/eso/hmi/lsd/lsd.sh
export MIBPATH2=/net/mmx/ifs/lsd.jxe
export SDPATH=$TOPIC/lsd.sh
export TYPE="file"

echo "This script will copy custom lsd.jxe from SD to your unit and links it."

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

# include script to make backup
. /eso/hmi/engdefs/scripts/mqb/util_backup.sh

# Manually backup lsd.jxe
if [ -f "$BACKUPFOLDER/lsd.jxe" ]; then
		echo "Backup already exists. Skipping..."
	else
		echo "Copying file, please wait..."
		cp ${MIBPATH2} ${BACKUPFOLDER}/
		echo "Backup is done."
fi

# include script tocopy file(s) and remount everything as read-only again
# . /eso/hmi/engdefs/scripts/mqb/util_copy.sh ## currently not working to replace that file in live system

# Only start patching when a backup is present
# Copying custom lsd.jxe from SD to custom path
if [ -f $BACKUPFOLDER/lsd.jxe ]; then
	echo "Copying file to the unit..."
	
	# Include writeable system mount script
	. /eso/hmi/engdefs/scripts/mqb/util_mountsys.sh
	
	mkdir -p /net/mmx/mnt/app/eso/hmi/engdefs/scripts/mqb/lsd
	cp $VOLUME/Custom/$TOPIC/lsd.jxe /net/mmx/mnt/app/eso/hmi/engdefs/scripts/mqb/lsd/
	chmod a+rwx /net/mmx/mnt/app/eso/hmi/engdefs/scripts/mqb/lsd/lsd.jxe
else
    echo "Backup not found. It's not safe to continue"
    echo "Please make sure your SD-card is writable"
    exit 0 	
fi

# Linking custom lsd.jxe to custom path in lsd.sh
if [ -f $BACKUPFOLDER/lsd.sh ]; then
    echo "Start linking..."	
	sed -i 's/HMI_JXE=$IFS_DIR\/lsd.jxe/HMI_JXE=\/net\/mmx\/mnt\/app\/eso\/hmi\/engdefs\/scripts\/mqb\/lsd\/lsd.jxe/g' $MIBPATH    
else 
    echo "Backup not found. It's not safe to continue"
    echo "Please make sure your SD-card is writable"
    exit 0   
fi

# Include back to read-only system mount script
. /eso/hmi/engdefs/scripts/mqb/util_unmountsys.sh

echo "Done. Now restart the unit."
exit 0
