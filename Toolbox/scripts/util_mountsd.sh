# MIB2 script, part of the MIB High toolbox.
# Coded by Jille
# This script will determine if an SD is inserted, and call to mount it.

# Check for toolbox SD and define as VOLUME
if [ -d /net/mmx/fs/sda0/Toolbox ]; then
    echo "Toolbox on SDA0 found"
    export VOLUME="/net/mmx/fs/sda0"
elif [ -d /net/mmx/fs/sdb0/Toolbox ]; then
    echo "Toolbox on SDB0 found"
    export VOLUME="/net/mmx/fs/sdb0"
else 
    echo "No Toolbox SD card found. Aborting"
    exit 0
fi

# Mount the SD card writeable
echo "Mounting SD card writeable"
mount -uw $VOLUME
echo
sleep .5