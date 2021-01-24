#!/bin/sh
#info
TOPIC=Password
DESCRIPTION="This script will find your root password"

echo $DESCRIPTION

. /eso/bin/PhoneCustomer/default/util_info.sh

. /eso/bin/PhoneCustomer/default/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi

echo "Looking for passwords.csv on SD-card"
sleep .5
if [ ! -f /$VOLUME/passwords.csv ]
then

    echo "Passwords.csv not found."
    echo "Can't look for passwords if this file is not available."
    exit 0
fi


#Make backup folder
DUMPFOLDER="$VOLUME/Dump/$VERSION/$FAZIT/Hashes"

echo Dump-folder: $DUMPFOLDER
mkdir -p $DUMPFOLDER


HASH=`awk -F ':' '{ if ($1 == "root") { print $2 } }' /net/mmx/mnt/system/etc/shadow`
PASSWORD=`awk -v hashvar="$HASH" -F',' '{ if ($1 == hashvar) { print $2 } }' /net/mmx/fs/sda0/Custom/passwords.csv`

sleep .5

if [ "$PASSWORD" == "" ];then
   echo "MMX password not found in password list."
   echo $HASH > $DUMPFOLDER/mmx_hash.txt
else 
    echo "Your MMX root password is: $PASSWORD"
fi

sleep .5

HASHRCC=`awk -F ':' '{ if ($1 == "root") { print $2 } }' /net/rcc/etc/shadow_rcc`
PASSWORDRCC=`awk -v hashvar2="$HASHRCC" -F ',' '{ if ($1 == hashvar2) { print $2 } }' /net/mmx/fs/sda0/Custom/passwords.csv`


if [ "$PASSWORD" == "" ];then
   echo "MMX password not found in password list."
   echo $HASHRCC > $DUMPFOLDER/rcc_hash.txt
else 
    echo "Your RCC root password is: $PASSWORDRCC"
fi



mount -ur $VOLUME

exit 0
