#!/bin/sh

. /eso/bin/PhoneCustomer/default/util_mountsd.sh
if [[ -z "$VOLUME" ]]
then
	echo "No SD-card found, quitting"
	exit 0
fi

# Make it writable
mount -uw /mnt/app

echo "Copying scripts from $VOLUME"
mkdir -p /eso/bin/PhoneCustomer/default
cp -r $VOLUME/Toolbox/scripts/* /eso/bin/PhoneCustomer/default
chmod a+rwx /eso/bin/PhoneCustomer/default

echo "Copying payload to mqbcoding.esd"
cp $VOLUME/Toolbox/GEM/mqbcoding.esd /eso/hmi/engdefs/mqbcoding.esd

# Make readonly again
mount -ur /mnt/app

echo Done.

exit 0
