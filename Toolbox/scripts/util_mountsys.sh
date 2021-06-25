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

# Define mountpoints
if [ $MOUNTPOINT == "1" ]; then
	export MOUNTPOINT="/net/mmx/mnt/app"
elif [ $MOUNTPOINT == "2" ]; then
	export MOUNTPOINT="/net/mmx/mnt/system"
elif [ $MOUNTPOINT == "3" ]; then
	export MOUNTPOINT="/net/mmx/ifs"	
elif [ $MOUNTPOINT == "4" ]; then
	export MOUNTPOINT="/net/rcc/mnt/efs-persist"	
elif [ $MOUNTPOINT == "5" ]; then
	export MOUNTPOINT="/net/mmx/mnt/persist"	
elif [ $MOUNTPOINT == "6" ]; then
	export MOUNTPOINT="/net/mmx/mnt/gracenotedb"
else
	echo "No mountpoint defined. Aborting"
	exit 0
fi

# Define mountpoints if there are more then one is defined
if [ $MOUNTPOINT2 == "1" ]; then
	export MOUNTPOINT2="/net/mmx/mnt/app"
elif [ $MOUNTPOINT2 == "2" ]; then
	export MOUNTPOINT2="/net/mmx/mnt/system"
elif [ $MOUNTPOINT2 == "3" ]; then
	export MOUNTPOINT2="/net/mmx/ifs"	
elif [ $MOUNTPOINT2 == "4" ]; then
	export MOUNTPOINT2="/net/rcc/mnt/efs-persist"	
elif [ $MOUNTPOINT2 == "5" ]; then
	export MOUNTPOINT2="/net/mmx/mnt/persist"	
elif [ $MOUNTPOINT2 == "6" ]; then
	export MOUNTPOINT2="/net/mmx/mnt/gracenotedb"
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