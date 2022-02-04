#!/bin/sh
export PATH=/proc/boot:/bin:/usr/bin:/usr/sbin:/sbin:/mnt/app/media/gracenote/bin:/mnt/app/armle/bin:/mnt/app/armle/sbin:/mnt/app/armle/usr/bin:/mnt/app/armle/usr/sbin:$PATH

if [ "$_" = "/bin/on" ]; then BASE="$0"; else BASE="$_"; fi
SCRIPTDIR=$( cd -P -- "$(dirname -- "$(command -v -- "$BASE")")" && pwd -P )

export LD_LIBRARY_PATH=/net/mmx/mnt/app/root/lib-target:/net/mmx/eso/lib:/net/mmx/mnt/app/usr/lib:/net/mmx/mnt/app/armle/lib:/net/mmx/mnt/app/armle/lib/dll:/net/mmx/mnt/app/armle/usr/lib

mount -uw /mnt/app

JAR_TARGET=/mnt/app/eso/hmi/lsd/jars/
mkdir -p ${JAR_TARGET}

echo "Removing ${JAR_TARGET}/NavActiveIgnore.jar"
rm -rf ${JAR_TARGET}/NavActiveIgnore.jar

LSD=/mnt/app/eso/hmi/lsd/lsd.sh
BU=/mnt/app/eso/hmi/lsd/lsd.sh.bu

if [ -e $BU ]; then
echo "Restoring ${LSD} from backup"
mv $BU $LSD
fi

mount -ur /mnt/app
echo "Done, please restart headunit"
