####################################################################
#
# Custom Green Engineering Menu screen
# Author:       Jille
# Version:      2.1B
# Disclaimer:   THIS SCREEN WILL VOID YOUR WARRANTY
#
####################################################################
screen   MQBCoding Main

keyValue
    value    String sys 0x00000000 0
    label    "MQB CODING - MIB Toolbox v2.1B"
    poll     0
    
keyValue
    value    String sys 0x00000000 0
    label    ""
    poll     0

keyValue
    value    String sys 0x00000000 0
    label    "Warning: this screen has the potential to break your unit and void your warranty. Be careful."
    poll     0
    
keyValue
    value    String sys 0x00000000 0
    label    "IMPORTANT: Run this script first to install additional scripts:"
    poll     0    
    
script
   value    sys 1 0x0100 "/scripts/copy_phone_customer.sh"
   label    "Get new scripts and files from SD-card (slot1) "
    

####################################################################
screen  Dump MQBCoding

keyValue
    value    String sys 0x00000000 0
    label    "Make sure there is an SD-card in slot 1"
    poll     0    
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/dump_all.sh"
   label    "Dump skins, startup screens, android auto config, ringtones to SD-card"

####################################################################
screen  Customization MQBCoding 
####################################################################
screen  Skin Customization 

keyValue
    value    String sys 0x00000000 0
    label    "This screen can be used to replace skin-graphics of the MIB."
    poll     0  

keyValue
    value    String sys 0x00000000 0
    label    "Skin images.mcf-files and ambienceColorMap.res go into the Skinfiles folder on SD-card in slot 1"
    poll     0  

keyValue
    value    String sys 0x00000000 0
    label    "Reboot after installing a new skin or ambienceColorMap."
    poll     0      
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/install_skin0.sh"
   label    "Install new graphics for Skin0 from /Skinfiles/Skin0/ on SD"

script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/install_skin1.sh"
   label    "Install new graphics for Skin1 from /Skinfiles/Skin1/ on SD"
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/install_skin1_ambient.sh"
   label    "Install new ambient colors for Skin1 from /Skinfiles/Skin1/ on SD"

script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/install_skin2.sh"
   label    "Install new graphics for Skin2 from /Skinfiles/Skin2/ on SD"
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/install_skin2_ambient.sh"
   label    "Install new ambient colors for Skin2 from /Skinfiles/Skin2/ on SD"

script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/install_skin3.sh"
   label    "Install new graphics for Skin3 from /Skinfiles/Skin3/ on SD"
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/install_skin3_ambient.sh"
   label    "Install new ambient colors for Skin3 from /Skinfiles/Skin3/ on SD"

script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/install_skin4.sh"
   label    "Install new graphics for Skin4 from /Skinfiles/Skin4/ on SD"
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/install_skin4_ambient.sh"
   label    "Install new ambient colors for Skin4 from /Skinfiles/Skin4/ on SD"

script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/install_skin5.sh"
   label    "Install new graphics for Skin5 from /Skinfiles/Skin5/ on SD"   

script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/install_skin5_ambient.sh"
   label    "Install new ambient colors for Skin5 from /Skinfiles/Skin5/ on SD"
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/recovery_skins.sh"
   label    "Recovery script to recover all skins and ambienceColorMaps from backup"   
   
script
	value sys 1 0x0100 "/scripts/performePersReset.sh"
	label "Reboot"

####################################################################
screen  AndroidAuto Customization

keyValue
    value    String sys 0x00000000 0
    label    "This script will patch your gal.json file to allow third party apps."
    poll     0    

keyValue
    value    String sys 0x00000000 0
    label    "Make sure you have an SD-card in slot 1 or 2 to allow a backup to be made."
    poll     0    

script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/patch_gal.sh"
   label    "Install Android Auto custom applications patch."
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/recovery_aapatch.sh"
   label    "Recovery script for Android Auto patch (use in case of troubles after installing AA-patch" 

####################################################################
screen  Startup Customization 

keyValue
    value    String sys 0x00000000 0
    label    "This screen can be used to replace startup-graphics of the MIB."
    poll     0  

