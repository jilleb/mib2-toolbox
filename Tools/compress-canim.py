#----------------------------------------------------------
#--- Quick 'n' dirty CANIM file compiler
#
# File:        compress_canim_vw
# Author:      Jille
# Revision:    5
# Purpose:     Compress canim startup images files
# Comments:    Usage: compress-canim.py <original-file> <new-file> <imagesdir>
# Changelog:   v5: can handle brand specific offsets, 
#			   Python 3 compatible
#----------------------------------------------------------

import struct
import sys
import os
import zlib

try:
  from PIL import Image
except ImportError:
  sys.exit("""  You are missing the PIL module!
  install it by running: 
  pip install image""")

if len(sys.argv) != 4:
  print ('usage: compress-canim.py <original-file> <new-file> <imagesdir>')
  sys.exit(1)

  
dir = sys.argv[3]
if not os.path.exists(dir):
  print ("folder does not exist.")
  print ("usage: compress-mif.py <original-file> <new-file> <imagesdir>")
  sys.exit(1)

data_zlib = open(sys.argv[1],'rb').read()
data = zlib.decompress(data_zlib)
offset = 0

(magic,) = struct.unpack_from('<8s', data, offset)
offset = offset + 8

#shutil.copyfile (sys.argv[1], sys.argv[2])
  
(stage_width, stage_height, cmdblock_len, unk) = struct.unpack_from('<LLLL', data, offset)
offset = offset + 16

print ("stage_width: %d\nstage_height: %d\ncmdblock_len: %d\n" %(stage_width, stage_height, cmdblock_len))

(cmd_code, img_num, img_width, img_height, bytes_per_pixel, data_start) = struct.unpack_from('<LLLLLL', data, offset)

if cmd_code != 0x11: # if it doesn't find the cmd_code 0x11 at this offset, it's in a different place (Porsche, Seat)
  offset = offset + 120
  (cmd_code, img_num, img_width, img_height, bytes_per_pixel, data_start) = struct.unpack_from('<LLLLLL', data, offset)


#put the data in the dictionary
imagelist = []
num_files = 0

print ("cmd_code: %d\n" %(cmd_code))

while cmd_code == 0x11:
  print ('File img_%d.png will be saved at offset %d \t' % (img_num, cmdblock_len+data_start+32))
  imagelist.append([img_num, cmdblock_len+data_start+32 ])
  offset = offset + 0x20
  (cmd_code, img_num, img_width, img_height, bytes_per_pixel, data_start) = struct.unpack_from('<LLLLLL', data, offset)
  num_files = num_files+1
  
print ('\n%d files will be imported\n' %(num_files))
  
# open target file
target_data_zlib = open(sys.argv[1],'rb').read()
target_data = zlib.decompress(target_data_zlib)

tempfile = open('temp.anim', 'wb')
tempfile.write(target_data)


for image_id in range(0, int(num_files)):
 target_offset = imagelist[image_id][1]
 print ('Importing img_%d.png' %(image_id))
 
 # load image as rgba data
 im = Image.open(os.path.join(dir, 'img_%d.png'%image_id))
 image_bytes = im.tobytes('raw')
 tempfile.seek(target_offset)
 tempfile.write(image_bytes)

tempfile.close()

target_data_decoded = open('temp.anim', 'rb').read()
target_data_encoded = zlib.compress(target_data_decoded)

newfile = open(sys.argv[2],'wb')
newfile.write(target_data_encoded)
newfile.close()
os.remove ('temp.anim')

print ("Done writing output file. \n")

try:
    input("Press F to pay respect to Vasco \n")
except NameError:
    pass
except SyntaxError:
    pass

