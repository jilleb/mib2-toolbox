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

# Fileinfo
VNC_APP="${VOLUME}/Toolbox/apps/vncclient"
VNC_CONFIG="${VOLUME}/Custom/VNCClient"

# Make it writable
mount -uw /mnt/app
mount -uw /mnt/system

# Copy VNC binary from sd card to main unit
echo "Copying VNC client binary."
cp ${VNC_APP}/opengl-render-qnx /navigation/opengl-render-qnx
echo "Copying VNC client config file."
cp ${VNC_CONFIG}/config.txt /navigation/config.txt

# Name of the file to modify
FILE="/etc/boot/startup.sh"
BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/VNCClient

# Backup
echo "Making file backup..."
echo "Source: $FILE"
echo "Destination: Backup/$VERSION/$FAZIT/VNCClient"

FILENAME=startup.sh
if [ -f "$BACKUPFOLDER/$FILENAME" ]; then
	echo "Backup already exists. Skipping..."
else
	echo "Copying file, please wait..."
	mkdir -p ${BACKUPFOLDER}
	touch $BACKUPFOLDER/DONT_TOUCH_ANYTHING_HERE
	cp ${FILE} ${BACKUPFOLDER}/
	echo "Backup is done."
fi
sleep .5

# Editing Startup
if [ -f $BACKUPFOLDER/startup.sh ]; then
	echo "VNC server IP is set to 10.173.189.58. If you got another one, can be"
	echo "seen within droidVNC, please restore startup.sh and edit the"
    echo "vncclient-install-autorun.sh again."
	echo ""
	echo "Start modifying startup.sh to autoboot VNC client..."

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
				cd /navigation \
				./opengl-render-qnx 10.173.189.58 & \
			else \
				echo "File /navigation/opengl-render-qnx does not exist." \
			fi
		}' "$FILE"
	else
		echo "Block already present. Modification of startup.sh skipped."
	fi
else 
    echo "Backup not found. It's not safe to continue"
    echo "Please make sure your SD-card is writable"
	# Make readonly again
	mount -ur /mnt/app
	mount -ur /mnt/system
    exit 0   
fi	

echo "Modification of startup.sh done."
echo "Backup is stored at $BACKUPFOLDER"
echo ""
echo "Please restart headunit"

# Make readonly again
mount -ur /mnt/app
mount -ur /mnt/system

exit 0