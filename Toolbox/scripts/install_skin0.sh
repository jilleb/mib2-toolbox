#!/bin/sh
export SKINNAME=skin0
export TOPIC=Skinfiles
export MIBPATH=/eso/hmi/lsd/Resources/$SKINNAME/images.mcf
export SDPATH=/$TOPIC/$SKINNAME/images.mcf
export DESCRIPTION="This script will install $SKINNAME"
export TYPE="file"
echo $DESCRIPTION
. /eso/bin/PhoneCustomer/default/util_info.sh
. /eso/bin/PhoneCustomer/default/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi
export BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC/$SKINNAME
. /eso/bin/PhoneCustomer/default/util_backup.sh
. /eso/bin/PhoneCustomer/default/util_copy.sh
echo "Done. Now restart the unit."
exit 0