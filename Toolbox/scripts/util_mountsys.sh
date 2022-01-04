# MIB2 script, part of the MIB High toolbox.
# Coded by Jille & Olli
# This script will mount all neccessary mountpoints of the filesystem writeable

# Currently defined mountpoints:
# 1 = /net/mmx/mnt/app
# 2 = /net/mmx/mnt/system
# 3 = /net/mmx/ifs
# 4 = /net/rcc/mnt/efs-persist
# 5 = /net/mmx/mnt/persist
# 6 = /net/mmx/mnt/gracenotedb
# 7 = /net/rcc/mnt/efs-system


# Mountpoint detection
if [ -z "$(echo $MIBPATH | grep '/net/mmx/mnt/app')" ]; then
	export MOUNTPOINT="/net/mmx/mnt/app"
elif [ -z "$(echo $MIBPATH | grep '/net/mmx/mnt/system')" ]; then
	export MOUNTPOINT="/net/mmx/mnt/system"
elif [ -z "$(echo $MIBPATH | grep '/net/mmx/ifs')" ]; then
	export MOUNTPOINT="/net/mmx/ifs"
elif [ -z "$(echo $MIBPATH | grep '/net/mmx/mnt/persist')" ]; then
	export MOUNTPOINT="/net/mmx/mnt/persist"
elif [ -z "$(echo $MIBPATH | grep '/net/mmx/mnt/gracenotedb')" ]; then
	export MOUNTPOINT="/net/mmx/mnt/gracenotedb"
elif [ -z "$(echo $MIBPATH | grep '/net/rcc/mnt/efs-persist')" ]; then
	export MOUNTPOINT="/net/rcc/mnt/efs-persist"
elif [ -z "$(echo $MIBPATH | grep '/net/rcc/mnt/efs-system')" ]; then
	export MOUNTPOINT="/net/rcc/mnt/efs-system"
else
	echo "No mountpoint defined. Aborting"
	exit 0
fi

# Define mountpoints if there are more then one is defined
if [ -z "$(echo $MIBPATH2 | grep '/net/mmx/mnt/app')" ]; then
	export MOUNTPOINT2="/net/mmx/mnt/app"
elif [ -z "$(echo $MIBPATH2 | grep '/net/mmx/mnt/system')" ]; then
	export MOUNTPOINT2="/net/mmx/mnt/system"
elif [ -z "$(echo $MIBPATH2 | grep '/net/mmx/ifs')" ]; then
	export MOUNTPOINT2="/net/mmx/ifs"
elif [ -z "$(echo $MIBPATH2 | grep '/net/mmx/mnt/persist')" ]; then
	export MOUNTPOINT2="/net/mmx/mnt/persist"
elif [ -z "$(echo $MIBPATH2 | grep '/net/mmx/mnt/gracenotedb')" ]; then
	export MOUNTPOINT2="/net/mmx/mnt/gracenotedb"
elif [ -z "$(echo $MIBPATH2 | grep '/net/rcc/mnt/efs-persist')" ]; then
	export MOUNTPOINT2="/net/rcc/mnt/efs-persist"
elif [ -z "$(echo $MIBPATH2 | grep '/net/rcc/mnt/efs-system')" ]; then
	export MOUNTPOINT2="/net/rcc/mnt/efs-system"
else 
	export MOUNTPOINT2="undefined"
fi

# Mount defined system volume writeable	
echo "Mounting system writeable"
mount -uw $MOUNTPOINT
if [ $MOUNTPOINT2 != "undefined" ]; then
	mount -uw $MOUNTPOINT2
fi
echo
sleep .5