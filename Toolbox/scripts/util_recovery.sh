# MIB2 utility script, part of the MIB High toolbox.
# Coded by Jille & Olli & lprot
# This script will recover backed up stuff
########################################################################################

# Include SD card mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh

# Include writeable system mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsys.sh

# Define the source path
OLDFILES=$VOLUME/Backup/$VERSION/$FAZIT/$SDPATH

# Restoring the files
echo "Source: Backup/$VERSION/$FAZIT/"
echo "        $SDPATH"
echo "Destination: $MIBPATH"

# Check if a folder or only a file needs to be recovered
if [ "$TYPE" = "folder" ]; then
	if [ -d ${OLDFILES} ]; then	
		echo "Recovering folder, please wait..."
		cp -R ${OLDFILES}/. ${MIBPATH}
	else
		echo "ERROR: No files found"
		exit 0
	fi
else 
	if [ -f ${OLDFILES} ]; then
		echo "Recovering file, please wait..."
		cp ${OLDFILES} ${MIBPATH}
	else
		echo "ERROR: No files found"
		exit 0
	fi
fi 

echo "Recovery done"
echo
sleep .5

# Include back to read-only system mount script
. /eso/hmi/engdefs/scripts/mqb/util_unmountsys.sh