keyValue
    value    String sys 0x00000000 0
    label    "Startup-screen canim-files go into the Splashscreen folder on SD-card in slot 1"
    poll     0    

keyValue
    value    String sys 0x00000000 0
    label    "Use the filenames of the dump as a guideline. If you don't use the right filename, it will fail."
    poll     0    
    
keyValue
    value    String sys 0x00000000 0
    label    "After installing a new startup screen, change coding of module 5F, byte 18."
    poll     0
    
keyValue
    value    String sys 0x00000000 0
    label    "Set the value to a different screening, reboot, and set it back to the original value."
    poll     0    
    
keyValue
    value    String sys 0x00000000 0
    label    "This will force the system to re-read the startup-screen files."
    poll     0   
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/install_canim.sh"
   label    "Install startup screens (also makes a backup)"
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/recovery_canim.sh"
   label    "Recover the backup of the original startup screens"  

keyValue
    value    String sys 0x00000000 0
    label    ""
    poll     0  

keyValue
    value    String sys 0x00000000 0
    label    "Use the following if you don't have the tools to change coding"
    poll     0  
    
keyValue
    value    String sys 0x00000000 0
    label    "Put your custom splash.canim in the Splashscreen folder on SD-card"
    poll     0  

script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/install_forcedcanim.sh"
   label    "Force replacing of start menu. No coding needed."  

script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/recover_forcedcanim.sh"
   label    "Recover the forced splashscreen install if something failed."  

####################################################################   
screen  Sounds Customization 

keyValue
    value    String sys 0x00000000 0
    label    "This screen can be used to replace ringtones and sounds of the MIB."
    poll     0  

keyValue
    value    String sys 0x00000000 0
    label    "Wav-files go into the Ringtones-folder on SD-card in slot 1"
    poll     0  

keyValue
    value    String sys 0x00000000 0
    label    "Reboot after installing new files."
    poll     0      

script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/install_ringtones.sh"
   label    "Install new ringtones from /Ringtones/ on SD"
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/install_systemsounds.sh"
   label    "Install new system sounds from /Systemsounds/ on SD"

####################################################################

screen  Various Customization 

keyValue
    value    String sys 0x00000000 0
    label    "Various tweaks:"
    poll     0  
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/patch_googleearth.sh"
   label    "Activate 3D terrain/buildings in Carnet Google Earth"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/recovery_googleearth.sh"
   label    "Recover backupped Carnet Google Earth configuration"
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/patch_menumode.sh"
   label    "Activate User-switchable MenuMode"
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/recovery_menumode.sh"
   label    "Deactivate User-switchable MenuMode"
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/install_rsdb.sh"
   label    "Install new Radio Station DB"

####################################################################   
screen   GreenMenu Customization

keyValue
    value    String sys 0x00000000 0
    label    "Instructions: Put new .esd files into the GreenMenu folder on your SD-card."
    poll     0    

keyValue
    value    String sys 0x00000000 0
    label    "If you added any new scripts in your custom green menu screen,"
    poll     0    

keyValue
    value    String sys 0x00000000 0
    label    "make sure you install them with the Get new scripts and files function."
    poll     0   

keyValue
    value    String sys 0x00000000 0
    label    "In your ESD-files, point to scripts at /eso/bin/PhoneCustomer/default/"
    poll     0   
       
keyValue
    value    String sys 0x00000000 0
    label    ""
    poll     0   
        
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/install_esd.sh"
   label    "Install green-menu screen files"   

####################################################################
screen  Pro MQBCoding

keyValue
    value    String sys 0x00000000 0
    label    "This screen is for professionals only. It can seriously damage your MIB-unit."
    poll     0   

keyValue
    value    String sys 0x00000000 0
    label    "MQB-coding does not condone illegal use of any of these features."
    poll     0   

keyValue
    value    String sys 0x00000000 0
    label    "The PRO-features are merely meant for investigation of and improvements to the unit."
    poll     0   

####################################################################
screen  export Pro


