#!/bin/sh
#info
TOPIC=Password
DESCRIPTION="This script will find your root password"

#Firmware/unit info:
VERSION="$(cat /net/rcc/dev/shmem/version.txt | grep "Current train" | sed 's/Current train = //g' | sed -e 's|["'\'']||g' | sed 's/\r//')"
FAZIT=$(cat /tmp/fazit-id);

echo $DESCRIPTION
echo FAZIT of this unit: $FAZIT
echo Firmware version: $VERSION


#Is there any SD-card inserted?
if [ -d /net/mmx/fs/sda0 ]; then
    echo SDA0 found
    VOLUME=/net/mmx/fs/sda0
else 
    echo No SD-cards found.
    exit 0
fi

if [ ! -f /net/mmx/fs/sda0/Advanced/passwords.csv ]
then
    echo "Passwords.csv not found."
    echo "Can't look for passwords if this file is not available."
    exit 0
fi


sleep .5

echo Mounting SD-card, in case any unknown hashes are found..
mount -uw $

sleep .5
sleep .5

#Make backup folder
DUMPFOLDER="$VOLUME/Dump/$VERSION/$FAZIT/Hashes"

echo Dump-folder: $DUMPFOLDER
mkdir -p $DUMPFOLDER


HASH=`awk -F ':' '{ if ($1 == "root") { print $2 } }' /net/mmx/mnt/system/etc/shadow`
PASSWORD=`awk -v hashvar="$HASH" -F',' '{ if ($1 == hashvar) { print $2 } }' /net/mmx/fs/sda0/Advanced/passwords.csv`

if [ "$PASSWORD" == "" ];then
   echo "MMX password not found in password list."
   echo $HASH > $DUMPFOLDER/mmx_hash.txt
else 
    echo "Your MMX root password is: $PASSWORD"
fi



HASHRCC=`awk -F ':' '{ if ($1 == "root") { print $2 } }' /net/rcc/etc/shadow_rcc`
PASSWORDRCC=`awk -v hashvar2="$HASHRCC" -F ',' '{ if ($1 == hashvar2) { print $2 } }' /net/mmx/fs/sda0/Advanced/passwords.csv`


if [ "$PASSWORD" == "" ];then
   echo "MMX password not found in password list."
   echo $HASHRCC > $DUMPFOLDER/rcc_hash.txt
else 
    echo "Your RCC root password is: $PASSWORDRCC"
fi



mount -ur $VOLUME

exit 0
