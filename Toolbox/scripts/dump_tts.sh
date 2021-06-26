#!/bin/sh

# Info
export TOPIC=Sounds/TTS-audio
export MIBPATH=/net/mmx/ifs/tts-audio/*.*
export SDPATH=$TOPIC
export TYPE="file"

echo "This script will dump TTS-audio alerts"

# Include dump script
. /eso/hmi/engdefs/scripts/mqb/util_dump.sh
