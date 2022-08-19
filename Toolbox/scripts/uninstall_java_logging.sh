#!/bin/sh
export PATH=/proc/boot:/bin:/usr/bin:/usr/sbin:/sbin:/mnt/app/media/gracenote/bin:/mnt/app/armle/bin:/mnt/app/armle/sbin:/mnt/app/armle/usr/bin:/mnt/app/armle/usr/sbin:$PATH

if [ "$_" = "/bin/on" ]; then BASE="$0"; else BASE="$_"; fi
SCRIPTDIR=$( cd -P -- "$(dirname -- "$(command -v -- "$BASE")")" && pwd -P )

export LD_LIBRARY_PATH=/net/mmx/mnt/app/root/lib-target:/net/mmx/eso/lib:/net/mmx/mnt/app/usr/lib:/net/mmx/mnt/app/armle/lib:/net/mmx/mnt/app/armle/lib/dll:/net/mmx/mnt/app/armle/usr/lib

mount -uw /mnt/app

RUN_HMI=/mnt/app/eso/bin/runHMI.sh
RUN_HMI_WRAPPER=${RUN_HMI}.real

if [ -e ${RUN_HMI_WRAPPER} ]; then
echo "Restoring ${RUN_HMI} back to original"
mv ${RUN_HMI_WRAPPER} ${RUN_HMI}
fi

mount -ur /mnt/app
echo "Done, please restart headunit"
