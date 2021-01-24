#!/bin/ksh

echo FinalScript for HW ${1} on medium ${2}...

# Make it writable
on -f mmx /bin/mount -uw /mnt/app

on -f mmx /bin/mkdir -p /net/mmx/mnt/app/eso/bin/PhoneCustomer/default
on -f mmx /bin/cp -r ${2}/Install/scripts/*.sh /net/mmx/mnt/app/eso/bin/PhoneCustomer/default
on -f mmx /bin/chmod a+rwx /net/mmx/mnt/app/eso/bin/PhoneCustomer/default

# Make readonly again
on -f mmx /bin/mount -ur /mnt/app

echo Done.
touch /tmp/SWDLScript.Result

