#!/bin/sh
export PATH=/proc/boot:/bin:/usr/bin:/usr/sbin:/sbin:/mnt/app/media/gracenote/bin:/mnt/app/armle/bin:/mnt/app/armle/sbin:/mnt/app/armle/usr/bin:/mnt/app/armle/usr/sbin:$PATH

if [ "$_" = "/bin/on" ]; then BASE="$0"; else BASE="$_"; fi
SCRIPTDIR=$( cd -P -- "$(dirname -- "$(command -v -- "$BASE")")" && pwd -P )

export LD_LIBRARY_PATH=/net/mmx/mnt/app/root/lib-target:/net/mmx/eso/lib:/net/mmx/mnt/app/usr/lib:/net/mmx/mnt/app/armle/lib:/net/mmx/mnt/app/armle/lib/dll:/net/mmx/mnt/app/armle/usr/lib

. ${SCRIPTDIR}/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
  echo "No SD-card found, quitting"
  exit 0
fi

mount -uw /mnt/app


RUN_HMI=/mnt/app/eso/bin/runHMI.sh
RUN_HMI_WRAPPER=${RUN_HMI}.real

if [ ! -e ${RUN_HMI} ]; then
  echo "ERROR: ${RUN_HMI} not found, cannot enable java logging on this version"

else

if [ ! -e ${RUN_HMI_WRAPPER} ]; then
  cp -v ${RUN_HMI} ${RUN_HMI_WRAPPER}
fi

echo "Installing logging wrapper for ${RUN_HMI}"

cat << "EOF" > ${RUN_HMI}
#!/bin/sh
#
# runHMI.sh wrapper to add logging to SD1
#
# run as:
# > cd /mnt/app/eso
# > . bin/runHMI.sh

RUN_HMI_REAL="${_}.real"

waitfor /fs/sda0 5 > /dev/null 2>&1

logtarget=/dev/null

if [ -d /fs/sda0/Logs ]; then
    mount -uw /fs/sda0
    logtarget=/fs/sda0/Logs/mmxlog.txt
    if [ -e ${logtarget}.1 ]; then
        mv ${logtarget}.1 ${logtarget}.2
    fi
    if [ -e ${logtarget} ]; then
        mv ${logtarget} ${logtarget}.1
    fi
fi

if command -v tee > /dev/null 2>&1
then    
    echo "Running ${RUN_HMI_REAL} with tee to ${logtarget}" >${logtarget}
    . ${RUN_HMI_REAL} "$@" 2>&1 | tee -a ${logtarget}
else
    echo "Running ${RUN_HMI_REAL} with output to ${logtarget}" >${logtarget}
    . ${RUN_HMI_REAL} "$@" >> ${logtarget} 2>&1
fi
EOF

fi

if [ ! -e ${VOLUME}/Logs ]; then
  echo "Creating Logs folder on SD"
  mkdir -p ${VOLUME}/Logs
fi

mount -ur /mnt/app

if [ ! -e /net/mmx/fs/sda0 ]; then
 echo "It looks like your SD card is in SD2, it must be in SD1 to use logging"
fi


echo ""
echo "After reboot, mmx logs will be in SD1 Logs folder."
echo "Done, please restart headunit"
