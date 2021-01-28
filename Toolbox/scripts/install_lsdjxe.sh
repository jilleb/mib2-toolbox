#!/bin/sh

# This script is meant to copy all  files from the source to MIB and backup the original ones
# author: Jille
########################

#info
export TOPIC=LSD
export DESCRIPTION="This script will copy custom  lsd.jxe from SD to your unit."

echo $DESCRIPTION


. /eso/hmi/engdefs/scripts/mqb/util_info.sh

. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi

#Make app volume writable
echo Mounting app folder.
mount -uw /mnt/app

MIBFOLDER=/net/mmx/ifs/
SOURCEFOLDER=$VOLUME/Custom/LSD/

# Make app volume writable
echo Mounting app folder.
mount -uw /mnt/app
mount -uw /net/mmx/ifs/
mount -uw /net/mmx/mnt/system

echo Copying modified file from SD  to MIB.
cp $SOURCEFOLDER/lsd.jxe /$MIBFOLDER/lsd.jxe

# Make readonly again
mount -ur /mnt/app
mount -ur $VOLUME
mount -ur /net/mmx/ifs/
mount -ur /net/mmx/mnt/system

echo Done. 

exit 0
