#!/bin/sh
# This script is meant to recover all skins
# Author: Jille & Olli & lprot
########################################################################################
# Info
export TOPIC=Skinfiles

echo "This script will recover the backupped skinfiles"

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

# Include SD card mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh

# Backup folder definition
if [[ $BRAND == "Volkswagen" || $BRAND == "Skoda" || $BRAND == "Seat" ]]; then
	BACKUP=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC
	export MIBPATH=/net/mmx/mnt/app/eso/hmi/lsd/Resources/
	COPYTYPE=1		
elif [[ $BRAND == "Audi" || $BRAND == "Porsche"  || $BRAND == "Bentley" || $BRAND == "Lamborghini" ]]; then
	BACKUP=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC/$BRAND
	BACKUP2=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC/$BRAND-Car
	export MIBPATH=/net/mmx/mnt/app/eso/hmi/lsd/images
	export MIBPATH2=/net/mmx/mnt/app/eso/content.kzb
	COPYTYPE=2		
else
	echo "No brand detected. Aborting"
	exit 0
fi

# Include writeable system mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsys.sh

# Starting the recovery process
echo "Recovering all skin files from backup folder to the unit"
echo "Please be patient..."
sleep 1

# Recover files
# Checkup for the correct copy type to use
if [ $COPYTYPE == 1 ]; then
	# Recovering skins for SEAT, SKODA and VW
	# Recovering file(s) to unit
	echo "Recovering all skin files from backup folder to the unit, please wait..."
	for i in $BACKUP/skin*; do
		#Extract skin folder name
		FOLDER=${i##*/}
		if [ -f $i/images.mcf ]; then
			cp -f $i/images.mcf $MIBPATH/$FOLDER/images.mcf
			echo "images.mcf of $FOLDER is recovered"
			RECOVERY=yes
		fi
		if [ -f $i/ambienceColorMap.res ]; then
			cp -f $i/ambienceColorMap.res $MIBPATH/$FOLDER/ambienceColorMap.res
			echo "ambienceColorMap of $FOLDER is recovered"
			RECOVERY=yes
		fi
	done	
else
	# Recover skins for AUDI, BENTLEY, LAMBORGHINI and PORSCHE 
	# Checkup if a backup is present 
	if [ -d $BACKUP ]; then
		cp -R $BACKUP $MIBPATH
		echo "Skin graphics recovered"
		RECOVERY=yes
		sleep 1
	else
		echo "No skin graphics backup found"
		sleep 1
	fi
	
	# Recover car graphics container
	echo
	echo "Recovering all ambience files from backup folder to the unit"
	echo "Please be patient..."
	sleep 1	
	# Checkup if a backup is present
	if [ -f $BACKUP2/content.kzb ]; then
		cp $BACKUP2/content.kzb $MIBPATH2
		echo "Car graphic container recovered"
		RECOVERY=yes
		sleep 1
	else
		echo "No Car graphic container backup found"
		sleep 1
	fi
fi

# Include back to read-only system mount script
. /eso/hmi/engdefs/scripts/mqb/util_unmountsys.sh

# Conclusion
if [ -n "$RECOVERY" ]; then
	echo "Done. Please restart the unit"
else
	echo "No backups found. Nothing to recover"
fi

exit 0
