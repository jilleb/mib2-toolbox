#!/bin/sh

. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh
if [[ -z "$VOLUME" ]]
then
	echo "No SD-card found, quitting"
	exit 0
fi

# Make it writable
mount -uw /mnt/app

echo "Copying scripts from $VOLUME"
mkdir -p /eso/hmi/engdefs/scripts/mqb
cp -r $VOLUME/Toolbox/scripts/* /eso/hmi/engdefs/scripts/mqb
chmod a+rwx /eso/hmi/engdefs/scripts/mqb

echo "Copying GreenEngineeringMenu from $VOLUME"
cp $VOLUME/Toolbox/GEM/*.esd /eso/hmi/engdefs

# Make readonly again
mount -ur /mnt/app

echo Done.

exit 0
