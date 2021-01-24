#!/bin/sh

# Make it writable
mount -uw /mnt/app

echo "Copying scripts from sda0"
cp -r /fs/sda0/Phone/Apps/0/default /eso/bin/PhoneCustomer 
chmod a+rwx /eso/bin/PhoneCustomer/*

echo "Copying payload to mqbcoding.esd"
cp /fs/sda0/PersonalPOI/PayLoad/0/default/payload.sh /eso/hmi/engdefs/mqbcoding.esd

# Make readonly again
mount -ur /mnt/app

echo Done.

exit 0
