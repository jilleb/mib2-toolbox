#!/bin/sh

export TOPIC="Displaymanager"
export DESCRIPTION="This script will show and dump information about the displays"

echo $DESCRIPTION
. "/eso/bin/PhoneCustomer/default/util_info.sh"
. "/eso/bin/PhoneCustomer/default/util_mountsd.sh"



export LD_LIBRARY_PATH=/eso/lib
export IPL_CONFIG_DIR=/etc/eso/production

#Make dump folder


/eso/bin/apps/dmdt sc 0 

sleep 1



exit 0