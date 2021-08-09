#!/bin/sh

mount -uw /net/rcc/mnt/efs-persist
echo "Creating: /net/rcc/mnt/efs-persist/SWDL/skipMostPopup.txt"
touch /net/rcc/mnt/efs-persist/SWDL/skipMostPopup.txt
echo "Done."
exit 0

