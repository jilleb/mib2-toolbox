#!/bin/sh

# Info
export TOPIC=Bundles
export SDPATH=$TOPIC
export TYPE="file"

echo "This script will dump all files in /eso/bundles/"

# Check each expanded path separately, just like the Storage dump.
FOUND=0
STATUS=0
for MIBPATH in /eso/bundles/*.jar; do
	[ -f "$MIBPATH" ] || continue
	FOUND=1
	export MIBPATH
	# util_dump.sh exits when finished, so isolate each invocation.
	( . /eso/hmi/engdefs/scripts/mqb/util_dump.sh ) || STATUS=1
done

if [ "$FOUND" -eq 0 ]; then
	echo "ERROR: No JAR files found in /eso/bundles"
	exit 1
fi

exit "$STATUS"
