#----------------------------------------------------------
#--- Quick 'n' dirty MCF file compressor
#
# File:        compress-mcf.py
# Author:      sVn, Jille
# Revision:    1.1
# Purpose:     Compress MIB2 images in mcf file
# Comments:    Usage: compress-mcf.py <original-file> <new-file> <imagesdir>
# Changelog:   v1:      initial version
#              v1.1:    added missing hash to image headers and after zlib data    
#----------------------------------------------------------

import struct
import sys
import os
import zlib
from PIL import Image
import binascii


if len(sys.argv) != 4:
  print ("usage: compress-mcf.py <original-file> <new-file> <imagesdir>")
  sys.exit(1)

dir = sys.argv[3]
if not os.path.exists(dir):
  print ("folder does not exist.")
  print ("usage: compress-mcf.py <original-file> <new-file> <imagesdir>")
  sys.exit(1)

data = open(sys.argv[1],'rb').read()
offset = 0

(magic,) = struct.unpack_from('<4s', data, offset)
if magic != '\x89\x4d\x43\x46': # corresponds to MCF file starting
	print 'original-file incorrect magic!'
	sys.exit(1)

offset = 32
(size_of_TOC,) = struct.unpack_from('<I', data, offset) 
print 'size of TOC: ' + str(size_of_TOC)

offset = 48
(num_files,) = struct.unpack_from('<I', data, offset)
print ("number of files: %d"%(num_files))

offset_data_start = size_of_TOC + 56
print ("data start: %d"%(offset_data_start))

offset_original = offset_data_start
offset_new = offset_data_start

original_header = data[0:48]
original_toc_checksum = data[offset_data_start-4:offset_data_start]

struct_toc = ''
struct_data = ''

def find(s, ch):
    return [i for i, ltr in enumerate(s) if ltr == ch]
#num_files = 1
for image_id in range(0, int(num_files)):
	(original_type, original_file_id, original_always_8, original_zsize, original_max_pixel_count, original_always_1, original_hash1, original_width, original_height, original_image_mode, original_always__1) = struct.unpack_from('<4sIIIIIIhhhh', data, offset_original)
	(original_unknown_hash2,) = struct.unpack_from('<I', data, offset_original+original_zsize+36)
	
	im = Image.open(os.path.join(dir, 'img_%d.png'%image_id))
	image_bytes = im.tobytes('raw')
	
	zlib_level = 9
	image_zlib = zlib.compress(image_bytes, zlib_level)

	type = "IMG "
	file_id = image_id + 1
	always_8 = 8
	zsize = len(image_zlib)
	always_1 = 1    
	width = im.size[0]
	height = im.size[1]
	
	if im.mode == 'L':
		image_mode = 4096
	elif im.mode == 'RGBA':
		image_mode = 4356
	else:
		print ('invalid image mode %s in img_%d.png' %(im.mode,image_id))
		print ('make sure to use a good image editor')
		sys.exit(1)
	always__1 = 1
	
	if (image_mode == 4356):
		max_pixel_count = width * height * 4
	elif (image_mode == 4096):
		max_pixel_count = width * height
	
	# fill up bytes to make it divideable by 4
	mod = zsize % 4
	if mod == 3:
		zsize += 1
		image_zlib = image_zlib + chr(0)
	elif mod == 2:
		zsize += 2
		image_zlib = image_zlib + chr(0) + chr(0)
	elif mod == 1:
		zsize += 3
		image_zlib = image_zlib + chr(0) + chr(0) + chr(0) 


	header_part1 = struct.pack('<4sIIIII',type, file_id , always_8 , zsize,  max_pixel_count, always_1)
	hash_1 = (zlib.crc32(header_part1))
	hash_2 = (zlib.crc32(struct.pack('<hhhh',width,height,image_mode, always__1) + image_zlib))

	print ("%s;%d;%d;%d;%d;%d;%d;%d;%d;%d;%d;%d"%(type, file_id, always_8, zsize, max_pixel_count, always_1, hash_1, width, height, image_mode, always__1, hash_2))
  
    
	struct_data = struct_data + struct.pack('<4sIIIIIihhhh', type, file_id, always_8, zsize, max_pixel_count, always_1, hash_1, width, height, image_mode, always__1) + image_zlib + struct.pack('<i', hash_2)
	struct_toc = struct_toc + struct.pack('<4sIII', type, file_id, offset_new, zsize+40) # file_size = meta information (size of 40) + zsize
	
	offset_original = offset_original+original_zsize+40
	offset_new = offset_new+zsize+40

f = open(sys.argv[2],'wb')
toc = struct.pack('<I',num_files) + struct_toc
toc_checksum = struct.pack('<i',(zlib.crc32(toc)))
f.write(original_header + toc + toc_checksum + struct_data)
f.close()