#!/bin/sh

mount -uw /net/rcc/mnt/efs-persist
echo "Removing: /net/rcc/mnt/efs-persist/SWDL/skipMostPopup.txt"
rm /net/rcc/mnt/efs-persist/SWDL/skipMostPopup.txt
echo "Done."
exit 0

