#!/bin/sh

DESCRIPTION="This script will import Gracenote files"
TOPIC=Gracenote
SDPATH=/Custom/Gracenote
MIBPATH=/net/mmx/mnt/gracenotedb/

/eso/bin/PhoneCustomer/default/copy_file.sh "$DESCRIPTION" "$TOPIC" "$MIBPATH" "$SDPATH" folder

echo "Done"
exit 0