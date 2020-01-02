#----------------------------------------------------------
#--- Quick 'n' dirty MIF file compressor
#
# File:        compress-mif.py
# Author:      sVn
# Revision:    1
# Purpose:     Compress Discover Pro MIB1 images in mif file
# Comments:    Usage: compress-mif.py <original-file> <new-file> <imagesdir>
# Credits:     Based on extract-mif.py by Jille   
#----------------------------------------------------------

import struct
import sys
import os
import zlib
from PIL import Image

if len(sys.argv) != 4:
  print ("usage: compress-mif.py <original-file> <new-file> <imagesdir>")
  sys.exit(1)

dir = sys.argv[3]
if not os.path.exists(dir):
  print ("folder does not exist.")
  print ("usage: compress-mif.py <original-file> <new-file> <imagesdir>")
  sys.exit(1)

data = open(sys.argv[1],'rb').read() 
# open file with path in sys.argv[1] in mode 'r' reading and 'b' binary mode
# original File is needed because of uid. the mapping.txt stores this uid.

offset = 0

(magic,) = struct.unpack_from('<6s', data, offset) # '<6s'  =  '<' little-endian, 's' is type char, '6s' Array of 6 chars; get first entry of the returned tuple
print "magic: " + magic
if magic != 'ESOMIF':
	print 'original-file incorrect magic!'
	sys.exit(1)

offset = 6 #use 6 with 'ESOMIF'

(original_footer_offset, ) = struct.unpack_from('<I', data, offset) # unpack '<' little-endian, 'I' unsigned-int; get first entry of the returned tuple
print ("original-file footer offset: %d\n"%(original_footer_offset))

(num_files, ) = struct.unpack_from('<I', data, original_footer_offset)
print ("number of files: %d\n"%(num_files))

footer_offset = 10
struct_data = ''
struct_offset_table = ''

print ("offset / width / height / bytes per pixel / zlib-size ")
for image_id in range(0, int(num_files)):
	im = Image.open(os.path.join(dir, 'img_%d.png'%image_id))
	width = im.size[0]
	height = im.size[1]
	
	if im.mode == 'L':
		bytes_per_pixel = 1
	elif im.mode == 'LA':
		bytes_per_pixel = 2
	elif im.mode == 'RGBA':
		bytes_per_pixel = 4
	else:
		print ('invalid bytes per pixel mode %s in img_%d.png' %(im.mode,image_id))
		print ('make sure to use a good image editor')
		sys.exit(1)
		
	image_bytes = im.tobytes('raw')
	image_zlib = zlib.compress(image_bytes, 6)
	zsize = len(image_zlib)
	
	print ("Image %d - offset: %d / width: %d px / height: %d px / bpp: %d / zsize: %d bytes" %(image_id, footer_offset, width, height, bytes_per_pixel, zsize))
	
	struct_data = struct_data + struct.pack('<IIII', width, height, bytes_per_pixel, zsize) + image_zlib
	struct_offset_table = struct_offset_table + struct.pack('<I', image_id) + struct.pack('<I', footer_offset)
	footer_offset = footer_offset + zsize + 16

print ("new-file footer offset: %d\n"%(footer_offset))


# get uid from original-file
original_offset = original_footer_offset+4+num_files*8
(uid,) = struct.unpack_from('<i', data, original_offset)  # unpack '<' little-endian, 'i' signed-int;
print 'original-file UID: ' + str(uid)

# get meta_name from original-file
original_offset = original_offset +4
(meta_name_len, ) = struct.unpack_from('<I', data, original_offset)
struct_format_meta_name = '<'+ str(meta_name_len) +'s'
(meta_name, ) = struct.unpack_from(struct_format_meta_name, data, original_offset+4)
print 'original-file meta_name_len: ' + str(meta_name_len) + ' meta_name: ' + meta_name

# get meta_author from original-file
original_offset = original_offset + meta_name_len + 4
(meta_author_len, ) = struct.unpack_from('<I', data, original_offset)
struct_format_meta_author = '<'+ str(meta_author_len) +'s'
(meta_author, ) = struct.unpack_from(struct_format_meta_author, data, original_offset+4)
print 'original-file meta_author_len: ' + str(meta_author_len) + ' meta_author: ' + meta_author

#prepare structs
struct_magic = struct.pack('<6s', 'ESOMIF')
struct_footer_offset = struct.pack('<I', footer_offset)
struct_num_files = struct.pack('<I', num_files)
struct_uid = struct.pack('<i', uid)
struct_meta_name = struct.pack('<'+ str(len(meta_name)) +'s', meta_name)
struct_meta_name_len = struct.pack('<I', len(meta_name))
struct_meta_author = struct.pack('<'+ str(len(meta_author)) +'s', meta_author)
struct_meta_author_len = struct.pack('<I', len(meta_author))

# put all structs together
struct_data = struct_magic + struct_footer_offset + struct_data + struct_num_files + struct_offset_table + struct_uid + struct_meta_name_len + struct_meta_name + struct_meta_author_len + struct_meta_author

f = open(sys.argv[2],'wb')
f.write(struct_data)
f.close()