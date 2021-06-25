#!/bin/sh
# This script is meant to recover all skins
# Author: Jille & Olli & lprot
########################################################################################

# Info
export TOPIC=Skinfiles
export DESCRIPTION="This script will recover the backupped skinfiles"
export MOUNTPOINT=1

echo $DESCRIPTION

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

# Include SD card mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh

# Backup folder definition
if [[ $BRAND == "Volkswagen" || $BRAND == "Skoda" || $BRAND == "Seat" ]]; then
	BACKUP=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC
	MIBPATH=/eso/hmi/lsd/Resources/
	COPYTYPE=1	
	
elif [[ $BRAND == "Audi" || $BRAND == "Porsche"  || $BRAND == "Bentley" || $BRAND == "Lamborghini" ]]; then
	BACKUP=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC/$BRAND
	BACKUP2=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC/$BRAND-Car
	MIBPATH=/eso/hmi/lsd/images
	MIBPATH2=/eso/content.kzb
	COPYTYPE=2	
	
else
	echo "No brand detected. Aborting"
	exit 0
fi

# Include writeable system mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsys.sh

# Starting the restore process
echo "Copying all skin files from backup folder to the unit"
echo "Please be patient"
sleep 1

# Restore files
# Checkup for the correct copy type to use
if [ $COPYTYPE == 1 ];then
	# Restoring skins for SEAT, SKODA and VW
	# Checkup if a backup is present
	
	# Restore file(s) to unit
	echo "Copying all skin files from backup folder to the unit, please wait..."
	for i in $BACKUP/skin*; do
		#Extract skin folder name
		FOLDER=${i##*/}
		if [ -f $i/images.mcf ]; then
			cp -f $i/images.mcf $MIBPATH/$FOLDER/images.mcf
			echo "images.mcf of $FOLDER is restored"
			RESTORE=yes
		fi
		if [ -f $i/ambienceColorMap.res ]; then
			cp -f $i/ambienceColorMap.res $MIBPATH/$FOLDER/ambienceColorMap.res
			echo "ambienceColorMap of $FOLDER is restored"
			RESTORE=yes
		fi
	done	
else
	# Restoring skins for AUDI, BENTLEY, LAMBORGHINI and PORSCHE 
	# Checkup if a backup is present 
	if [ -d $BACKUP ]; then
		cp -R $BACKUP $MIBPATH
		echo "Skin graphics restored"
		RESTORE=yes
		sleep 1
	else
		echo "No skin graphics backup found"
		sleep 1
	fi
	
	# Restoring car graphics container
	echo
	echo "Copying all ambience files from backup folder to the unit"
	echo "Please be patient"
	sleep 1	
	# Checkup if a backup is present
	if [ -f $BACKUP2/content.kzb ]; then
		cp $BACKUP2/content.kzb $MIBPATH2
		echo "Car graphic container restored"
		RESTORE=yes
		sleep 1
	else
		echo "No Car graphic container backup found"
		sleep 1
	fi
fi

# Include back to read-only system mount script
. /eso/hmi/engdefs/scripts/mqb/util_unmountsys.sh

# Conclusion
if [ -n "$RESTORE" ]; then
	echo "Done. Please restart the unit"
else
	echo "No backups found. Nothing to restore"
fi

exit 0
