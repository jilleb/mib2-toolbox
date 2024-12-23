#!/bin/sh
export PATH=/proc/boot:/bin:/usr/bin:/usr/sbin:/sbin:/mnt/app/media/gracenote/bin:/mnt/app/armle/bin:/mnt/app/armle/sbin:/mnt/app/armle/usr/bin:/mnt/app/armle/usr/sbin:$PATH

if [ "$_" = "/bin/on" ]; then BASE="$0"; else BASE="$_"; fi
SCRIPTDIR=$( cd -P -- "$(dirname -- "$(command -v -- "$BASE")")" && pwd -P )

. ${SCRIPTDIR}/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
  echo "No SD-card found, quitting"
  exit 0
fi
VNC_APP="${VOLUME}/Toolbox/apps/vncclient"
VNC_CONFIG="${VOLUME}/Custom/VNCClient"

# Make it writable
mount -uw /mnt/app

# Copy VNC binary from sd card to main unit
echo "Copying VNC client binary."
cp ${VNC_APP}/opengl-render-qnx /navigation/opengl-render-qnx
echo "Copying VNC client config file."
cp ${VNC_CONFIG}/config.txt /navigation/config.txt
echo "Set permissions"
chmod 0777 /navigation/opengl-render-qnx

# Make readonly again
mount -ur /mnt/app

echo Done.

exit 0