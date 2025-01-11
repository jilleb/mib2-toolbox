# ----------------------------------------------------------
# --- Quick 'n' dirty MCF file extractor
#
# File:        extract-mcf.py
# Author:      Jille, sVn
# Revision:    4
# Purpose:     Discover Pro MIB2 mcf file exporter
# Comments:    Usage: extract-mcf.py <filename> <outdir>
# Credits:     Partially based on code supplied by booto @ 
# 			   https://goo.gl/GqSfpt
# Changelog:   v1: Initial version
#			   v2: Parsing of ImageIdMap.res added
#			   v3: Python 3 support
#			   v4: Moving and renaming skin0 files.
#			   v5: Added fallback logic for fonts
# ----------------------------------------------------------

import struct
import sys
if sys.version_info[0] < 3:
    sys.exit("You need to run this with Python 3")

import os
import zlib
from shutil import copyfile

try:
    from PIL import Image
    from PIL import ImageFont
    from PIL import ImageDraw
except ImportError:
    print("  You are missing the PIL module!\n"
          "  install it by running:\n"
          "  pip install image")
    input("\nPress Enter to exit...")
    sys.exit(1)


if len(sys.argv) != 3:
    print("usage: extract-mcf.py <filename> <outdir>")
    input("\nPress Enter to exit...")
    sys.exit(1)


out_dir = sys.argv[2]
mcf_path = sys.argv[1]
mcf_data = open(mcf_path, 'rb').read()
offset = 0
counterRGBA = 0
counterL = 0
counterLA = 0
num_mifIDs2 = 0

offset = 1  # skip the first bytes, makes comparing easier
(magic,) = struct.unpack_from('<3s', mcf_data,
                              offset)  # '<4s'  =  '<' little-endian, 's' is type char, '6s' Array of 6 chars; get first entry of the returned tuple
if magic != str('MCF').encode("UTF-8"):  # corresponds to MCF file starting
    print('This is not a correct MCF file!')
    input("\nPress Enter to exit...")
    sys.exit(1)

filepath, filename = os.path.split(mcf_path)
idmap_path = os.path.join(filepath, "imageidmap.res")
parse_idmap = "n"
if os.path.exists(idmap_path):
	print("Imageidmap found, so you can extract files to the right name/folder")
	parse_idmap = input("Parse imageidmap.res and move files to folders? (y/n): ")

print_number = input("Do you want to print the image number on each image(y/n)?: ")

# parse IDMAP to an array
if (parse_idmap == "y"):
	idmap_path
	idMapFile = open(idmap_path, "rb")
	seek = idMapFile.seek
	read = idMapFile.read

	# read header
	seek(12)
	data = read(4)
	if (data != str("Skr0").encode("UTF-8")):
		print('Error: not an imageidmap.res file')

	# read the UID
	seek(16)
	data = read(4)
	(UID,) = struct.unpack('<I', data)
	print('UID: ' + str(UID))

	# read the number of IDs
	seek(24)
	data = read(4)
	(num_mifIDs,) = struct.unpack('<I', data)
	print('Number of IDs: ' + str(num_mifIDs))

	# start of TOC
	seek(32)

	i = 0
	filename_array = []
	mifid_array = []

	while (i < num_mifIDs):
		data = read(4)
		(path_len,) = struct.unpack('<I', data)
		# the length of the path is in number of characters, but since it's utf binary data, x2
		path_len = (path_len * 2)
		# read the path, for as long as the lenght of this string
		path = read(path_len).decode('utf-16')
		filename_array.append(path.replace("/", os.sep))
		seek(4, 1)
		i = i + 1

	data = read(4)
	(num_mifIDs2,) = struct.unpack('<I', data)

	if (num_mifIDs2 != num_mifIDs):
		print('Warning, the table is probably corrupt, expected:' + num_mifIDs)

	j = 0
	print('Number of MifID2s: ' + str(num_mifIDs2))
	while (j < num_mifIDs2):
		data = read(4)
		print(idMapFile.tell())
		(mifID,) = struct.unpack_from('<I', data, 0)
		file_id = mifID - 1
		mifid_array.append(file_id)
		j = j + 1

