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

# Make it writable
mount -uw /mnt/app
mount -uw /mnt/system

# Copy VNC binary from sd card to main unit
echo "Copying VNC client binary."
cp ${VNC_APP}/opengl-render-qnx /navigation/opengl-render-qnx

echo "Modifying startup.sh"
# Name of the file to modify
FILE="/etc/boot/startup.sh"

# Check if the block of code is already present
if ! grep -qF "# QNX VNC CLIENT" "$FILE"; then
  # If not, append it after the specified section
  sed -i '/# DCIVIDEO: Kombi Map/ {
    N
    N
    N
    N
    a \
    # QNX VNC CLIENT \
    if [ -f /navigation/opengl-render-qnx ]; then \
        chmod 0777 /navigation/opengl-render-qnx \
        /navigation/opengl-render-qnx & \
    else \
        echo "File /navigation/opengl-render-qnx does not exist." \
    fi
  }' "$FILE"
else
  echo "Block already present. Modification of startup.sh skipped."
fi

# Make readonly again
mount -ur /mnt/app
mount -ur /mnt/system

echo Done.

exit 0