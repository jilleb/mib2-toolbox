# MIB2 script, part of the MIB High toolbox.
# Coded by Olli
# This script will reboot your unit
########################################################################################

echo "Rebooting unit now"
echo "5"
sleep 1
echo "4"
sleep 1
echo "3"
sleep 1
echo "2"
sleep 1
echo "1"
sleep 1

mount -uw /mnt/system
touch /etc/ooc.allow.reset
echo hmi-sys-reset > /dev/ooc/reset
sleep 2

rm /etc/ooc.allow.reset
echo "Reboot request sent"