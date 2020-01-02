#----------------------------------------------------------
#--- Quick 'n' dirty MIF file extractor
#
# File:        extract-mif.py
# Author:      Jille, sVn
# Revision:    2
# Purpose:     MIB1 mif file exporter
# Comments:    Usage: extract-mif.py <filename> <outdir>
# Credits:     Partially based on code supplied by booto @ 
# 			   https://goo.gl/GqSfpt
# 			   Format explanation by WRS @
# 			   https://goo.gl/HkhLwg
# To do:	   Use the contents in imagemapid.res to give 
#			   the files the appropriate filename and location.
#----------------------------------------------------------

import struct
import sys
import os
import zlib
from PIL import Image

if len(sys.argv) != 3:
  print ("usage: extract-mif.py <filename> <outdir>")
  sys.exit(1)

out_dir = sys.argv[2]
if not os.path.exists(out_dir):
  os.mkdir(out_dir)

data = open(sys.argv[1],'rb').read() # Open File with path in sys.argv[1] in mode 'r' reading and 'b' binary mode
offset = 0
counterRGBA = 0
counterL = 0
counterP = 0

(magic,) = struct.unpack_from('<6s', data, offset) # '<6s'  =  '<' little-endian, 's' is type char, '6s' Array of 6 chars; get first entry of the returned tuple
print "magic: " + magic
if magic != 'ESOMIF':
	print 'incorrect magic!'
	sys.exit(1)

offset = 6 #use with 'ESOMIF'

(footer_offset, ) = struct.unpack_from('<I', data, offset) # unpack '<' little-endian, 'I' unsigned-int; get first entry of the returned tuple
print ("footer  offset: %d\n"%(footer_offset))

(num_files, ) = struct.unpack_from('<I', data, footer_offset)
print ("Number of files: %d\n"%(num_files))

offset = 10

print ("offset / width / height / bytes per pixel / zlib-size ")
for image_id in range(0, int(num_files)):
	(width, height, bytes_per_pixel, zsize) = struct.unpack_from('<IIII', data, offset) # put unsigned-int,unsigned-int,unsigned-int,unsigned-int in variables width, height, bytes_per_pixel, zsize
	print ("Image %d - offset: %d / width: %d px / height: %d px / bpp: %d / zsize: %d bytes" %(image_id, offset, width, height, bytes_per_pixel, zsize))
	
	image_zlib = data[16+offset:16+offset+zsize] # 16 because of unsigned-int,unsigned-int,unsigned-int,unsigned-int from above
	
	#to ensure it's extracted in the right way, since this archive can have both 1bpp and 4bpp, sometimes even 8bpp png's inside.
	if bytes_per_pixel == 1 :
		#print ('Generating img_%d...' % (image_id))
		im = Image.frombuffer('L', (width, height), zlib.decompress(image_zlib), 'raw', 'L', 0, 1)
		counterL = counterL + 1
		
	elif bytes_per_pixel == 2 :
		#print ('Generating img_%d...' % (image_id))
		im = Image.frombuffer('LA', (width, height), zlib.decompress(image_zlib), 'raw', 'LA', 0, 1)
		counterP = counterP + 1
		
	elif bytes_per_pixel == 4 :
		#print ('Generating img_%d...' % (image_id))
		im = Image.frombuffer('RGBA', (width, height), zlib.decompress(image_zlib), 'raw', 'RGBA', 0, 1)
		counterRGBA = counterRGBA + 1
		
	else:
		print 'unknown image-mode: bytes_per_pixel = ' + bytes_per_pixel
	
	im.save(os.path.join(out_dir, 'img_%d.png'%image_id))
	#print ('Generating img_%d done' % (image_id))

	offset = 16+offset+zsize

offset = offset+4

#offset_table, for complete implementation, uncomment print below to view content
for image_id in range(0, int(num_files)):
	(index,) = struct.unpack_from('<I', data, offset) # 0-based
	(offset_entry,) = struct.unpack_from('<I', data, offset+4)
#	print 'offset_table - index: ' + str(index) + ' offset: '+ str(offset_entry)
	offset = offset + 8

#uid
(uid,) = struct.unpack_from('<i', data, offset)
print '\nmapping.txt stores this as a signed integer UID: ' + str(uid)

#meta_name
offset = offset + 4
(meta_name_len, ) = struct.unpack_from('<I', data, offset)
struct_format = '<'+ str(meta_name_len) +'s'
(meta_name, ) = struct.unpack_from(struct_format, data, offset+4)
#print 'meta_name_len: ' + str(meta_name_len)
print 'meta_name: ' + meta_name

#meta_author
offset = offset + meta_name_len + 4
(meta_author_len, ) = struct.unpack_from('<I', data, offset)
struct_format = '<'+ str(meta_author_len) +'s'
(meta_author, ) = struct.unpack_from(struct_format, data, offset+4)
#print 'meta_author_len: ' + str(meta_author_len)
print 'meta_author: ' + meta_author

	
counter = counterL+counterP+counterRGBA
rest = int(num_files) - counter
print("\nExtracting %s done\n%d of %d images were extracted" %(sys.argv[1], counter, int(num_files)))
print("%d RGBA images\n%d P-mode images\n%d L-mode images"%(counterRGBA, counterP, counterL))
if rest > 0:
	print("%d were not exported for some reason" %(rest))