keyValue
    value    String sys 0x00000000 0
    label    "Make sure there is an SD-card in slot 1"
    poll     0    
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/dump_fec.sh"
   label    "Dump FEC container"   
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/dump_ifs.sh"
   label    "Dump IFS-root"   
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/dump_shadow.sh"
   label    "Dump shadow file"

script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/dump_eeprom.sh"
   label    "Dump EEPROM"
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/dump_hosts.sh"
   label    "Dump hosts file"
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/dump_gem.sh"
   label    "Dump GEM.jar"
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/dump_lsdjxe.sh"
   label    "Dump LSD.jxe"
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/dump_storage.sh"
   label    "Dump storage1.raw and storage2.raw "
   

        
####################################################################
screen  import Pro

keyValue
    value   String per 30 1966083
    label   "MU Version"

keyValue
    value   String per 30 1966084
    label   "Train Info"
    
keyValue
    value    String sys 0x00000000 0
    label    "WARNING: This screen WILL void your warranty"
    poll     0    

keyValue
    value    String sys 0x00000000 0
    label    "And it can and will seriously ruin your day if you don't know what you're doing."
    poll     0    
    
keyValue
    value    String sys 0x00000000 0
    label    "Be sure to only flash if you're sure you're flashing the right file."
    poll     0    
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/copy_fec.sh"
   label    "Import FecContainer.fec from sda0/Advanced/FEC"
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/copy_gem.sh"
   label    "Import GEM.jar from sda0/Advanced/GEM"
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/install_lsdjxe.sh"
   label    "Import LSD.jxe"
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/privacy_shadow.sh"
   label    "Import shadow file"
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/import_hosts.sh"
   label    "Import hosts file"
  
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/flash_ifs.sh"
   label    "Flash ifsroot.ifs from sda0/Advanced/IFS"
  

####################################################################
screen  coding Pro

keyValue
    value    String sys 0x00000000 0
    label    "This is a try-out screen to test coding features."
    poll     0    
    
keyValue
    value    String sys 0x00000000 0
    label    "It currently only supports changing the car graphic in the car Status screen."
    poll     0    

BIOSCtrl
       	value           int per 0 0x501848ff
       	label           "Byte 18 - startup screen"
       	entry		"not set" 0
        entry		"Hybrid/FR" 1
        entry		"GTD/SC" 2
        entry		"GTI/ST" 3
        entry		"Bluemotion/FR-line" 4
        entry		"e-Golf/XPerience" 5
        entry		"R-Line" 6
        entry		"R" 7
        entry		"Alltrack" 8
        entry		"GTE" 9
        entry		"Family" 0c
        entry		"Beats Audio" 10
        poll            1000

####################################################################  
screen  scanning Pro
  
keyValue
    value    String sys 0x00000000 0
    label    "Brute force scan for data in various persistence partitions"
    poll     0    

keyValue
    value    String sys 0x00000000 0
    label    ""
    poll     0    
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan.sh"
   label    "Continue a previously started scan session. (id and partition files on SD needed)"

keyValue
    value    String sys 0x00000000 0
    label    "Brute force scan for data in various persistence partitions"
    poll     0    
keyValue
    value    String sys 0x00000000 0
    label    "The following scripts will all start scanning a specific partition, starting at address 0"
    poll     0        

keyValue
    value    String sys 0x00000000 0
    label    "Cancel at any time by unplugging the SD-card."
    poll     0        

