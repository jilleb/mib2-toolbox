#!/bin/sh
# esd vim.sh v0.1.0 (2021-03-10 by MIBonk)
# modified for MIB2Toolbox by Olli & jille
export PATH=:/proc/boot:/sbin:/bin:/usr/bin:/usr/sbin:/net/mmx/bin:/net/mmx/usr/bin:/net/mmx/usr/sbin:/net/mmx/sbin:/net/mmx/mnt/app/armle/bin:/net/mmx/mnt/app/armle/sbin:/net/mmx/mnt/app/armle/usr/bin:/net/mmx/mnt/app/armle/usr/sbin
export LD_LIBRARY_PATH=/net/mmx/mnt/app/root/lib-target:/net/mmx/mnt/eso/lib:/net/mmx/eso/lib:/net/mmx/mnt/app/usr/lib:/net/mmx/mnt/app/armle/lib:/net/mmx/mnt/app/armle/lib/dll:/net/mmx/mnt/app/armle/usr/lib
export IPL_CONFIG_DIR=/etc/eso/production
export TOPIC=VIM
export DESCRIPTION="This script will patch VIM"

echo $DESCRIPTION

. /eso/hmi/engdefs/scripts/mqb/util_info.sh

VIM=$(on -f mmx /eso/bin/dumb_persistence_reader 0 3221422082 2> /dev/null)
VIM=$(echo $VIM | awk '{print toupper($0)}')  

if [ ! -z $VIM 2>/dev/null ]; then
	echo "VIM on Unit: "$VIM""
	VIMPATCH=$(echo $VIM | cut -c1-56)
	echo "Calculating new checksum"
	# Include CRC utility
	. /eso/hmi/engdefs/scripts/mqb/util_crc16.sh $VIMPATCH
	# Patching persistence adress 
	VIMPATCH=$VIMPATCH$crcsum
	on -f mmx /net/mmx/eso/bin/apps/pc b:0:3221422082 $VIMPATCH
	on -f mmx /net/mmx/eso/bin/apps/pc b:0:1 0
	echo "Advanced VIM modifications are now patched to $VIMPATCH"
	echo "System reboot will start soon"
	sleep 5
	# Include reboot utility
	. /eso/hmi/engdefs/scripts/mqb/util_reboot.sh
else
	echo "There is no flashpart for VIM!"
fi

exit 0
