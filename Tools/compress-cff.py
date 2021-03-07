# ----------------------------------------------------------
# --- Quick 'n' dirty MCF file compressor
#
# File:        compress-cff.py
# Author:      sVn, Jille
# Revision:    1.2
# Purpose:     Compress MIB2 images in mcf file
# Comments:    Usage: compress-cff.py <original-file> <new-file> <imagesdir>
# Changelog:   v1:      initial version
#              v1.1:    added missing hash to image headers and after zlib data
#              v1.2:    cff support
# ----------------------------------------------------------

import os
import struct
import sys
if sys.version_info[0] < 3:
    sys.exit("You need to run this with Python 3")


if len(sys.argv) != 4:
    print("usage: compress-cff.py <original-file> <new-file> <imagesdir>")
    sys.exit(1)

dir = sys.argv[3]
if not os.path.exists(dir):
    print("folder does not exist.")
    print("usage: compress-cff.py <original-file> <new-file> <imagesdir>")
    sys.exit(1)

data = open(sys.argv[1], 'rb').read()
offset = 24
(toc_size,) = struct.unpack_from('<I', data, offset)
print('size of TOC: ' + str(toc_size))

offset = 28
(num_files,) = struct.unpack_from('<I', data, offset)
print(("number of files: %d" % num_files))

# toc1 is a table of contents containing:
# some ID (2 bytes)
# unknown (1 byte)
# file type (1 byte)
# size of this toc is tocsize * 4
offset_toc_1_start = 32
print(("toc1 start offset: %d" % offset_toc_1_start))

# idlist is a table containing:
# checksum (unknown format, 16 bytes)
# resource id (4 bytes)
# size of this list with ids and checksums is equal to number of files * 20
offset_idlist_start = offset_toc_1_start + (toc_size * 4)
print(("idlist start offset: %d" % offset_idlist_start))

# toc2 is a table containing:
# pathlength (4 bytes)
# unknown (4 bytes)
# unknown (4 bytes)
# data_size (4 bytes)
# offset (4 byte)
# path (pathlength bytes)
offset_toc2_start = offset_idlist_start + (num_files * 20)
print(("toc2 start offset: %d" % offset_toc2_start))

i = 0
offset_array = []
path_array = []
size_array = []
unknown1_array = []
unknown2_array = []

offset = offset_toc2_start

# Read through the list of files and paths.
# This is toc2:
print("number      offset  path")
# loop through the TOC to save some data
while i < num_files:
    (path_len, unknown1, unknown2, file_size, file_offset) = struct.unpack_from('<IIIII', data, offset)

    if (unknown1==8388608):
        offset = offset + 20

    else: 
        offset = offset + 24
    (file_path,) = struct.unpack_from("%ds" % path_len, data, offset)
    # file_path = "\\"+ file_path
    path_array.append(file_path)
    size_array.append(file_size)
    offset_array.append(file_offset)
    unknown1_array.append(unknown1)
    unknown2_array.append(unknown2)

    # go on to the next offset
    offset = offset + path_len

    # print ("%8d %8x %s "%(i,file_offset,file_path.decode("utf-8")))
    i = i + 1

offset_data_start = offset_array[0]
print(("data start offset: %d" % offset_data_start))

offset_original = offset_data_start
offset_new = offset_data_start

original_header = data[0:42520]

images = bytes()
struct_toc = bytes()
toc2 = bytes()

image_id = 0
# loop through all the images and pack them into the cff
for image_id in range(0, int(num_files)):
    fileoffset_original = offset_array[image_id]
    filepath_original = path_array[image_id]
    filesize_original = size_array[image_id]
    fileunknown1_original = unknown1_array[image_id]
    fileunknown2_original = unknown2_array[image_id]
    fileimage_dir = dir + filepath_original.decode("utf-8")

    if not os.path.exists(fileimage_dir):
        print("file %s does not exist." % filepath_original.decode("utf-8"))
        sys.exit(1)
    imagedata = open(fileimage_dir, 'rb').read()
    imagesize = len(imagedata)

    print("%s : %d bytes " % (fileimage_dir, imagesize))

    struct_toc: bytes = struct.pack('<IIIII', len(filepath_original), fileunknown1_original, fileunknown2_original,
                                    imagesize, offset_new)
    toc2 = toc2 + struct_toc + filepath_original

    images = images + imagedata

    offset_original = offset_original + filesize_original
    offset_new = offset_new + imagesize

f = open(sys.argv[2], 'wb')

print("Writing %d images to %s " % (num_files, sys.argv[2]))

# original header is the entire TOC1 and IDs chunk I don't know anything about yet
f.write(original_header + toc2 + images)
f.close()
