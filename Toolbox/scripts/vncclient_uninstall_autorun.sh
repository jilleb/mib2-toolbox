#!/bin/sh
export PATH=/proc/boot:/bin:/usr/bin:/usr/sbin:/sbin:/mnt/app/media/gracenote/bin:/mnt/app/armle/bin:/mnt/app/armle/sbin:/mnt/app/armle/usr/bin:/mnt/app/armle/usr/sbin:$PATH

if [ "$_" = "/bin/on" ]; then BASE="$0"; else BASE="$_"; fi
SCRIPTDIR=$( cd -P -- "$(dirname -- "$(command -v -- "$BASE")")" && pwd -P )

# Include info script
. ${SCRIPTDIR}/util_info.sh

# Include SD card mount script
. ${SCRIPTDIR}/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
  echo "No SD-card found, quitting"
  exit 0
fi

# Make it writable
mount -uw /mnt/app
mount -uw /mnt/system

# Remove VNC binary from main unit
echo "Removing VNC Client binary and config"
rm -fv /navigation/opengl-render-qnx
rm -fv /navigation/config.txt

# Restoring the files
OLDFILE=$VOLUME/Backup/$VERSION/$FAZIT/VNCClient
MIBPATH="/etc/boot/startup.sh"

echo "Resotoring old shartup.sh from backup"
echo "Source: Backup/$VERSION/$FAZIT/VNCClient/startup.sh"
echo "Destination: /etc/boot/"
if [ -f ${OLDFILE} ]; then
		echo "Recovering file, please wait..."
		cp ${OLDFILE} ${MIBPATH}
	else
		echo "ERROR: No files found"
		exit 0
	fi

# Make readonly again
mount -ur /mnt/app
mount -ur /mnt/system

exit 0