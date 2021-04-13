#!/bin/sh
# esd vim199.sh v0.1.0 (2021-02-22 by MIBonk)
# modified for MIB2Toolbox by Olli & jille
export PATH=:/proc/boot:/sbin:/bin:/usr/bin:/usr/sbin:/net/mmx/bin:/net/mmx/usr/bin:/net/mmx/usr/sbin:/net/mmx/sbin:/net/mmx/mnt/app/armle/bin:/net/mmx/mnt/app/armle/sbin:/net/mmx/mnt/app/armle/usr/bin:/net/mmx/mnt/app/armle/usr/sbin
export LD_LIBRARY_PATH=/net/mmx/mnt/app/root/lib-target:/net/mmx/mnt/eso/lib:/net/mmx/eso/lib:/net/mmx/mnt/app/usr/lib:/net/mmx/mnt/app/armle/lib:/net/mmx/mnt/app/armle/lib/dll:/net/mmx/mnt/app/armle/usr/lib
export IPL_CONFIG_DIR=/etc/eso/production
export TOPIC=VIM6
export DESCRIPTION="This script will patch VIM to 199 km/h"

echo $DESCRIPTION

. /eso/hmi/engdefs/scripts/mqb/util_info.sh

VIM=$(on -f mmx /eso/bin/dumb_persistence_reader 0 3221422082 2> /dev/null)
VIM=$(echo $VIM | awk '{print toupper($0)}')  
BC="/eso/hmi/engdefs/scripts/mqb/sbin/bc"

if [ ! -z $VIM 2>/dev/null ]; then
	echo "VIM on Unit: "$VIM""
	POSITION=0
	HEXVALUE=c7
	if [ $(echo $HEXVALUE | wc -c) -eq 3 ] ; then	
		HEXVALUE=$(echo $HEXVALUE | awk '{print toupper($0)}') 
		VIM=$(echo $VIM | cut -c1-56)
		LENGTH=$(echo $VIM | wc -c)
		LENGTH=$(echo $LENGTH -3 | $BC)
		if [ $POSITION -le $LENGTH ] && [ $(( $POSITION % 2 )) -eq 0 ]; then
			if [ $POSITION -ge "2" ]; then
				PRI=$(echo $VIM | cut -c1-$POSITION)
			else
				PRE=""
			fi
			if [ $POSITION -ne $LENGTH ]; then
				POSITION=$(echo $POSITION +3 | $BC)
				SEC=$(echo $VIM | cut -c$POSITION-$(echo $LENGTH +2 | $BC))
			else
				SEC=""
			fi
			VIMPATCH=$PRI$HEXVALUE$SEC
			echo "Calculating new checksum"
			# Include CRC utility
			. /eso/hmi/engdefs/scripts/mqb/util_crc16.sh $VIMPATCH
			# Patching persistence adress 
			VIMPATCH=$VIMPATCH$crcsum
			on -f mmx /net/mmx/eso/bin/apps/pc b:0:3221422082 $VIMPATCH
			on -f mmx /net/mmx/eso/bin/apps/pc b:0:1 0
			DEZ=$(echo "ibase=16; $HEXVALUE" | $BC)
			echo "VIM is now patched on byte $POSITION with $DEZ km/h (0x$HEXVALUE)"
			echo "System reboot will start soon"
			sleep 5
			# Include reboot utility
			. /eso/hmi/engdefs/scripts/mqb/util_reboot.sh
		else
			echo "Wrong position"
		fi
	else	
		echo "No binary hex digits in value"
	fi
else
	echo "There is no flashpart for VIM!"
fi

exit 0
