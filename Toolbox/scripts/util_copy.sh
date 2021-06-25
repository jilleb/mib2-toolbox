# MIB2 utility script, part of the MIB High toolbox.
# Coded by Jille & Olli
# This script will make a backup if it's not already there
########################################################################################

# Include writeable system mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsys.sh

# Define the source path
NEWFILES=$VOLUME/Custom/$SDPATH

# Copying the files
echo "Copying data from SD-card to unit..."

# Check if a folder or only a file needs to be copied
if [ "$TYPE" == "folder" ]; then
	echo "Copying files recursively from Custom/$TOPIC folder on SD-card."
	echo "This can take some time. Please wait..."
    cp -R "$NEWFILES" "$MIBPATH"
else 
	echo "Copying file from Custom/$TOPIC folder on SD-card."
    cp $NEWFILES "$MIBPATH"
fi 

echo "Copy done"
echo
sleep .5


echo Mounting System volume as read-only.
mount -ur /net/mmx/mnt/system
echo Mounting App volume as read-only.
mount -ur /net/mmx/mnt/app
mount -ur /net/rcc/mnt/efs-persist

sleep .5


# Include back to read-only system mount script
. /eso/hmi/engdefs/scripts/mqb/util_unmountsys.sh
