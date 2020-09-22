#!/bin/sh

# This script is meant to dump all skin and android auto files
# author: Jille
########################

#info
DESCRIPTION="This script will dump skins, startup screens and android auto configuration"
echo $DESCRIPTION

#include script to show and set unit info to variables $FAZIT and $VERSION
. /eso/bin/PhoneCustomer/default/util_info.sh



#include script to mount the sd-card and set variable $VOLUME as the SD-location
. /eso/bin/PhoneCustomer/default/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi
#Make app volume writable

echo Mounting app folder.
mount -uw /mnt/app

sleep .5

#Make backup folder
DUMPPATH=$VOLUME/Dump/$VERSION/$FAZIT/

# Make app volume writable
echo Mounting app folder.
mount -uw /mnt/app

echo Making backup folders on SD-card.
mkdir -p $DUMPPATH

echo Dumping, please wait. This can take a while.

mount -uw /net/mmx/fs/sda0

mkdir -p $DUMPPATH/Skinfiles
echo Dumping skin files
cp -R /eso/hmi/lsd/Resources $DUMPPATH/Skinfiles/

echo Dumping startup screen files
mkdir -p $DUMPPATH/Splashscreen
cp /eso/hmi/splashscreen/*.* $DUMPPATH/Splashscreen/

echo Dumping Android Auto config filefiles
mkdir -p $DUMPPATH/AndroidAuto
cp /etc/eso/production/gal.json $DUMPPATH/AndroidAuto/


mkdir -p $DUMPPATH/Sounds/Systemsounds/
mkdir -p $DUMPPATH/Sounds/Ringtones/
mkdir -p $DUMPPATH/Sounds/TTS-audio/
mkdir -p $DUMPPATH/Radiostations/
mkdir -p $DUMPPATH/Gracenote/
mkdir -p $DUMPPATH/Mapstyles/ 
echo Dumping System sounds
cp /net/rcc/mnt/efs-system/opt/audio/tones/*.* $DUMPPATH/Sounds/Systemsounds/
echo Dumping Telephone ringtones 
cp /net/mmx/mnt/app/hb/ringtones/*.* $DUMPPATH/Sounds/Ringtones/
echo Dumping TTS-audio alerts
cp /net/mmx/ifs/tts-audio/*.* $DUMPPATH/Sounds/TTS-audio/
echo Dumping Radio Station DB
cp /net/mmx/mnt/boardbook/RSDB/VW_STL_DB.sqlite $DUMPPATH/Radiostations/
echo Dumping Gracenote DB
cp -R /net/mmx/mnt/gracenotedb/ $DUMPPATH/Gracenote/
echo Dumping Mapstyles
cp -R /net/mmx/mnt/app/navigation/resources/app/ $DUMPPATH/Mapstyles/	
# Make readonly again
mount -ur $VOLUME

echo Done. Now start tweaking the dumped stuff!

exit 0
