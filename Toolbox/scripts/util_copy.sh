# MIB2 utility script, part of the MIB High toolbox.
# Coded by Jille & Olli
# This script will make a backup if it's not already there
########################################################################################

# Include writeable system mount script
. /eso/hmi/engdefs/scripts/mqb/util_mountsys.sh

# Define the source path
NEWFILES=$VOLUME/Custom/$SDPATH

# Copying the files
echo "Copying $TYPE"
echo "Source:" $NEWFILES
echo "Destination:" $MIBPATH

# Check if a folder or only a file needs to be copied
if [ "$TYPE" = "folder" ]; then
	if [ -d ${NEWFILES} ]; then	
		echo "Copying folder, please wait..."
		cp -R ${NEWFILES}/. ${MIBPATH}
	else
		echo "ERROR: No files found"
		exit 0
	fi
else 
	if [ -f ${NEWFILES} ]; then
		echo "Copying file, please wait..."
		cp ${NEWFILES} ${MIBPATH}
	else
		echo "ERROR: No files found"
		exit 0
	fi
fi 

echo "Copy done"
echo
sleep .5

# Include back to read-only system mount script
. /eso/hmi/engdefs/scripts/mqb/util_unmountsys.sh
