#!/bin/sh

#info
TOPIC=Skinfiles
DESCRIPTION="This script will dump all skin files"
BRAND="$(/eso/bin/apps/pc i:0x286f058c:10 2> /dev/null)"

#Volumes/files
echo $DESCRIPTION

. /eso/hmi/engdefs/scripts/mqb/util_info.sh
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi

# Brand checkup because the folders are different
if [ $BRAND == "1" ]; then
	BRAND=Volkswagen
	ORIGINAL=/eso/hmi/lsd/Resources
	DUMPFOLDER=$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC
	DUMPTYPE=1
	COPYTYPE=1	
	echo "Brand detected: $BRAND"	
	
elif [ $BRAND == "2" ]; then
	BRAND=Audi
	ORIGINAL=/eso/hmi/lsd/images
	ORIGINAL2=/eso/content.kzb
	DUMPFOLDER=$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC/$BRAND
	DUMPFOLDER2=$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC/$BRAND-Car
	DUMPTYPE=2
	COPYTYPE=2	
	echo "Brand detected: $BRAND"	
	
elif [ $BRAND == "3" ]; then
	BRAND=Skoda
	ORIGINAL=/eso/hmi/lsd/Resources
	DUMPFOLDER=$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC
	DUMPTYPE=1
	COPYTYPE=1	
	echo "Brand detected: $BRAND"
	
elif [ $BRAND == "4" ]; then
	BRAND=Seat
	ORIGINAL=/eso/hmi/lsd/Resources
	DUMPFOLDER=$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC
	DUMPTYPE=1
	COPYTYPE=1	
	echo "Brand detected: $BRAND"
	
elif [ $BRAND == "5" ]; then
	BRAND=Porsche
	ORIGINAL=/eso/hmi/lsd/images
	ORIGINAL2=/eso/content.kzb
	DUMPFOLDER=$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC/$BRAND
	DUMPFOLDER2=$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC/$BRAND-Car
	DUMPTYPE=2
	COPYTYPE=2	
	echo "Brand detected: $BRAND"
	
elif [ $BRAND == "6" ]; then
	BRAND=Bentley
	ORIGINAL=/eso/hmi/lsd/images
	ORIGINAL2=/eso/content.kzb
	DUMPFOLDER=$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC/$BRAND
	DUMPFOLDER2=$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC/$BRAND-Car
	DUMPTYPE=2
	COPYTYPE=2	
	echo "Brand detected: $BRAND"
	
elif [ $BRAND == "7" ]; then
	BRAND=Lamborghini
	ORIGINAL=/eso/hmi/lsd/images
	ORIGINAL2=/eso/content.kzb
	DUMPFOLDER=$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC/$BRAND
	DUMPFOLDER2=$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC/$BRAND-Car
	DUMPTYPE=2
	COPYTYPE=2	
	echo "Brand detected: $BRAND"
fi

#Make dump folder
if [ $DUMPTYPE == 1 ]; then
	echo "Skin dump folder: $DUMPFOLDER"
	mkdir -p $DUMPFOLDER
	echo "Dumping, please wait."
	sleep 1
else 
	echo "Skin dump folder: $DUMPFOLDER"
	echo "Car graphics dump folder: $DUMPFOLDER2"
	mkdir -p $DUMPFOLDER
	mkdir -p $DUMPFOLDER2
	echo "Dumping, please wait."
	sleep 1
fi

# Copy the files
if [ $COPYTYPE == 1 ]; then
	echo
	echo "Copying skins to SD-card. This could take a moment"
	cp -R $ORIGINAL $DUMPFOLDER/
else
	echo
	echo "Copying skin to SD-card. This could take a moment"
	cp -R $ORIGINAL $DUMPFOLDER/
	echo "Done"
	echo "Copying car graphics container to SD-card. This could take a moment"
	cp $ORIGINAL2 $DUMPFOLDER2/
fi

# Make readonly again
mount -ur $VOLUME

echo Done. Skin dump can be found in the Dump folder on your SD-card

exit 0
