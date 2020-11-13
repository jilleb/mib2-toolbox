#!/bin/sh

export TOPIC="Displaymanager"
export DESCRIPTION="This script will show and dump information about the displays"

echo $DESCRIPTION
. "/eso/bin/PhoneCustomer/default/util_info.sh"
. "/eso/bin/PhoneCustomer/default/util_mountsd.sh"



export LD_LIBRARY_PATH=/eso/lib
export IPL_CONFIG_DIR=/etc/eso/production

#Make dump folder
DUMPFOLDER="$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC"
echo Dump-folder: $DUMPFOLDER
echo Dumping, please wait. This can take a while.ø
mkdir -p $VOLUME/Dump/$VERSION/$FAZIT/$TOPIC
/eso/bin/apps/dmdt gs > $DUMPFOLDER/gs.txt
/eso/bin/apps/dmdt gd > $DUMPFOLDER/gd.txt
/eso/bin/apps/dmdt gc > $DUMPFOLDER/gc.txt

echo "System information"
cat /$DUMPFOLDER/gs.txt
sleep 1

echo "Displays information"
cat /$DUMPFOLDER/gd.txt
sleep 1

echo "Client information"
cat /$DUMPFOLDER/gc.txt
sleep 1



exit 0