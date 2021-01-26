#!/bin/sh

mount -uw /net/rcc/mnt/efs-persist
touch /net/rcc/mnt/efs-persist/SWDL/skipMostPopup.txt
exit 0