offset = 32
(size_of_TOC,) = struct.unpack_from('<I', mcf_data, offset)
print(('size of TOC: ' + str(size_of_TOC)))

data_start = size_of_TOC + 56
print(("data start: %d" % (data_start)))

offset = 48
(num_files,) = struct.unpack_from('<L', mcf_data, offset)
print(("number of files: %d" % (num_files)))

# TOC
offset = 52
for image_id in range(0, int(num_files)):
	(file_type, file_id, file_offset, file_size) = struct.unpack_from('<4sIII', mcf_data, offset)
	offset = offset + 16

offset = data_start

for image_id in range(0, int(num_files)):
	(type, file_id, always_8, zsize, max_pixel_count, always_1, unknown_16, width, height, image_mode,
	 always__1) = struct.unpack_from('<4sIIIIIIhhhh', mcf_data, offset)
	# max_pixel_count = width * height and mulitplied by 1 on L-Mode and mulitplied by 4 on RGBA-Mode
	zlib_data_offset = offset + 36
	# offsethex = "%0.8X" % zlib_data_offset
	zlib_image = mcf_data[zlib_data_offset:zlib_data_offset + zsize]
	zlib_decompress = zlib.decompress(zlib_image)
	if image_mode == 4096:
		im = Image.frombuffer('L', (width, height), zlib_decompress, 'raw', 'L', 0, 1)
		counterL = counterL + 1
	if image_mode == 4356:
		im = Image.frombuffer('RGBA', (width, height), zlib_decompress, 'raw', 'RGBA', 0, 1)
		counterRGBA = counterRGBA + 1
	if print_number == "y":
		draw = ImageDraw.Draw(im)
		try:
			font = ImageFont.truetype("Arial", 14)
		except IOError:
			try:
				windows_fonts_folder = os.path.join(os.environ['SystemRoot'], 'Fonts')
				font_path = os.path.join(windows_fonts_folder, 'arial.ttf')
				font = ImageFont.truetype(font_path, 14)
			except IOError:
				font = ImageFont.load_default()
	draw.text((width / 2, height / 2), "%d" % image_id, 255, font=font)
	out_dir_unsorted = os.path.join(out_dir, "Unsorted")
	print("extracting %d to %s/img_%d.png" % (image_id, out_dir_unsorted, image_id))
	if not os.path.exists(out_dir_unsorted):
		os.makedirs(out_dir_unsorted)
	out_path = os.path.join(out_dir_unsorted, 'img_%d.png' % image_id)
	im.save(out_path)

	offset = offset + zsize + 40

counter = counterL + counterLA + counterRGBA
rest = int(num_files) - counter
print(("\nExtracting %s done\n%d of %d images were extracted" % (sys.argv[1], counter, num_files)))
print(("%d RGBA images\n%d LA-mode images\n%d L-mode images" % (counterRGBA, counterLA, counterL)))
if rest > 0:
	print(("%d were not exported for some reason" % (rest)))

# cycle through the idmap if needed
j = 0
if parse_idmap == "y":
	print("\nParsing imageidmap.res and moving files to the right folder")
	while j < num_mifIDs2:
		id = mifid_array[j]
		originalfilepath = os.path.join(out_dir_unsorted, 'img_%d.png' % id)
		newfilepath = new_path = os.path.join(out_dir, "Images", filename_array[j])
		pngfilepath, pngfilename = os.path.split(newfilepath)
		print("Copying img_%d.png to %s" % (id, newfilepath))
		if not os.path.exists(pngfilepath):
			os.makedirs(pngfilepath, 0o777)
		if not os.path.exists(originalfilepath):
			print("Error: %s  missing!" % (originalfilepath))
		else:
			copyfile(originalfilepath, newfilepath)
		j = j + 1
