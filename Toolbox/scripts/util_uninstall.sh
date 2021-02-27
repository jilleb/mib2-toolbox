#!/bin/sh

#Info
DESCRIPTION="This script will uninstall the MIB Toolbox"

echo $DESCRIPTION

. /eso/hmi/engdefs/scripts/mqb/util_info.sh

# Mount directories as writeable
mount -uw /mnt/app
mount -uw /net/rcc/mnt/efs-persist

# Check for old pre v4.1 versions
OLD_TOOLBOX=/mnt/app/eso/hmi/engdefs/mqbcoding.esd
if [[ -f $OLD_TOOLBOX ]]; then
	echo "Old Toolbox installation pre v4.1 found"
	echo "Deleting old mqbcoding.esd"
	rm $OLD_TOOLBOX
	rm -r ${OLD_TOOLBOX}.*
	
	echo "Deleting old Toolbox scripts"
	rm -r /mnt/app/eso/bin/PhoneCustomer/*.sh
	rm -r /mnt/app/eso/bin/PhoneCustomer/default/*.sh
	rm -r /mnt/app/eso/bin/PhoneCustomer/scripts
	
	echo "Deleting old Toolbox versions entry"
	rm /net/rcc/mnt/efs-persist/SWDL/FileCopyInfo/MQB.info
fi

# Deleting Toolbox GreenMenus
echo "Deleting Toolbox GreenMenus"
rm -r /mnt/app/eso/hmi/engdefs/mqb*.esd
rm -r /mnt/app/eso/hmi/engdefs/mqb*.esd.*

# Demo GreenMenu check
DEMO_FILE1=/mnt/app/eso/hmi/engdefs/Demo.esd
DEMO_FILE2=/mnt/app/eso/hmi/engdefs/Demo_sub.esd
DEMO_FILE3=/mnt/app/eso/hmi/engdefs/example.esd
DEMO_FILE4=/mnt/app/eso/hmi/engdefs/mqbcoding_tests.esd
if [[ -f $DEMO_FILE1 ]]; then
	echo "Demo GreenMenu found. Deleting"
	rm $DEMO_FILE1
	if [[ -f $DEMO_FILE2 ]]; then
		rm $DEMO_FILE2
	fi
	if [[ -f $DEMO_FILE3 ]]; then
		rm $DEMO_FILE3
	fi
	if [[ -f $DEMO_FILE4 ]]; then
		rm $DEMO_FILE4
	fi
fi

# Deleting Toolbox scripts
echo "Deleting MIB Toolbox scripts"
rm -r /mnt/app/eso/hmi/engdefs/scripts/mqb/*.sh
rm -r /mnt/app/eso/hmi/engdefs/scripts/mqb

# Deleting Toolbox version entry
echo "Deleting versions entry"
rm /net/rcc/mnt/efs-persist/SWDL/FileCopyInfo/Toolbox.info

# Deleting SSH install
SSD_INSTALL_DIR=/net/mmx/mnt/app/eso/hmi/engdefs/scripts/ssh
if [ -e ${SSD_INSTALL_DIR} ]; then
    echo "Uninstalling sshd"
    mount -uw /mnt/system

    rm -rf ${SSD_INSTALL_DIR}

    if [ -f /mnt/system/etc/inetd.conf.bu ]; then
        mv /mnt/system/etc/inetd.conf.bu /mnt/system/etc/inetd.conf
    fi
    rm -rf /root/.sshd
    rm -f /root/.profile
    rm -f /root/scp
    for PF in /net/mmx/mnt/system/etc/pf*.conf ; do
      if [ -f ${PF}.bu ]; then
        mv -f ${PF}.bu ${PF}
      fi
    done
fi

# Remount as read only
mount -ur /mnt/app
mount -ur /mnt/system
mount -ur /net/rcc/mnt/efs-persist

echo "Uninstall complete. Please reboot unit."

exit 0