#!/bin/ksh
# This script will copy file(s)
# Created by Olli, based on scripts by Jille

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

# Include SD card mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh

DUMPFOLDER=$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC
echo "Source $TYPE: $MIBPATH"
echo "Destination: Dump/$VERSION/$FAZIT/"
echo "             $SDPATH"

if [ "$TYPE" = "file" ]; then
	if [ -f $MIBPATH ]; then
		# Create destination and all intermediate folders if needed
		if [ ! -d "$DUMPFOLDER" ]; then
			echo "Creating folder..."
			mkdir -p $DUMPFOLDER
		fi
		echo "Copying, please wait..."
		# Special behaviour
		if [ $TOPIC = "IFS" ]; then
			cat ${MIBPATH} > ${DUMPFOLDER}/ifs_dump.bin
		elif [ $TOPIC = "Hosts" ]; then
			cp ${MIBPATH} ${DUMPFOLDER}/hosts.txt
		elif [ $TOPIC = "Shadowfile" ]; then
			cp ${MIBPATH} ${DUMPFOLDER}/shadow.txt
		elif [ $TOPIC = "Password" ]; then
			echo ${HASHMMX} ${DUMPFOLDER}/mmx_hash.txt
			echo ${HASHRCC} ${DUMPFOLDER}/rcc_hash.txt
		elif [ $TOPIC = "Displaymanager" ]; then
			/eso/bin/apps/dmdt gc > ${DUMPFOLDER}/gc.txt
		# Normal behaviour
		else
			cp ${MIBPATH} ${DUMPFOLDER}			
		fi		
		echo "Copying is completed."	
		# Show content
		if  [[ $TOPIC = "Hosts" || $TOPIC = "Firewall" || $TOPIC = "Shadowfile" ]]; then
			echo "Content of the file:"
			cat ${MIBPATH}
		elif [ $TOPIC = "Displaymanager" ]; then
			echo "Client information:"
			cat ${DUMPFOLDER}/gc.txt
		fi
	else
		echo "ERROR: Cannot open $MIBPATH"
	fi
elif [ -d $MIBPATH ]; then
	# Create destination and all intermediate folders if needed
	if [ ! -d "$DUMPFOLDER" ]; then
		echo "Creating folder..."
		mkdir -p $DUMPFOLDER
	fi
	echo "Copying, please wait..."
	cp -r ${MIBPATH}/. ${DUMPFOLDER}
	sync
	echo "Copying is completed." 
	if [ $TOPIC = "FEC" ]; then
		# Show list of all copied files
		ls -R $DUMPFOLDER > $DUMPFOLDER/files.txt
		echo "Listing all files:"
		cat $DUMPFOLDER/files.txt
		rm $DUMPFOLDER/files.txt
	fi
else
	echo "ERROR: Cannot open $MIBPATH"
fi

if [ "$TOPIC" != "Password" ]; then
	echo
	echo "Script execution has finished."
	exit 0
fi
