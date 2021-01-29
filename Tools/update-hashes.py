#----------------------------------------------------------
#--- Update the hashes in the repo
#
# File:        update-hashes.py
# Author:      andrewleech
# Revision:    1
# Purpose:     Update all sha1 hashes and hash files
# Comments:    Usage: python update-hashes.py
#----------------------------------------------------------

import os
import re
import hashlib
from pathlib import Path

repo = Path(__file__).parent.parent


def file_hash(path):
    blocksize = 256 * 1024
    sha1 = hashlib.sha1()
    with open(path, 'rb') as hdl:
        while True:
            data = hdl.read(blocksize)
            if not data:
                break
            sha1.update(data)
    return sha1.hexdigest()


# Hashed Files
metainfo = repo / 'metainfo2.txt'
mqb-main_esd = repo / 'Toolbox' / 'GEM' / 'mqb-main.esd'
finalscript = repo / 'Toolbox' / 'final' / 'finalScript.sh'
finalhash = repo / 'Toolbox' / 'final' / 'hashes.txt'

# Generate final hashes.txt
final_dir_size = 0
hashes_text = ''
hashes_text_orig = finalhash.read_bytes()
for f in finalscript.parent.iterdir():
    if f == finalhash:
        continue
    sha = file_hash(f)
    size = os.path.getsize(f) 
    hashes_text += f'FileName = "{f.name}"\n'
    hashes_text += f'FileSize = "{size}"\n'
    hashes_text += f'CheckSum = "{sha}"\n\n'
    final_dir_size += size

hashes_text = hashes_text.encode()  # ensure line endings aren't changed
if hashes_text != hashes_text_orig:
    finalhash.write_bytes(hashes_text)
    print("hashes.txt: Updated details for final script dir")
final_dir_size += len(hashes_text)

# Update metainfo
metainfo_contents = metainfo.read_bytes().replace(b'\r\n', b'\n')  # Ensure LF line endings
metainfo_contents_prev = metainfo_contents

mqb-main_esd_hash = file_hash(mqb-main_esd)
mqb-main_esd_size = os.path.getsize(mqb-main_esd) 

metainfo_contents = re.sub(
    b'(\[MQB.*File\](\n.*?)+CheckSum = )("\S+?")',
    f'\\1"{mqb-main_esd_hash}"'.encode(),
    metainfo_contents, re.MULTILINE
)
metainfo_contents = re.sub(
    b'(\[MQB.*File\](\n.*?)+FileSize = )("\S+?")',
    f'\\1"{mqb-main_esd_size}"'.encode(),
    metainfo_contents, re.MULTILINE
)
if metainfo_contents_prev != metainfo_contents:
    print("metainfo2.txt: Updated Checksum / FileSize for mqb-main.esd")
    metainfo_contents_prev = metainfo_contents


finalscript_hash = file_hash(finalscript)
metainfo_contents = re.sub(
    b'(FinalScriptChecksum = )("\S+?")',
    f'\\1"{finalscript_hash}"'.encode(),
    metainfo_contents, re.MULTILINE
)
if metainfo_contents_prev != metainfo_contents:
    print("metainfo2.txt: Updated FinalScriptChecksum")
    metainfo_contents_prev = metainfo_contents

curr_finalhash_hash = file_hash(finalhash)
metainfo_contents = re.sub(
    b'(\[Toolbox.*Dir\](\n.*?)+CheckSum = )("\S+?")',
    f'\\1"{curr_finalhash_hash}"'.encode(),
    metainfo_contents, re.MULTILINE
)
metainfo_contents = re.sub(
    b'(\[Toolbox.*Dir\](\n.*?)+FileSize = )("\S+?")',
    f'\\1"{final_dir_size}"'.encode(),
    metainfo_contents, re.MULTILINE
)
if metainfo_contents_prev != metainfo_contents:
    print("metainfo2.txt: Updated FinalScript block details")
    metainfo_contents_prev = metainfo_contents

# metainfo needs to be CRLF to maintain original crc's
metainfo_contents = metainfo_contents.replace(b'\n', b'\r\n')

metainfo.write_bytes(metainfo_contents)
print("Finished")
