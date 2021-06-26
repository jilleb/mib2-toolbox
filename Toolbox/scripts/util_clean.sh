#!/bin/sh
# Coded by Olli
# This script will cleanup old stuff, which which isn't used anymore
########################################################################################
# Info
export MIBPATH=/net/mmx/mnt/app/eso/hmi/engdefs/

echo "Starting cleanup of old stuff, which isn't used anymore"

# Include writeable system mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsys.sh

echo "Deleting GreenMenus, which aren't used anymore..."
if [ -f /mnt/app/eso/hmi/engdefs/mqb-adaptions.esd ]; then
	rm /mnt/app/eso/hmi/engdefs/mqb-adaptions.esd
	CLEANUP=yes
fi
if [ -f /mnt/app/eso/hmi/engdefs/mqb-rccAdaptions.esd ]; then	
	rm /mnt/app/eso/hmi/engdefs/mqb-rccAdaptions.esd
	CLEANUP=yes
fi

echo "Deleting scripts, which aren't used anymore...."
if [ -f /mnt/app/eso/hmi/engdefs/scripts/mqb/install_online.sh ]; then
	rm /mnt/app/eso/hmi/engdefs/scripts/mqb/install_online.sh
	CLEANUP=yes
fi
if [ -f /mnt/app/eso/hmi/engdefs/scripts/mqb/dump_online.sh ]; then
	rm /mnt/app/eso/hmi/engdefs/scripts/mqb/dump_online.sh
	CLEANUP=yes
fi
if [ -f /mnt/app/eso/hmi/engdefs/scripts/mqb/set_VIM.sh ]; then
	rm /mnt/app/eso/hmi/engdefs/scripts/mqb/set_VIM.sh
	CLEANUP=yes
fi
if [ -f /mnt/app/eso/hmi/engdefs/scripts/mqb/set_displaycontexts.sh ]; then
	rm /mnt/app/eso/hmi/engdefs/scripts/mqb/set_displaycontexts.sh
	CLEANUP=yes
fi
if [ -f /mnt/app/eso/hmi/engdefs/scripts/mqb/set_displaycontexts_1.sh ]; then
	rm /mnt/app/eso/hmi/engdefs/scripts/mqb/set_displaycontexts_1.sh
	CLEANUP=yes
fi

# Include back to read-only system mount script
. /eso/hmi/engdefs/scripts/mqb/util_unmountsys.sh

# Conclusion
if [ "$CLEANUP" == "yes" ]; then
	echo
	echo "Cleanup complete"
else
	echo
	echo "No old files found, nothing to cleanup"
fi

exit 0