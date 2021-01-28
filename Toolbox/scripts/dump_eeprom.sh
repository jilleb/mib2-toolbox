#!/bin/sh
export PATH=.:/proc/boot:/bin:/usr/bin:/usr/sbin:/sbin:/mnt/app/media/gracenote/bin:/mnt/app/armle/bin:/mnt/app/armle/sbin:/mnt/app/armle/usr/bin:/mnt/app/armle/usr/sbin
export LD_LIBRARY_PATH=/lib:/mnt/app/root/lib-target:/eso/lib:/mnt/app/usr/lib:/mnt/app/armle/lib:/mnt/app/armle/lib/dll:/mnt/app/armle/usr/lib
export IPL_CONFIG_DIR=/etc/eso/production 
export LOGFILES_DIR=/mnt/ota/system/logs
export COREFILES_DIR=/mnt/ota/system/core

# we do not want VW-HMI specific libecpp
unset LD_PRELOAD

#info
TOPIC=EEPROM
DESCRIPTION="This script will dump the EEPROM."

echo $DESCRIPTION


. /eso/hmi/engdefs/scripts/mqb/util_info.sh

. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi


#Make backup folder
DUMPFOLDER="$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC"

echo Dump-folder: $DUMPFOLDER
mkdir -p $DUMPFOLDER

echo Dumping, please wait. This can take a while.
echo Be patient, it will look like nothing is happening.
on -f rcc /net/rcc/usr/apps/modifyE2P r 0 10000 > /$DUMPFOLDER/eepromdump.txt
echo ""
echo Dump done. Dump will now be listed.
echo EEPROM dump is saved to $DUMPFOLDER.
echo "-------------------------------------"

sleep 1

cat /$DUMPFOLDER/eepromdump.txt

# Make readonly again
mount -ur $VOLUME
echo ""
echo Done. You can now read the entire eeprom from the dump on the SD-card.

exit 0
