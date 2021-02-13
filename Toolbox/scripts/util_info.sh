# MIB2 script, part of the MIB High toolbox.
# Coded by Jille
# This script will show unit info on screen and write this data to variables for use in other scripts.

#Firmware/unit info:
export VERSION="$(cat /net/rcc/dev/shmem/version.txt | grep "Current train" | sed 's/Current train = //g' | sed -e 's|["'\'']||g' | sed 's/\r//')"
if [ -e /tmp/fazit-id ]; then
  export FAZIT=$(cat /tmp/fazit-id);
else
  export FAZIT="unknown";
fi

echo "---------------------------"
echo FAZIT of this unit: "$FAZIT"
echo Firmware version: "$VERSION"
echo "---------------------------"
echo ""
sleep .5