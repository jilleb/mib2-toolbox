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

if [ -f /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin0.sh ]; then
	rm /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin0.sh
	CLEANUP=yes
fi
if [ -f /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin1.sh ]; then
	rm /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin1.sh
	CLEANUP=yes
fi
if [ -f /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin2.sh ]; then
	rm /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin2.sh
	CLEANUP=yes
fi
if [ -f /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin3.sh ]; then
	rm /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin3.sh
	CLEANUP=yes
fi
if [ -f /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin4.sh ]; then
	rm /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin4.sh
	CLEANUP=yes
fi
if [ -f /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin5.sh ]; then
	rm /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin5.sh
	CLEANUP=yes
fi
if [ -f /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin6.sh ]; then
	rm /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin6.sh
	CLEANUP=yes
fi
if [ -f /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin1_ambient.sh ]; then
	rm /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin1_ambient.sh
	CLEANUP=yes
fi
if [ -f /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin2_ambient.sh ]; then
	rm /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin2_ambient.sh
	CLEANUP=yes
fi
if [ -f /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin3_ambient.sh ]; then
	rm /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin3_ambient.sh
	CLEANUP=yes
fi
if [ -f /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin4_ambient.sh ]; then
	rm /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin4_ambient.sh
	CLEANUP=yes
fi
if [ -f /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin5_ambient.sh ]; then
	rm /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin5_ambient.sh
	CLEANUP=yes
fi
if [ -f /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin6_ambient.sh ]; then
	rm /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin6_ambient.sh
	CLEANUP=yes
fi
if [ -f /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin1_language.sh ]; then
	rm /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin1_language.sh
	CLEANUP=yes
fi
if [ -f /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin2_language.sh ]; then
	rm /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin2_language.sh
	CLEANUP=yes
fi
if [ -f /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin3_language.sh ]; then
	rm /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin3_language.sh
	CLEANUP=yes
fi
if [ -f /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin4_language.sh ]; then
	rm /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin4_language.sh
	CLEANUP=yes
fi
if [ -f /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin5_language.sh ]; then
	rm /mnt/app/eso/hmi/engdefs/scripts/mqb/install_skin5_language.sh
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
