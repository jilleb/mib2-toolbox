#!/bin/sh

# Make it writable
mount -uw /mnt/app

# Remove VNC binary from main unit
echo "Removing VNC Client binary and config"
rm -fv /navigation/opengl-render-qnx
rm -fv /navigation/config.txt

# Make readonly again
mount -ur /mnt/app

echo Done.

exit 0


