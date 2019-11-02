#----------------------------------------------------------
#--- Quick 'n' dirty MCF file extractor
#
# File:        extract-mcf.py
# Author:      Jille, sVn
# Revision:    2
# Purpose:     Discover Pro MIB2 mcf file exporter
# Comments:    Usage: extract-mcf.py <filename> <outdir>
# Credits:     Partially based on code supplied by booto @ 
# 			   https://goo.gl/GqSfpt
# To do:	   Use the contents in imagemapid.res to give 
#			   the files the appropriate filename and location.
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

if len(sys.argv) != 3:
  print ("usage: extract-mcf.py <filename> <outdir>")
  sys.exit(1)

out_dir = sys.argv[2]
if not os.path.exists(out_dir):
  os.mkdir(out_dir)

data = open(sys.argv[1],'rb').read()
offset = 0
counterRGBA = 0
counterL = 0
counterLA = 0

(magic,) = struct.unpack_from('<4s', data, offset) # '<4s'  =  '<' little-endian, 's' is type char, '6s' Array of 6 chars; get first entry of the returned tuple
if magic != '\x89\x4d\x43\x46': # corresponds to MCF file starting
	print 'incorrect magic!'
	sys.exit(1)
	
offset = 32
(size_of_TOC,) = struct.unpack_from('<I', data, offset) 
print 'size of TOC: ' + str(size_of_TOC)

data_start = size_of_TOC + 56
print ("data start: %d"%(data_start))

offset = 48
(num_files,) = struct.unpack_from('<L', data, offset)
print ("number of files: %d"%(num_files))

#TOC
offset = 52
for image_id in range (0, int(num_files)):
	(file_type, file_id, file_offset, file_size) = struct.unpack_from('<4sIII', data, offset) # file_size = meta information (size of 40) + zsize
	print ("filetype %s file_id %d offset %d size %d"%(file_type, file_id, file_offset, file_size)) 
	offset = offset + 16



offset = data_start

for image_id in range (0, int(num_files)):
#for image_id in range (0, 2):
	(type, file_id, always_8, zsize, max_pixel_count, always_1, unknown_16, width, height, image_mode, always__1) = struct.unpack_from('<4sIIIIIIhhhh', data, offset)
	#max_pixel_count = width * height and mulitplied by 1 on L-Mode and mulitplied by 4 on RGBA-Mode

	
	zlib_data_offset = offset+36
	#offsethex = "%0.8X" % zlib_data_offset
	zlib_image = data[zlib_data_offset:zlib_data_offset+zsize]
	zlib_decompress = zlib.decompress(zlib_image)
	print ("extracting %s;%d;%d;%d;%d;%d;%d"%(type, file_id, zsize, max_pixel_count, width, height, unknown_16 ))
	try:
		if (image_mode == 4096):
			im = Image.frombuffer('L', (width, height), zlib_decompress, 'raw', 'L', 0, 1)
			counterL = counterL + 1
		if (image_mode == 4356):
			im = Image.frombuffer('RGBA', (width, height), zlib_decompress, 'raw', 'RGBA', 0, 1)
			counterRGBA = counterRGBA + 1
		im.save(os.path.join(out_dir, 'img_%d.png'%image_id))
	except:
		print ("error on %s;%d;%d;%d;%d;%d;%d;%d;%d;%d;%d"%(type, file_id, always_8, zsize, max_pixel_count, always_1, unknown_16, width, height, image_mode, always__1))

	offset = offset+zsize+40

counter = counterL+counterLA+counterRGBA
rest = int(num_files) - counter
print("\nExtracting %s done\n%d of %d images were extracted" %(sys.argv[1], counter, num_files))
print("%d RGBA images\n%d LA-mode images\n%d L-mode images"%(counterRGBA, counterLA, counterL))
if rest > 0:
	print("%d were not exported for some reason" %(rest))

