#!/bin/ksh

echo FinalScript for HW ${1} on medium ${2}...

VOLUME="${2}"

if [ -z "$VOLUME" ]; then
    if [[ -d /net/mmx/fs/sda0 ]]
    then
        echo SDA0 found
        export VOLUME=/net/mmx/fs/sda0
    elif [[ -d /net/mmx/fs/sdb0 ]]
    then
        echo SDB0 found
        export VOLUME=/net/mmx/fs/sdb0
    else
        echo No SD-cards found.
        exit 0
    fi
fi

# Make it writable
on -f mmx /bin/mount -uw /mnt/app

on -f mmx /bin/mkdir -p /net/mmx/mnt/app/eso/bin/PhoneCustomer/default
on -f mmx /bin/cp -r $VOLUME/Toolbox/scripts/*.sh /net/mmx/mnt/app/eso/bin/PhoneCustomer/default
on -f mmx /bin/chmod a+rwx /net/mmx/mnt/app/eso/bin/PhoneCustomer/default

# Make readonly again
on -f mmx /bin/mount -ur /mnt/app

echo Done.
touch /tmp/SWDLScript.Result

