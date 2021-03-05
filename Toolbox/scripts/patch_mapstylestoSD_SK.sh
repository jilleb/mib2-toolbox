#!/bin/sh
#info
export TOPIC=AndroidAuto
export DESCRIPTION="This script will move Skoda mapstyles to SD"


echo $DESCRIPTION

. /eso/hmi/engdefs/scripts/mqb/util_info.sh
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh

sleep .5

mount -uw $VOLUME

sleep .5


mount -uw /mnt/app
echo "Setting LoadStylesFromSDCard flag"
touch /navigation/LoadStylesFromSDCard

mount -uw /mnt/system
echo "Mounting Skoda mapstyles iso"
mount -t cd /net/mmx.mibhigh.net/mnt/navdb/database/eu/mapStyles/3/navigation_styles_SK_EU.iso /mnt/tmp
echo "Copying Skoda mapstyles files to SD"
cp -R -V /mnt/tmp/. $VOLUME/


#make readonly again
mount -ur /mnt/app
mount -ur $VOLUME
mount -ur /mnt/system

echo "Done, please restart"

exit 0
