#!/bin/sh
# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

# Include SD card mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh

# Make it writable
mount -uw /mnt/app

# Define the source path
NEWFILES=$VOLUME/Custom/VNCCient/config.txt
DESTINATION=/navigation

if [ -f ${NEWFILES} ]; then
	echo "Copying config.txt from SD to unit..."
	cp ${NEWFILES} ${DESTINATION}
else
	echo "ERROR: No files found"
	exit 0
fi

echo "Copy done"

sleep .5

# Make readonly again
mount -ur /mnt/app

exit 0