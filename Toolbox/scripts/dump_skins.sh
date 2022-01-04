#!/bin/sh
# This script will dump all skin files according to the detected brand
# Author: Olli
########################################################################################

# Info
export TOPIC=Skinfiles
export DESCRIPTION="This script will dump all skin files"

echo $DESCRIPTION

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

# Include SD card mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh

# Brand checkup because the folders are different
if [[ $BRAND == "Volkswagen" || $BRAND == "Skoda" || $BRAND == "Seat" ]]; then
	ORIGINAL=/eso/hmi/lsd/Resources
	DUMPFOLDER=$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC
	DUMPTYPE=1
	COPYTYPE=1	
	
elif [[ $BRAND == "Audi" || $BRAND == "Porsche"  || $BRAND == "Bentley" || $BRAND == "Lamborghini" ]]; then
	ORIGINAL=/eso/hmi/lsd/images
	ORIGINAL2=/eso/content.kzb
	DUMPFOLDER=$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC/$BRAND
	DUMPFOLDER2=$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC/$BRAND-Car
	DUMPTYPE=2
	COPYTYPE=2	
	
else
	echo "No brand detected. Aborting"
	exit 0
fi

# Make dump folder
if [ $DUMPTYPE == 1 ]; then
	echo "Skin dump folder: $DUMPFOLDER"
	mkdir -p $DUMPFOLDER
	echo "Dumping, please wait..."
	sleep 1
	
else 
	echo "Skin dump folder: $DUMPFOLDER"
	echo "Car graphics dump folder: $DUMPFOLDER2"
	mkdir -p $DUMPFOLDER
	mkdir -p $DUMPFOLDER2
	echo "Dumping, please wait..."
	sleep 1
fi

# Copy the files
if [ $COPYTYPE == 1 ]; then
	echo
	echo "Copying skins to SD-card. This could take a moment..."
	cp -R $ORIGINAL $DUMPFOLDER/
	
else
	echo
	echo "Copying skin to SD-card. This could take a moment..."
	cp -R $ORIGINAL $DUMPFOLDER/
	echo "Done"
	echo "Copying car graphics container to SD-card. This could take a moment..."
	cp $ORIGINAL2 $DUMPFOLDER2/
fi

echo
echo "Done. Skin dump can be found in the according dump folder on your SD-card"

exit 0
