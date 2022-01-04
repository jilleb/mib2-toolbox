# MIB2 script, part of the MIB High toolbox.
# Coded by Jille & Olli
# This script will mount all mountpoints of the filesystem back to read-only
# Mountpoints are defined in util_mountsys.sh

echo "Mounting system read-only again"
mount -ur $MOUNTPOINT
if [ $MOUNTPOINT2 != "undefined" ]; then
	mount -ur $MOUNTPOINT2
fi
echo
sleep .5