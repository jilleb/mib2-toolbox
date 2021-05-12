# MIB2 utility script, part of the MIB High toolbox.
# Coded by Jille
# This script will make a backup if it's not already there

echo Mounting System volume as writeable.
mount -uw /net/mmx/mnt/system
echo Mounting App volume as writeable.
mount -uw /net/mmx/mnt/app
mount -uw /net/rcc/mnt/efs-persist

sleep .5

NEWFILES=$VOLUME/Custom/$SDPATH

echo "Copying data from SD-card to unit."

if [[ "$TYPE" == "folder" ]]
    then
		echo "Copying files recursively from Custom/$TOPIC folder on SD-card."
		echo "This can take some time. Please wait."
        cp -R "$NEWFILES" "$MIBPATH"
    else 
		echo "Copying file from Custom/$TOPIC folder on SD-card."
        cp $NEWFILES "$MIBPATH"
fi 

echo "Copy done"

sleep .5


echo Mounting System volume as read-only.
mount -ur /net/mmx/mnt/system
echo Mounting App volume as read-only.
mount -ur /net/mmx/mnt/app
mount -ur /net/rcc/mnt/efs-persist

sleep .5