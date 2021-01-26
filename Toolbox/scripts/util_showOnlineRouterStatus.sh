#!/bin/sh

if [[ -e /var/dataoverdlink ]]; then
	echo "Online data are routed over D-Link"
else
	echo "Online data are routed over SIM/Bluetooth"
fi
