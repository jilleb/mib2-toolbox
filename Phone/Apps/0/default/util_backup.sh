# MIB2 utility script, part of the MIB High toolbox.
# Coded by Jille
# This script will make a backup if it's not already there

echo "Making backup folders on SD-card."

if [[ -d "$BACKUPFOLDER" ]]
then
	echo "Backup already exists. Not making a backup."
else
	echo "No backup found, making backup folder"
	mkdir -p $BACKUPFOLDER
	touch $BACKUPFOLDER/DONT_TOUCH_ANYTHING_HERE
    if [[ "$TYPE" == "folder" ]]
    then
		echo "Copying folders recursively to backup folder on SD-card."
		echo "This can take some time. Please wait."
        cp -R "$MIBPATH" "$BACKUPFOLDER"
    else 
		echo "Copying file to backup folder on SD-card."
        cp "$MIBPATH" "$BACKUPFOLDER"
    fi 
    echo "Backup done. Saved at $BACKUPFOLDER"   
fi

sleep .5