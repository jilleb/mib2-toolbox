#----------------------------------------------------------
#--- Quick 'n' dirty MIF file extractor
#
# File:        extract_canim_seat
# Author:      Jille
# Revision:    3
# Purpose:     Extract canim startup images files, this version works for Seat.
# Comments:    Usage: extract_canim.py <filename> <outdir>
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
  print 'usage: extract_canim.py <filename> <outdir>'
  sys.exit(1)

out_dir = sys.argv[2]
if not os.path.exists(out_dir):
  os.mkdir(out_dir)

data_zlib = open(sys.argv[1],'rb').read()
data = zlib.decompress(data_zlib)
offset = 0

(magic,) = struct.unpack_from('<8s', data, offset)
offset = offset + 8

if magic != 'ANIM1   ':
  print 'incorrect magic!'
  sys.exit(1)


(stage_width, stage_height, cmdblock_len) = struct.unpack_from('<LLL', data, offset)
offset = offset + 60
offset = offset + 76

print "stage_width: %d\nstage_height: %d\ncmdblock_len: %d\n" %(stage_width, stage_height, cmdblock_len)

(cmd_code, img_num, img_width, img_height, bytes_per_pixel, data_start) = struct.unpack_from('<LLLLLL', data, offset)
print "cmd_code: %d\n" %(cmd_code)

while cmd_code == 0x11:
  print 'generating img_%d from offset %d \t  size: %d x %d \t bpp: %d \t size: %d bytes' % (img_num, cmdblock_len+data_start+32, img_width, img_height, bytes_per_pixel, img_width*img_height*bytes_per_pixel)
  if bytes_per_pixel == 0x3:
	im = Image.frombuffer('RGB', (img_width, img_height), data[0x20+cmdblock_len+data_start:], 'raw', 'RGB', 0, 1)
  if bytes_per_pixel == 0x4:
	im = Image.frombuffer('RGBA', (img_width, img_height), data[0x20+cmdblock_len+data_start:], 'raw', 'RGBA', 0, 1)
  
  im.save(os.path.join(out_dir, 'img_%d.png'%img_num))
  offset = offset + 0x20
  (cmd_code, img_num, img_width, img_height, bytes_per_pixel, data_start) = struct.unpack_from('<LLLLLL', data, offset)