keyValue
    value    String sys 0x00000000 0
    label    "---------------------------------------------"
    poll     0        
   
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_0.sh"
   label    "Scan NS_REGION_CODE (0)"
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_1.sh"
   label    "Scan HARMAN internal (1)"   
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_2.sh"
   label    "Scan HARMAN internal (2)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_3.sh"
   label    "Scan HARMAN internal (3)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_4.sh"
   label    "Scan HARMAN internal (4)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_5.sh"
   label    "Scan HARMAN internal (5)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_6.sh"
   label    "Scan HARMAN internal (6)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_7.sh"
   label    "Scan HARMAN internal (7)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_8.sh"
   label    "Scan HARMAN internal (8)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_9.sh"
   label    "Scan HARMAN internal (9)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_10.sh"
   label    "Scan HARMAN internal (10)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_11.sh"
   label    "Scan HARMAN internal (11)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_12.sh"
   label    "Scan HARMAN internal (12)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_13.sh"
   label    "Scan HARMAN internal (13)"  
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_14.sh"
   label    "Scan HARMAN internal (14)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_15.sh"
   label    "Scan HARMAN internal (15)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_16.sh"
   label    "Scan HARMAN internal (16)"  
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_17.sh"
   label    "Scan HARMAN internal (17)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_18.sh"
   label    "Scan HARMAN internal (18)"  
  
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_19.sh"
   label    "Scan HARMAN internal (19)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_20.sh"
   label    "Scan HARMAN internal (20)"  
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_21.sh"
   label    "Scan HARMAN internal (21)"  
  
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_22.sh"
   label    "Scan HARMAN internal (22)"  
    
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_23.sh"
   label    "Scan HARMAN internal (23)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_24.sh"
   label    "Scan HARMAN internal (24)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_25.sh"
   label    "Scan HARMAN internal (25)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_26.sh"
   label    "Scan HARMAN internal (26)"  
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_27.sh"
   label    "Scan HARMAN internal (27)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_28.sh"
   label    "Scan HARMAN internal (28)"  
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_29.sh"
   label    "Scan HARMAN internal (29)"  

script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_30.sh"
   label    "Scan HARMAN internal (30)" 


script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_31.sh"
   label    "Scan HARMAN internal (31)" 
    

script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_32.sh"
   label    "Scan HARMAN internal (32)" 
    

script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_33.sh"
   label    "Scan HARMAN internal (33)" 
    

script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_34.sh"
   label    "Scan HARMAN internal (34)" 
    

script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_35.sh"
   label    "Scan HARMAN internal (35)" 
    

script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_36.sh"
   label    "Scan HARMAN internal (36)" 
    

script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_37.sh"
   label    "Scan HARMAN internal (37)" 
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_1501.sh"
   label    "Scan online (1501)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_1510.sh"
   label    "Scan sse (1510)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_1511.sh"
   label    "Scan ARC (1511)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_1512.sh"
   label    "Scan ARC (1512)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_1513.sh"
   label    "Scan Esoposprovider (1513)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_1514.sh"
   label    "Scan Scale DTCP (1514)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_2002.sh"
   label    "Scan mobilityhorizon (2002)"  
   
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_26411208.sh"
   label    "Scan NS_HMI_DAB (26411208)"  
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_27263191.sh"
   label    "Scan NS_HMI_CAR (27263191)"  
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_27853016.sh"
   label    "Scan NS_HMI_AUDIO (27853016)"  
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_28180695.sh"
   label    "Scan DIAG_COD (28180695)"  
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_28442848.sh"
   label    "Scan DIAG_ANP (28442848)"  
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_29425895.sh"
   label    "Scan NS_HMI_ENS (29425895)"  
       
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_29688031.sh"
   label    "Scan NS_HMI_IRC (29688031)"  
       
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_30867691.sh"
   label    "Scan speech-service (30867691)"  
       
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_29425895.sh"
   label    "Scan NS_HMI_ENS (29425895)"  
       
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_32702714.sh"
   label    "Scan NS_HMI_PWR (32702714)"  
       
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_46661922.sh"
   label    "Scan NS_HMI_TUNER_AMFM (46661922)"  
       
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_46924065.sh"
   label    "Scan IDENTIFIKATION (46924065)"  
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_52166966.sh"
   label    "Scan UP AND DOWNLOAD (52166966)"  
       
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_98190593.sh"
   label    "Scan NS_HMI_SDARS (98190593)"  
       
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_678364556.sh"
   label    "Scan ENGNS, AMI type etc. (678364556)"  
  
  script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_1209.sh"
   label    "Scan unknown NAV. (1209)"    

   
  script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/persistence_scan_29688038.sh"
   label    "Scan unknown NAV. (29688038)"   
  
#############################################

screen  privacy  MQBCoding

