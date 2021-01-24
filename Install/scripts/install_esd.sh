#!/bin/sh

#info
TOPIC=GreenMenu
DESCRIPTION="This script will copy custom ESD(Green Menu) files from GreenMenu folder on your SD to the unit."

echo $DESCRIPTION
. /eso/bin/PhoneCustomer/default/util_info.sh
. /eso/bin/PhoneCustomer/default/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi

# Make readonly again
mount -uw /mnt/app

cp $VOLUME/Custom/$TOPIC/*.esd /eso/hmi/engdefs/
cp $VOLUME/Custom/$TOPIC/scripts/*.sh /eso/hmi/engdefs/scripts/
chmod a+rwx /eso/hmi/engdefs/scripts/*


# Make readonly again
mount -ur /mnt/app
mount -ur $VOLUME

echo Done. Please restart green menu.

exit 0
