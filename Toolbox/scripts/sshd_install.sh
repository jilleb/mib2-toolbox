#!/bin/sh

SCRIPTDIR=$( cd -P -- "$(dirname -- "$(command -v -- "$_")")" && pwd -P )
SSD_INSTALL_DIR="/net/mmx/mnt/app/eso/hmi/engdefs/scripts/ssh"

export LD_LIBRARY_PATH=/net/mmx/mnt/app/root/lib-target:/net/mmx/eso/lib:/net/mmx/mnt/app/usr/lib:/net/mmx/mnt/app/armle/lib:/net/mmx/mnt/app/armle/lib/dll:/net/mmx/mnt/app/armle/usr/lib
export PATH=${SCRIPTDIR}:${SSD_INSTALL_DIR}/usr/bin:${SSD_INSTALL_DIR}/usr/sbin:/proc/boot:/bin:/usr/bin:/usr/sbin:/sbin:/mnt/app/media/gracenote/bin:/mnt/app/armle/bin:/mnt/app/armle/sbin:/mnt/app/armle/usr/bin:/mnt/app/armle/usr/sbin

. ${SCRIPTDIR}/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
  echo "No SD-card found, quitting"
  exit 0
fi

PUB_KEY_PATH="${VOLUME}/Custom/id_rsa.pub"
SSHD_APP="${VOLUME}/Toolbox/apps/sshd"


# Make it writable
mount -uw /mnt/app
mount -uw /mnt/system

mkdir -p ${SSD_INSTALL_DIR}/etc

cp -prv ${SSHD_APP}/etc/* ${SSD_INSTALL_DIR}/etc/
cp -prv ${SSHD_APP}/usr ${SSD_INSTALL_DIR}/
chmod 755 ${SSD_INSTALL_DIR}/usr/bin/*
chmod 755 ${SSD_INSTALL_DIR}/usr/sbin/*
sed -ir 's:\r$::g' ${SSD_INSTALL_DIR}/usr/sbin/start_sshd
sed -ir 's:\r$::g' ${SSD_INSTALL_DIR}/etc/banner.txt

if [ -f ${PUB_KEY_PATH} ]; then
  mkdir -p /root/.ssh
  chmod 600 /root/.ssh
  chmod 644 /mnt/app/root
  cp -prv ${PUB_KEY_PATH} /root/.ssh/authorized_keys
  chmod 644 /root/.ssh/authorized_keys
  echo "SSH public key installed from ${PUB_KEY_PATH} > /root/.ssh/authorized_keys"
else
  echo "SSH public key not at SD/Custom/id_rsa.pub - password login only"
fi

echo "Adding paths to /root/.profile"
echo "export PATH=${PATH}" > /root/.profile
echo "export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}" >> /root/.profile

echo "PS1='\${USER}@mmx:\${PWD}> '" >> /root/.profile
echo "export PS1" >> /root/.profile


echo "Copy scp wrapper"
cp ${SSHD_APP}/scp_wrapper /root/scp
chmod 755 /root/scp
sed -ir 's:\r$::g' /root/scp

if [ ! -f ${SSD_INSTALL_DIR}/etc/ssh_host_dsa_key ]; then
  ssh-keygen -t dsa -N '' -f ${SSD_INSTALL_DIR}/etc/ssh_host_dsa_key
fi
if [ ! -f ${SSD_INSTALL_DIR}/etc/ssh_host_rsa_key ]; then
  ssh-keygen -t rsa -N '' -f ${SSD_INSTALL_DIR}/etc/ssh_host_rsa_key -b 1024
fi
if [ ! -f ${SSD_INSTALL_DIR}/etc/ssh_host_key ]; then
  ssh-keygen -t rsa -N '' -f ${SSD_INSTALL_DIR}/etc/ssh_host_key -b 1024
fi

# Manually start the sshd server (you need to specify the full path):
# slay -v inetd
# ${SSD_INSTALL_DIR}/usr/sbin/sshd -ddd -f ${SSD_INSTALL_DIR}/etc/sshd_config
# If something isn't working start the server with debug output enabled and the problem should become obvious: /usr/sbin/sshd -ddd

if [ ! -f /mnt/system/etc/inetd.conf.bu ]; then
	cp -pv /mnt/system/etc/inetd.conf /mnt/system/etc/inetd.conf.bu
fi
echo "Adding config to automatically start sshd from inetd"
# Remove any existing lines for sshd
sed -i -r 's:^.*sshd.*\n*::p' /mnt/system/etc/inetd.conf
# Add new command for sshd
echo "ssh        stream tcp nowait root ${SSD_INSTALL_DIR}/usr/sbin/start_sshd in.sshd" >> /mnt/system/etc/inetd.conf

# Open up sshd port in firewall
echo "Add firewall configuration"
if [ ! -f /mnt/system/etc/pf.conf.bu ]; then
	cp -pv /mnt/system/etc/pf.conf /mnt/system/etc/pf.conf.bu
fi
cp -pv /mnt/system/etc/pf.conf.bu /mnt/system/etc/pf.conf

echo "" >> /mnt/system/etc/pf.conf
echo "# Allow sshd on wifi" >> /mnt/system/etc/pf.conf

UPNP_ALLOW=$(grep 49152 /mnt/system/etc/pf.conf | grep "pass in")
SSHD_ALLOW=$(echo ${UPNP_ALLOW} | sed -r 's:49152:22:g')
echo "${SSHD_ALLOW}" >> /mnt/system/etc/pf.conf
/mnt/app/armle/sbin/pfctl -F all -f /mnt/system/etc/pf.conf

echo "Restart inetd"
slay -v inetd
sleep 1
inetd

# Make readonly again
mount -ur /mnt/app
mount -ur /mnt/system

echo Done.

exit 0
