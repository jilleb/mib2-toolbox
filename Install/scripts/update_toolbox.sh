#!/bin/sh

# Make it writable
mount -uw /mnt/app

echo "Copying scripts from sda0"
cp -r /fs/sda0/Install/scripts /eso/bin/PhoneCustomer/default 
chmod a+rwx /eso/bin/PhoneCustomer/*

echo "Copying payload to mqbcoding.esd"
cp /fs/sda0/Install/esd/mqbcoding.esd /eso/hmi/engdefs/mqbcoding.esd

# Make readonly again
mount -ur /mnt/app

echo Done.

exit 0
