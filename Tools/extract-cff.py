# ----------------------------------------------------------
# --- Quick 'n' dirty CFF file extractor
#
# File:        	extract-cff.py
# Author:      	Jille
# Revision:    	1
# Purpose:     	MIB2 cff file exporter
# Comments:    	Usage: extract-cff.py <filename> <outdir>
# Changelog:	Updated for Python 3 compatibility.
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
    print("usage: extract-cff.py <filename> <outdir>")
    sys.exit(1)

out_dir = sys.argv[2]
if not os.path.exists(out_dir):
    os.mkdir(out_dir)


def mkdir_path(path):
    if not os.access(path, os.F_OK):
        os.mkdir(path)


data = open(sys.argv[1], 'rb').read()  # Open File with path in sys.argv[1] in mode 'r' reading and 'b' binary mode
offset = 0
counterRGBA = 0
counterL = 0
counterP = 0

offset = 24
(toc_size,) = struct.unpack_from('<I', data,
                                 offset)  # unpack '<' little-endian, 'I' unsigned-int; get first entry of the returned tuple

offset = 28
(num_files,) = struct.unpack_from('<I', data, offset)
print("Num of files: \t %d" % (num_files))

offset = offset + 4 + (toc_size * 4)
offset = offset + (num_files * 20)

i = 0
offset_array = []
path_array = []
size_array = []

# id_array will be a list of offsets
# path_array will be a list of paths

# go through the entire table of contents to get all paths and offsets
while (i < num_files):
    (path_len, unknown1, unknown2) = struct.unpack_from('<III', data, offset)

    if (unknown1 == 8388608):
        offset = offset + 12
    else:
        offset = offset + 16

    (file_size,) = struct.unpack_from('<I', data, offset)

    offset = offset + 4
    (file_offset,) = struct.unpack_from('<I', data, offset)

    offset = offset + 4
    (file_path,) = struct.unpack_from("%ds" % path_len, data, offset)
    # file_path = "\\"+ file_path
    offset_array.append(file_offset)
    path_array.append(file_path)
    size_array.append(file_size)

    # go on to the next offset
    offset = offset + path_len

    # print ("%d - %x - %s "%(i,file_offset,file_path))
    i = i + 1

j = 0
print("Extracting files...")
while (j < num_files):
    offset = offset_array[j]
    path = path_array[j]
    size = size_array[j]

    # create path
    folder, file = os.path.split(path)
    folder = out_dir + "\\" + folder.decode("utf-8")
    if not os.path.exists(folder):
        os.makedirs(folder)
    file = folder + "\\" + file.decode("utf-8")
    print("Extracting", file)

    output_file = open(file, "wb+")

    # read data at offset
    file_data = data[offset:offset + size]
    output_file.write(file_data)
    output_file.close()
    j = j + 1

print("Done")
