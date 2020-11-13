#!/bin/sh   
echo "Start patching"
                                                                                                     
sed -i 's/^DS_Velocity_Threshold= .*$/DS_Velocity_Threshold=c7000602ff0000000014ff00ff00ff000000ff02ff02000000073031ac3f/' /net/rcc/mnt/efs-persist/storage1.raw
sed -i 's/^DS_Velocity_Threshold= .*$/DS_Velocity_Threshold=c7000602ff0000000014ff00ff00ff000000ff02ff02000000073031ac3f/' /net/rcc/mnt/efs-persist/storage2.raw

		  
sync
sync
sync
echo "done, please reboot for activation!"
