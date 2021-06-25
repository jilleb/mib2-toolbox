#!/bin/sh
# This script is meant to recover all skins
# Author: Jille & Olli
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
	if [ -f $BACKUP/skin0/images.mcf ]; then
		cp $BACKUP/skin0/images.mcf $MIBPATH/skin0/images.mcf
		echo "Skin0 restored"
		RESTORE=yes
		sleep 1
	else
		echo "No skin0 backup found"
		sleep 1
	fi
	if [ -f $BACKUP/skin1/images.mcf ]; then
		cp $BACKUP/skin1/images.mcf $MIBPATH/skin1/images.mcf
		echo "Skin1 restored"
		RESTORE=yes
		sleep 1
	else
		echo "No skin1 backup found"
		sleep 1
	fi
	if [ -f $BACKUP/skin2/images.mcf ]; then
		cp $BACKUP/skin2/images.mcf $MIBPATH/skin2/images.mcf
		echo "Skin2 restored"
		RESTORE=yes
		sleep 1
	else
		echo "No skin2 backup found"
		sleep 1
	fi	
	if [ -f $BACKUP/skin3/images.mcf ]; then
		cp $BACKUP/skin3/images.mcf $MIBPATH/skin3/images.mcf
		echo "Skin3 restored"
		RESTORE=yes
		sleep 1
	else
		echo "No skin3 backup found"
		sleep 1
	fi
	if [ -f $BACKUP/skin4/images.mcf ]; then
		cp $BACKUP/skin4/images.mcf $MIBPATH/skin4/images.mcf
		echo "Skin4 restored"
		RESTORE=yes
		sleep 1
	else
		echo "No skin4 backup found"
		sleep 1
	fi
	if [ -f $BACKUP/skin5/images.mcf ]; then
		cp $BACKUP/skin5/images.mcf $MIBPATH/skin5/images.mcf
		echo "Skin5 restored"
		RESTORE=yes
		sleep 1
	else
		echo "No skin5 backup found"
		sleep 1
	fi
	if [ -f $BACKUP/skin6/images.mcf ]; then
		cp $BACKUP/skin6/images.mcf $MIBPATH/skin6/images.mcf
		echo "Skin6 restored"
		RESTORE=yes
		sleep 1
	else
		echo "No skin6 backup found"
		sleep 1
	fi
	
	# Restoring ambienceColorMaps
	echo
	echo "Copying all ambience files from backup folder to the unit"
	echo "Please be patient"
	sleep 1	
	# Checkup if a backup is present
	if [ -f $BACKUP/skin1/ambienceColorMap.res ]; then
		cp $BACKUP/skin1/ambienceColorMap.res $MIBPATH/skin1/ambienceColorMap.res
		echo "Skin1 ambience restored"
		RESTORE=yes
		sleep 1
	else
		echo "No skin1 ambience backup found"
		sleep 1
	fi
	if [ -f $BACKUP/skin2/ambienceColorMap.res ]; then
		cp $BACKUP/skin2/ambienceColorMap.res $MIBPATH/skin2/ambienceColorMap.res
		echo "Skin2 ambience restored"
		RESTORE=yes
		sleep 1
	else
		echo "No skin2 ambience backup found"
		sleep 1
	fi	
	if [ -f $BACKUP/skin3/ambienceColorMap.res ]; then
		cp $BACKUP/skin3/ambienceColorMap.res $MIBPATH/skin3/ambienceColorMap.res
		echo "Skin3 ambience restored"
		RESTORE=yes
		sleep 1
	else
		echo "No skin3 ambience backup found"
		sleep 1
	fi
	if [ -f $BACKUP/skin4/ambienceColorMap.res ]; then
		cp $BACKUP/skin4/ambienceColorMap.res $MIBPATH/skin4/ambienceColorMap.res
		echo "Skin4 ambience restored"
		RESTORE=yes
		sleep 1
	else
		echo "No skin4 ambience backup found"
		sleep 1
	fi
	if [ -f $BACKUP/skin5/ambienceColorMap.res ]; then
		cp $BACKUP/skin5/ambienceColorMap.res $MIBPATH/skin5/ambienceColorMap.res
		echo "Skin5 ambience restored"
		RESTORE=yes
		sleep 1
	else
		echo "No skin5 ambience backup found"
		sleep 1
	fi
	if [ -f $BACKUP/skin6/ambienceColorMap.res ]; then
		cp $BACKUP/skin6/ambienceColorMap.res $MIBPATH/skin6/ambienceColorMap.res
		echo "Skin6 ambience restored"
		RESTORE=yes
		sleep 1
	else
		echo "No skin6 ambience backup found"
		sleep 1
	fi
	
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
if [ "$RESTORE" == "yes" ]; then
	echo
	echo "Done. Now restart the unit"
else
	echo
	echo "No backups found. Nothing to restore"
fi

exit 0
