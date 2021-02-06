#!/bin/ksh
# This script will cleanup old MIB Toolbox installations. 

echo "Cleanup, mounting app rw"
on -f mmx mount -uw /mnt/app

echo "Deleting old mqbcoding.esd pre v4.1"
echo "___________________________________" 
# Pass the command as a string to remote ksh preserve the *
on -f mmx ksh -c 'rm -rvf /eso/hmi/engdefs/mqbcoding.esd*'

echo "" 
echo "Deleting old MIB Toolbox scripts pre v4.1"
echo "__________________________________________" 
on -f mmx ksh -c 'rm -vf /eso/bin/PhoneCustomer/*.sh'
on -f mmx ksh -c 'rm -vf /eso/bin/PhoneCustomer/default/*.sh'
on -f mmx rm -rvf /eso/bin/PhoneCustomer/default/scripts

on -f mmx mount -ur /mnt/app

echo "Cleanup complete."