keyValue
    value    String sys 0x00000000 0
    label    "This screen allows you to clean specific information from your unit."
    poll     0
    
keyValue
    value    String sys 0x00000000 0
    label    "Note: there is no undelete."
    poll     0

script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/privacy_cleanhistory.sh"
   label    "Clean software version update history"    

script
   value    sys 1 0x0100 "/scripts/archiveCorefiles.sh"
   label    "Archive core dumps and logs"
   
script
   value    sys 1 0x0100 "/scripts/deleteCorefiles.sh"
   label    "Delete core dumps and logs"
   
script
   value    sys 1 0x0100 "/scripts/deleteBrowserCache.sh"
   label    "Delete browser cache"

script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/privacy_shadow.sh"
   label    "Replace shadow file with shadow.txt from the Advanced/Shadowfile/ folder on the SD-card"    
  
   
#############################################

screen  VariantInfo  Pro

keyValue
    value    String sys 0x00000000 0
    label    "This screen is meant to display and/or change variant info. "
    poll     0  
    
keyValue
    value    String sys 0x00000000 0
    label    "It can render your unit useless if you dont know what you're doing."
    poll     0  

 
keyValue
    value   String per 0x286f058c 12
    label   "Variant Info"
    
keyValue
    value   String per 0x286f058c 13
    label   "Diagnosis Variant"
 
BIOSCtrl        
    value   int per 0x286f058c 4
    label   "Variant::Type"
    entry   "High" 1
    entry   "Entry" 2   
    entry   "Standard" 3
    entry   "Premium" 4
   
 BIOSCtrl       
    value   int per 0x286f058c 9
    label   "Variant::Region"
    entry   "Europe/ROW" 1
    entry   "Europe" 2  
    entry   "NAR" 3
    entry   "ROW" 4 
    entry   "China" 5
    entry   "Japan" 6   
    entry   "Korea" 7
    entry   "Asia" 8
    entry   "Taiwan" 9
   
  BIOSCtrl      
    value   int per 0x286f058c 10
    label   "Variant::Brand"
    entry   "Volkswagen" 1
    entry   "Audi" 2    
    entry   "Skoda" 3
    entry   "Seat" 4    
    entry   "Porsche" 5
    entry   "Bentley" 6 
    entry   "Lamborghini" 7
  
choice
    value   per 0x286f058c 5
    label   "Variant::Feature Tel"

choice
    value   per 0x286f058c 6
    label   "Variant::Feature Navi"
   
choice
    value   per 0x286f058c 7
    label   "Variant::Feature DAB"
    
choice
    value   per 0x286f058c 8
    label   "Variant::Feature Sirius"
 
choice
    value   per 0x286f058c 17
    label   "Variant::Feature LTE"  

choice
    value   per 0x286f058c 18
    label   "Variant::Feature 2D Nav"   

choice
    value   per 0x286f058c 19
    label   "Variant::Feature MMI Radio"   


####################################################################
screen  password Pro

keyValue
    value    String sys 0x00000000 0
    label    "This feature will find the root passwords for MMX and RCC"
    poll     0

keyValue
    value    String sys 0x00000000 0
    label    "Update passwords.csv in the Advanced folder on your SD in slot 1"
    poll     0

keyValue
    value    String sys 0x00000000 0
    label    "with your own passwords."
    poll     0

keyValue
    value    String sys 0x00000000 0
    label    ""
    poll     0
    
script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/find_password.sh"
   label    "Find the root passwords."
         

####################################################################
screen   Disclaimer MQBCoding

keyValue
    value    String sys 0x00000000 0
    label    "Warning: these screens have the potential to break your unit and void your warranty. Be careful."
    poll     0
    
keyValue
    value    String sys 0x00000000 0
    label    "MQB Coding is not responsible for any troubles to you, your car or software."
    poll     0
    
keyValue
    value    String sys 0x00000000 0
    poll     0
    label    "MQB Coding is always looking for cool hacks and retrofits to increase the potential of the MQB platform."
keyValue
    value    String sys 0x00000000 0
    label    "It's never our intention to harm any person, car or brand."
    poll     0 
    
