# MIB2 script, part of the MIB High toolbox.
# Revision crcr16/CCITT-False v0.1.1 (2021-02-22 by MIBonk)
# Modified for MIB2Toolbox by Olli & Jille
# This script will calculate CRC checksums
<<<<<<< Updated upstream
=======

# Info
>>>>>>> Stashed changes
export PATH=:/proc/boot:/sbin:/bin:/usr/bin:/usr/sbin:/net/mmx/bin:/net/mmx/usr/bin:/net/mmx/usr/sbin:/net/mmx/sbin:/net/mmx/mnt/app/armle/bin:/net/mmx/mnt/app/armle/sbin:/net/mmx/mnt/app/armle/usr/bin:/net/mmx/mnt/app/armle/usr/sbin
export LD_LIBRARY_PATH=/net/mmx/mnt/app/root/lib-target:/net/mmx/mnt/eso/lib:/net/mmx/eso/lib:/net/mmx/mnt/app/usr/lib:/net/mmx/mnt/app/armle/lib:/net/mmx/mnt/app/armle/lib/dll:/net/mmx/mnt/app/armle/usr/lib
export IPL_CONFIG_DIR=/etc/eso/production

BC="/eso/hmi/engdefs/scripts/mqb/sbin/bc"

input=$1

string=$(echo $input | sed "s/.\{2\}/&:/g" | awk '{print toupper($0)}')
byte=$(echo "${string}" | awk -F ":" '{print NF-1}')
polynom=$(echo "ibase=16; 1021" | $BC) #0x1021 CCITT Polynom
crcsum=$(echo "ibase=16; FFFF" | $BC) #0xFFFF"
xorout=$(echo "ibase=16; FFFF" | $BC) #0xFFFF"

echo "Generateing crc16/CCITT-False checksum. Please wait"

count=1
while [ ${count} -le $byte ]
do
	hex=$(echo $string | awk -F : -v i=$count '{print $i}')
	dec=$(echo "ibase=16; $hex" | $BC)
	bin=$(echo "obase=2; ibase=16; $hex" | $BC)
	bin=$(echo "00000000"${bin} | tail -c9)
	crcsum=$(($crcsum ^ $(echo "$dec * 2 ^ 8" | $BC)))
	bit=0
	while [ $bit -lt 8 ]
	do
		result=$((crcsum <<= 1))
		if [ $result -ge "65536" ];then
			crcsum=$(($result ^ $polynom))
		fi
			crcsum=$((crcsum &= $xorout))
		bit=$(($bit+1))
	done
	count=$(($count+1))
done

crcsum="$(echo "obase=16; "$crcsum | $BC)"
echo "And the Winner is: $crcsum"
