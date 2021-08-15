#!/bin/sh
# Info
export TOPIC=Password
export MIBPATH="/net/mmx/mnt/system/etc/shadow & /net/rcc/etc/shadow_rcc"
export HASHMMX=`awk -F ':' '{ if ($1 == "root") { print $2 } }' /net/mmx/mnt/system/etc/shadow`
export HASHRCC=`awk -F ':' '{ if ($1 == "root") { print $2 } }' /net/rcc/etc/shadow_rcc`
export SDPATH=$TOPIC
export TYPE="file"

echo "This script will find your root password"

# Check for custom passwords.csv
echo "Looking for passwords.csv on SD-card"
if [ ! -f $VOLUME/Custom/passwords.csv ]; then
    echo "Custom/Passwords.csv not found."
    echo "Can't look for passwords if this file is not available."
    exit 0
fi

# MMX password
PASSWORDMMX=`awk -v hashvar="$HASHMMX" -F',' '{ if ($1 == hashvar) { print $2 } }' $VOLUME/Custom/passwords.csv`
if [ "$PASSWORDMMX" = "" ]; then
	echo "MMX password not found in password list."
else 
    echo "Your MMX root password is: $PASSWORDMMX"
fi
sleep .5

# RCC password
PASSWORDRCC=`awk -v hashvar2="$HASHRCC" -F ',' '{ if ($1 == hashvar2) { print $2 } }' $VOLUME/Custom/passwords.csv`
if [ "$PASSWORDRCC" = "" ]; then
	echo "RCC password not found in password list."
else 
    echo "Your RCC root password is: $PASSWORDRCC"
fi

exit 0