keyValue
    value    String sys 0x00000000 0
    label    "If you've paid for this update, you've been scammed."
    poll     0 

keyValue
    value    String sys 0x00000000 0
    label    ""
    poll     0 

keyValue
    value    String sys 0x00000000 0
    label    "Knowledge is power, but only when shared."
    poll     0 

keyValue
    value    String sys 0x00000000 0
    label    ""
    poll     0    
    
keyValue
    value    String sys 0x00000000 0
    label    "Copyright MQB-Coding 2019"
    poll     0    

####################################################################
screen  Funstuff MQBCoding    

script
   value    sys 1 0x0100 "/eso/bin/PhoneCustomer/default/fun_timemachine.sh"
   label    "Time-machine"

    
    
####################################################################
screen  FamousQuotes Funstuff
    
keyValue
    value    String sys 0x00000000 0
    label    "'We know it and we've patched it already', someone at VW"
    poll     0
    
keyValue
    value    String sys 0x00000000 0
    label    "'That's impossible', someone at VW"
    poll     0
    
keyValue
    value    String sys 0x00000000 0
    label    "'They say it's not possible, so let's do it', someone at MQB-Coding"
    poll     0             

keyValue
    value    String sys 0x00000000 0
    label    "'Sign here, and we have the right to destroy your computer', some NDA"
    poll     0    

keyValue
    value    String sys 0x00000000 0
    label    "'Let's sell some pre-production cars', someone at VW, probably"
    poll     0
    
keyValue
    value    String sys 0x00000000 0
    label    "'MANDA HUEVOS', Meich"
    poll     0  
    
####################################################################
screen  History MQBCoding

keyValue
    value    String sys 0x00000000 0
    label    "v2.1B - Added persistence scanner."
    poll     0

keyValue
    value    String sys 0x00000000 0
    label    "v2.0B - Dump/Import hosts file and minor fixes."
    poll     0

keyValue
    value    String sys 0x00000000 0
    label    "v1.9B - Added storage.raw dump and ambient color maps dump/import."
    poll     0

keyValue
    value    String sys 0x00000000 0
    label    "v1.8B - Added LSD.jxe and GEM.jar dump and import (pro features)"
    poll     0

keyValue
    value    String sys 0x00000000 0
    label    "v1.7B - Added Ringtones dump and import"
    poll     0

keyValue
    value    String sys 0x00000000 0
    label    "v1.6B - Added Privacy screen and menumode tweak"
    poll     0

keyValue
    value    String sys 0x00000000 0
    label    "v1.5B - Added Variantinfo screen"
    poll     0

keyValue
    value    String sys 0x00000000 0
    label    "v1.4B - Beta release version"
    poll     0

keyValue
    value    String sys 0x00000000 0
    label    "v1.3A - Small bugfixes, added Google Earth patch"
    poll     0

keyValue
    value    String sys 0x00000000 0
    label    "v1.2A - Added brand, version, fazit to dumps"
    poll     0

keyValue
    value    String sys 0x00000000 0
    label    "v1.1A - Improved AA patch, added forced startupscreen-replace"
    poll     0


keyValue
    value    String sys 0x00000000 0
    label    "v1.0A - Alpha test version"
    poll     0


keyValue
    value    String sys 0x00000000 0
    label    "v0.7 - Added menu for PROs"
    poll     0
    
keyValue
    value    String sys 0x00000000 0
    label    "v0.6 - Added universal GAL-patcher"
    poll     0
    
keyValue
    value    String sys 0x00000000 0
    label    "v0.5 - Splitting graphics menu into skin and startup"
    poll     0
    
keyValue
    value    String sys 0x00000000 0
    label    "v0.4 - Adding more structure to menus"
    poll     0
    
keyValue
    value    String sys 0x00000000 0
    label    "v0.3 - Testing script-import and launch"
    poll     0
    
keyValue
    value    String sys 0x00000000 0
    label    "v0.2 - Added Android Patch"
    poll     0
    
keyValue
    value    String sys 0x00000000 0
    label    "v0.1 - Initial version"
    poll     0