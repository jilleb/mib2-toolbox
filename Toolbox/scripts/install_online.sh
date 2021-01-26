#!/bin/sh

#Info
DESCRIPTION="This script will import and overwrite online files"

echo $DESCRIPTION


. /eso/bin/PhoneCustomer/default/util_info.sh

echo "Mounting SD-Card"
. /eso/bin/PhoneCustomer/default/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi

# Make app volume writable
echo "Mounting app folder"
mount -uw /mnt/app

echo "Copying and overwriting files"
new_jar_files=`ls $VOLUME/Custom/Online | grep .jar`
for new_jar_file in $new_jar_files
do
	old_jar=`ls /net/mmx/mnt/app/eso/bundles/$new_jar_file`
	if [[ ! -z "$old_jar"  ]] ; then
		cp -fV $VOLUME/Custom/Online/$new_jar_file $old_jar
	fi
done

echo "Copying special OnlineMenu to unit"
cp -V $VOLUME/Custom/Online/OnlineMenu.esd /net/mmx/mnt/app/eso/hmi/engdefs/OnlineMenu.esd
# Make readonly again
mount -ur /mnt/app
mount -ur $VOLUME


echo "Done"

exit 0
