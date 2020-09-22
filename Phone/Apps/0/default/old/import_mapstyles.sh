#!/bin/sh

DESCRIPTION="This script will replace mapstyles"
TOPIC=Mapstyles
SDPATH=/Custom/Mapstyles
MIBPATH=/net/mmx/mnt/navigation/app/resources/

/eso/bin/PhoneCustomer/default/copy_file.sh "$DESCRIPTION" "$TOPIC" "$MIBPATH" "$SDPATH" folder

echo "Done"
exit 0