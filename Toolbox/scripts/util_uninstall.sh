#!/bin/sh

#Info
DESCRIPTION="This script will uninstall the MIB Toolbox"

echo $DESCRIPTION

. /eso/hmi/engdefs/scripts/mqb/util_info.sh

mount -uw /mnt/app

echo "Deleting old mqbcoding.esd pre v4.1"
rm -v /mnt/app/eso/hmi/engdefs/mqbcoding.esd
rm -rv /mnt/app/eso/hmi/engdefs/mqbcoding.esd.*

echo "Deleting Toolbox GreenMenus"
rm -rv /mnt/app/eso/hmi/engdefs/mqb*.esd
rm -rv /mnt/app/eso/hmi/engdefs/mqb*.esd.*

echo "Deleting Toolbox Demo GreenMenus, if installed"
rm -v /mnt/app/eso/hmi/engdefs/Demo.esd
rm -v /mnt/app/eso/hmi/engdefs/Demo_sub.esd
rm -v /mnt/app/eso/hmi/engdefs/example.esd
rm -v /mnt/app/eso/hmi/engdefs/mqbcoding_tests.esd

echo "Deleting old MIB Toolbox scripts pre v4.1"
rm -rv /mnt/app/eso/bin/PhoneCustomer/*.sh
rm -rv /mnt/app/eso/bin/PhoneCustomer/default/*.sh
rm -rv /mnt/app/eso/bin/PhoneCustomer/scripts

echo "Deleting MIB Toolbox scripts"
rm -rv /mnt/app/eso/hmi/engdefs/scripts/mqb/*.sh
rm -rv /mnt/app/eso/hmi/engdefs/scripts/mqb


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

mount -ur /mnt/app
mount -ur /mnt/system

echo "Uninstall complete. Please reboot unit."

exit 0