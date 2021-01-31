#!/bin/ksh
# This script is meant to dump all 
# author: Jille
########################

#info
DESCRIPTION="This script will dump everything to SD-card."

echo $DESCRIPTION

. /eso/hmi/engdefs/scripts/mqb/util_info.sh
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi

#Make dump folders
DUMPPATH=$VOLUME/Dump/$VERSION/$FAZIT/

echo Making dump folders on SD-card.
mkdir -p $DUMPPATH

# Include all dump scripts
echo Dumping, please wait
sleep 1

# Graphic dump scripts
echo Dumping skin files. This could take a while
. /eso/hmi/engdefs/scripts/mqb/dump_skins.sh > /dev/null & wait $!
echo Skin files dump done
sleep 1

echo Dumping startup screens
. /eso/hmi/engdefs/scripts/mqb/dump_splashscreen.sh > /dev/null & wait $!
echo Startup screens dump done
sleep 1

echo Dumping Mapstyles
. /eso/hmi/engdefs/scripts/mqb/dump_mapstyles.sh > /dev/null & wait $!
echo Mapstyles dump done
sleep 1

# Sound dump scripts
echo Dumping system sounds
. /eso/hmi/engdefs/scripts/mqb/dump_systemSounds.sh > /dev/null & wait $!
echo System sounds dump done
sleep 1

echo Dumping telephone ringtones 
. /eso/hmi/engdefs/scripts/mqb/dump_ringtones.sh > /dev/null & wait $!
echo Telephone ringtones dump done
sleep 1

echo Dumping TTS-audio alerts
. /eso/hmi/engdefs/scripts/mqb/dump_tts.sh > /dev/null & wait $!
echo TTS-audio alerts dump done
sleep 1

# Database dump scripts
echo Dumping Radio Station DB. This could take a while
. /eso/hmi/engdefs/scripts/mqb/dump_radiostation.sh > /dev/null & wait $!
echo Radio Station DB dump done	
sleep 1

echo Dumping Gracenote DB. This will take a while, please be patient. 
. /eso/hmi/engdefs/scripts/mqb/dump_gracenote.sh > /dev/null & wait $!
echo Gracenote DB dump done	
sleep 1

# System dump scripts
echo Dumping Android Auto config file
. /eso/hmi/engdefs/scripts/mqb/dump_androidAuto.sh > /dev/null & wait $!
echo Android Auto config file dump done
sleep 1

echo Dumping storage1.raw and storage2.raw. This could take a while
. /eso/hmi/engdefs/scripts/mqb/dump_storage.sh > /dev/null & wait $!
echo Storage dump done
sleep 1

echo Dumping EEPROM. This could take a while
. /eso/hmi/engdefs/scripts/mqb/dump_eeprom.sh > /dev/null & wait $!
echo EEPROM dump done	
sleep 1

echo Dumping FEC folder. This could take a while
. /eso/hmi/engdefs/scripts/mqb/dump_fec.sh > /dev/null & wait $!
echo FEC folder dump done	
sleep 1

echo Dumping hosts file
. /eso/hmi/engdefs/scripts/mqb/dump_hosts.sh > /dev/null & wait $!
echo Hosts file dump done	
sleep 1

echo Dumping ifs-root. This could take a while
. /eso/hmi/engdefs/scripts/mqb/dump_ifs.sh > /dev/null & wait $!
echo Ifs-root dump done	
sleep 1

echo Dumping shadow file
. /eso/hmi/engdefs/scripts/mqb/dump_shadow.sh > /dev/null & wait $!
echo Shadow file dump done
sleep 1

echo Dumping persistence database. This could take a while
. /eso/hmi/engdefs/scripts/mqb/dump_persistence.sh > /dev/null & wait $!
echo Persistence database dump done	
sleep 1

# Development dump scripts
#echo Dumping lsd.jxe file
#. /eso/hmi/engdefs/scripts/mqb/dump_lsdjxe.sh > /dev/null & wait $!
#echo Lsd.jxe file dump done		
#sleep 1
#
#echo Dumping GEM.jar file
#. /eso/hmi/engdefs/scripts/mqb/dump_gem.sh > /dev/null & wait $!
#echo GEM.jar file dump done	
#sleep 1
#
#echo Dumping bundles folder
#. /eso/hmi/engdefs/scripts/mqb/dump_bundles.sh > /dev/null & wait $!
#echo Bundles dump done
#sleep 1
#
#echo Dumping engdefs folder
#. /eso/hmi/engdefs/scripts/mqb/dump_engdefs.sh > /dev/null & wait $!
#echo Engdefs dump done
#sleep 1

# Make readonly again
mount -ur $VOLUME

echo 
echo All dumps done. You can now start tweaking the dumped stuff!

exit 0
