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

# Copy scripts
on -f mmx /bin/mkdir -p /net/mmx/mnt/app/eso/hmi/engdefs/scripts/mqb
on -f mmx /bin/cp -r $VOLUME/Toolbox/scripts/*.sh /net/mmx/mnt/app/eso/hmi/engdefs/scripts/mqb
on -f mmx /bin/chmod a+rwx /net/mmx/mnt/app/eso/hmi/engdefs/scripts/mqb

# Copy additional GreenMenus
on -f mmx /bin/cp -r $VOLUME/Toolbox/GEM/*.esd /net/mmx/mnt/app/eso/hmi/engdefs

# Make readonly again
on -f mmx /bin/mount -ur /mnt/app

# Set unit into developer mode
export LD_LIBRARY_PATH=/mnt/app/root/lib-target:/eso/lib:/mnt/app/usr/lib:/mnt/app/armle/lib:/mnt/app/armle/lib/dll:/mnt/app/armle/usr/lib 
export IPL_CONFIG_DIR=/etc/eso/production 
on -f mmx /net/mmx/mnt/app/eso/bin/apps/pc b:0:0xC002000D 1

echo Done.
touch /tmp/SWDLScript.Result

