# ----------------------------------------------------------
# --- Quick 'n' dirty CFF file extractor
#
# File:        	extract-sfc.py
# Author:      	Jille
# Revision:    	1
# Purpose:     	MIB2 sfc file exporter
# Comments:    	Usage: extract-sfc.py <filename> <outdir>
# Changelog:	First version
# ----------------------------------------------------------

import struct
import sys
import os
import zlib

if sys.version_info[0] < 3:
    sys.exit("You need to run this with Python 3")

try:
    from PIL import Image
except ImportError:
    sys.exit("  You are missing the PIL module!\n"
             "  install it by running: \n"
             "  pip install image")

if len(sys.argv) != 3:
    print("usage: extract-sfc.py <filename> <outdir>")
    sys.exit(1)

out_dir = sys.argv[2]
if not os.path.exists(out_dir):
    os.mkdir(out_dir)


def mkdir_path(path):
    if not os.access(path, os.F_OK):
        os.mkdir(path)

if not os.path.exists(sys.argv[1]):
    print("%s not found" % (sys.argv[1]))
    exit(1)


data = open(sys.argv[1], 'rb').read()  # Open File with path in sys.argv[1] in mode 'r' reading and 'b' binary mode
offset = 0
counterRGBA = 0
counterL = 0
counterP = 0

offset = 16
(num_files,) = struct.unpack_from('<I', data, offset)

print("Number of files: \t %d" % (num_files))

offset = offset + 4  # offset 20

i = 0
offset_array = []
size_array = []

# go through the entire table of contents to get all paths and offsets
print("id \t   offset \t  unknown\t size")
while (i < num_files):
    (id, unknown1, start_offset, size) = struct.unpack_from('<IIII', data, offset)

    offset_array.append(start_offset)
    size_array.append(size)

    # go on to the next offset
    offset = offset + 16

    #print("%d  %10x  %10x %10s " % (i, start_offset, unknown1, size))
    i = i + 1

j = 0
print("Extracting files...")
while (j < num_files):
    offset = offset_array[j]
    size = size_array[j]

    file_data = data[offset:offset + size]
    file_header = data[offset:offset + 4]
    if file_header == b'\x89PNG':
        extension = ".png"
    else:
        extension = ".bin"

    # create path
    folder = out_dir + "\\"
    if not os.path.exists(folder):
        os.makedirs(folder)
    file = folder + "\\file_" + str(j) + extension
    print("Extracting", file)

    output_file = open(file, "wb+")

    # read data at offset

    output_file.write(file_data)
    output_file.close()
    j = j + 1

print("Done")
