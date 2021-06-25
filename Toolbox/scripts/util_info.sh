#!/bin/sh
# MIB2 script, part of the MIB High toolbox.
# Coded by Jille & Olli
# This script will show unit info on screen and write this data to variables for use in other scripts.
########################################################################################

<<<<<<< Updated upstream
# Firmware/unit info:
=======
>>>>>>> Stashed changes
# Firmware version
export VERSION="$(cat /net/rcc/dev/shmem/version.txt | grep "Current train" | sed 's/Current train = //g' | sed -e 's|["'\'']||g' | sed 's/\r//')"

# FAZIT
if [ -e /tmp/fazit-id ]; then
  export FAZIT=$(cat /tmp/fazit-id);
else
  export FAZIT="unknown";
fi

<<<<<<< Updated upstream
# Car brand
=======
# Car brand detection
>>>>>>> Stashed changes
export BRAND="$(/eso/bin/apps/pc i:0x286f058c:10 2> /dev/null)"
if [ $BRAND == "1" ]; then
	export BRAND="Volkswagen"
elif [ $BRAND == "2" ]; then
	export BRAND="Audi"
elif [ $BRAND == "3" ]; then
	export BRAND="Skoda"
elif [ $BRAND == "4" ]; then
	export BRAND="Seat"
elif [ $BRAND == "5" ]; then
	export BRAND="Porsche"
elif [ $BRAND == "6" ]; then
	export BRAND="Bentley"
elif [ $BRAND == "7" ]; then
	export BRAND="Lamborghini"
else
	export BRAND="No brand detected!"
fi

<<<<<<< Updated upstream
# Navigation country
=======
# Navigation country detection
>>>>>>> Stashed changes
export COUNTRY="$(/eso/bin/apps/pc i:0:1343753471 2> /dev/null)"
if [ $COUNTRY == "1" ]; then
	export COUNTRY="EU"
elif [ $COUNTRY == "2" ]; then
	export COUNTRY="NAR"
elif [ $COUNTRY == "3" ]; then
	export COUNTRY="MSA"
elif [ $COUNTRY == "4" ]; then
	export COUNTRY="Korea"
elif [ $COUNTRY == "5" ]; then
	export COUNTRY="China"
elif [ $COUNTRY == "6" ]; then
	export COUNTRY="Japan"
elif [ $COUNTRY == "7" ]; then
	export COUNTRY="Asia Pacific"
elif [ $COUNTRY == "8" ]; then
	export COUNTRY="Australia"
elif [ $COUNTRY == "9" ]; then
	export COUNTRY="South Africa"
elif [ $COUNTRY == "10" ]; then
	export COUNTRY="NEAST"
elif [ $COUNTRY == "11" ]; then
	export COUNTRY="NMAfrica"
elif [ $COUNTRY == "12" ]; then
	export COUNTRY="MEAST"
elif [ $COUNTRY == "13" ]; then
	export COUNTRY="Central Asia"
elif [ $COUNTRY == "14" ]; then
	export COUNTRY="India"
elif [ $COUNTRY == "15" ]; then
	export COUNTRY="Israel"
elif [ $COUNTRY == "16" ]; then
	export COUNTRY="Taiwan"
elif [ $COUNTRY == "17" ]; then
	export COUNTRY="MSA 2 (Chile)"
elif [ $COUNTRY == "18" ]; then
	export COUNTRY="China 2"
elif [ $COUNTRY == "19" ]; then
	export COUNTRY="China 3"
else
	export COUNTRY="No country detected!"
fi

<<<<<<< Updated upstream
=======
#---------------------------------------------------------------------------------
# Output
>>>>>>> Stashed changes
echo "---------------------------"
echo FAZIT of this unit: "$FAZIT"
echo Firmware version: "$VERSION"
echo Detected brand: "$BRAND"
echo Detected country: "$COUNTRY"
echo "---------------------------"
sleep .5