# MIB2 High toolbox
The ultimate MIB2-HIGH toolbox for all your MIB2 High customization needs.

Note: this screen has to potential to ruin your MIB2 HIGH unit. The developers are not responsible for any troubles to anyone or anything caused by this toolbox.
It's never our intention to harm any person, car or brand. Use the tools wisely, don't be a douche.

Note: This is **not** a universal Jailbreak-like solution for all your needs and firmware versions.

# Requirements
- Read the entire readme
- At least 1 healthy set of brains
- An MIB2 HIGH infotainment unit. It will **not** work on MIB1 or MIB2 Standard units. Discover Media / Compostion Media is not MIB2 HIGH!
- 1 empty, **FAT32 formatted** SD-card, with enough space. Everything bigger than 1GB is fine
- Some place to save your backups
- Developer mode enabled on module 5F (you need VCDS/OBD11/VCP for this!)

## Optional requirements ##
- Python 2.7, if you want to extract/compress graphics containers (canim/mcf)
- Notepad, if you want to make your own green menu files or scripts
- Picture editing software, if you want to customize graphics files

# How to install
- Put all files and folders on an empty SD-card, preferable >1GB.
- Put the SD-card in one of the slots of your MIB2-unit. 
- Make sure there's only 1 SD-card in your unit, otherwise the scripts don't know where to look.
- Hold the MENU button on your MIB2 and start the software update menu.
- Select the SD-card and select MQB Coding MIB2 Toolbox.
- Let the unit run the entire software update. It will reboot several times
- When it's done, it will ask you to connect a computer and clear the error codes. This is not needed.
- The unit will restart one final time and you're back at the main car menu. Installation is now done.
- Hold the MENU button, and go to TESTMODE. On older versions you can go to the developer menu by holding the MENU button for about 10 seconds.
- Go to the Green Developer Menu
- There will be an additional menu called "mqbcoding". When you see this, the installation was succesful.
- Go to mqbcoding, and you will see the following:

![The MQB Coding toolbox menu](https://i.imgur.com/yJ0ZvKb.png)

- Run the "Get new scripts and files from SD-card (slot1)" script, and additional files will be installed.
- You're now done.
- Enjoy!

# How to use the new screens

## dump
This screen lets you dump skin-files(images.mcf files), Android Auto configuration files (gal.json) and Startup screens (.canim files). Make sure an SD-card with enough space is inserted in one of the slots. Dumps will be placed in a folder specific for your unit (FAZIT) and firmware version.

## androidauto
This screen has 2 buttons:
- Patch Android Auto to enable custom third party apps. No root is needed on your phone.
- Recover the original gal.json file in case you didn't like the patch or something is not working right.

## graphics
This screen lets you install new images.mcf for each of the 6 skin-folders, from the SkinFiles folder on your SD-card. Use the dump files as a guideline. Don't install any files that are meant for other firmwares because it **will** mess up your graphics and functionalities of your infotainment unit.
This screen will also let you recover the skins from backup, and make you have 3D buildings/terrain in Google Earth (CarNet service). It will **not** enable Google Earth for you.
![3D google maps](https://i.imgur.com/Jv5Tftm.png)

## greenmenu
This screen will let you import new .esd files from the GreenMenu folder on your SD-card.

## pro
This is the pro section that can seriously brick your unit. It allows you to dump some advanced files, as well as flash/replace others. The coding-feature isn't really functional yet but it has the potential to replace OBD11/VCDS ;)

# How to use the tools
In the Tools folder you will find a couple of tools:
- extract-canim_seat.py
- extract-canim_vw.py

These are Python-scripts to extract startup screen files (.canim files) in 2 formats. If one of the scripts doesn't extract your canim, try the other one. Both work in the same way: extract_canim.py <filename> <outdir>, for instance: 

```extract_canim.py test.canim .\testfiles\```

- extract-mcf.py
 
This a python script to extract skinfile containers (mcf) and it works similar to the canim-extract: extract_mcf.py <filename> <outdir>, for instance:
 
 ```extract_mcf.py images.mcf .\extracted\```
 
 
- compress-canim_seat.py
- compress-canim_vw.py

These are the scripts to compress the startup-screens. Make sure you use the same compress-method you used when extracting. Usage: compress-canim.py <original-file> <new-file> <imagesdir>, for instance:

```compress-canim.py test.canim modified.canim .\testfiles\```

- compress-mcf.py
This is the script to compress the MCF-container. Usage: compress-mif.py <original-file> <new-file> <imagesdir>, for instance:
  
```compress-mcf.py images.mcf images2.mcf .\extracted\```


## F.A.Q.

If you run into any issues, consult the [F.A.Q.](https://github.com/jilleb/mib2-toolbox/blob/master/FAQ.md).

## Supported firmware versions
This toolbox probably doesn't work on all available firmware versions.


| Brand         | Version       | Works?|
| ------------- |:-------------:| -----:|
| VW | 0343 | Yes |
| VW | 1367 | Yes |
| Seat | 1219 | Yes |
| Seat | 1409 | Yes |
| Skoda | 1240 | [Metainfo error](https://github.com/jilleb/mib2-toolbox/issues/4) |
| Skoda | 1382 | Yes |
| Skoda | 1440 | Yes |
| Audi | 1362 | No, reason currently unkown |


Please report whether or not the toolkit works with your version, so I can add new info to this page.


# Disclaimer:
**Warning** These screens have the potential to break your unit and void your warranty. Be careful. We are not responsible for any troubles to you, your car or software. MQB Coding is always looking for cool hacks and retrofits to increase the potential of the MQB platform. It's never our intention to harm any person, car or brand.



