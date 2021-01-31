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
import io
import hashlib
import configparser
from copy import deepcopy
from pathlib import Path
try:
    from configobj import ConfigObj
except ImportError:
    import sys
    sys.path.append(str(Path(__file__).parent))
    from configobj import ConfigObj

repo = Path(__file__).parent.resolve()
metainfo = repo / 'metainfo2.txt'
if not metainfo.exists():
    repo = repo.parent
    metainfo = repo / 'metainfo2.txt'
    print(metainfo)
if not metainfo.exists():
    raise SystemExit("Cannot find metainfo2.txt")

donor_header = b"""\
[common]
vendor = "ESO"
variant = "FMU-H-*-*-*"
variant2 = "FM2-*-*-*-*"
variant3 = "QC2-*-*-*-*"
variant4 = "FMQ-*-*-*-*"
region = "RoW"
MetafileChecksum = "37259e4758d7c843f316aaaa306cced5211049cf"

[common_Release_1]
variant = "FMU-H-*-*-*"
region = "RoW"
name = "MIB1 navigation database"
path = "./Mib1"

[common_Release_2]
variant = "FM2-*-*-*-*"
variant2 = "QC2-*-*-*-*"
variant3 = "FMQ-*-*-*-*"
region = "RoW"
name = "MIB2 navigation database"
path = "./Mib2"

[Signature]
signature1 = "11583e2be1780d5ee04eb62c71e0d2f1"
signature2 = "dab4162103aaf3a6497f8fd30e97c290"
signature3 = "ee7d5c8d35bf53c29a8bbc2474c42175"
signature4 = "ba89fea84694df7b8c3da7de41b82da6"
signature5 = "cb39043600b6de3fe728adcba7148652"
signature6 = "b6b7989079d3f2f44bcec54ef59212a2"
signature7 = "133f9224b6bcc4492e6818b1475a7d83"
signature8 = "0dde6b0489314cf4924be9e2e91db990"

"""    

def file_hash(path, checksumsize=524288, current=None):
  with open(path,'rb') as f:
    if checksumsize!=0:
      l = 0
      digests = []
      first = True
      while True:
        hasher=hashlib.sha1()
        buf = f.read(checksumsize)
        hasher.update(buf)
        if len(buf)==0:
          break
        l += len(buf)
        hash = hasher.hexdigest()
        if current and first and hash == current.strip('"'):
          raise StopIteration
        first = False
        digests.append(f'"{hash}"')
      return ( l, digests )
    else:
      hasher=hashlib.sha1()
      buf = f.read()
      hasher.update(buf)
      hash = hasher.hexdigest()
      if current and hash == current:
          raise StopIteration
      return ( len(buf), [f'"{hash}"'] )


class HashFileDef:
    def __init__(self, FileName, FileSize, shas, CheckSumSize, idx=0):
        self.FileName = FileName
        self.FileSize = int(FileSize)
        self.shas = shas
        self.CheckSum = self.shas[0]
        self.CheckSumSize = CheckSumSize
        self.idx = idx
    
    @classmethod
    def parse(self, chunk, idx):
        FileName = re.findall('FileName = "(.+?)"', chunk)[0]
        FileSize = int(re.findall('FileSize = "(.+?)"', chunk)[0])
        shas = re.findall('CheckSum\d* = "(.+?)"', chunk)
        CheckSumSize = int([*re.findall('CheckSumSize = "(.+?)"', chunk), 0][0])
        return HashFileDef(FileName, FileSize, shas, CheckSumSize, idx)

    def __eq__(self, other):
        if isinstance(other, HashFileDef):
            return self.FileName == other.FileName and self.CheckSum == other.CheckSum
        else:
            return self.FileName == other

    def __str__(self):
        chunk = f'FileName = "{self.FileName}"'
        chunk += f'\nFileSize = "{self.FileSize}"'
        if self.CheckSumSize:
            chunk += f'\nCheckSumSize = "{self.CheckSumSize}"'
        for n, sha in enumerate(self.shas):
            n = '' if n == 0 else str(n)
            chunk += f'\nCheckSum{n} = "{sha}"'
        return chunk+'\n'

    def __repr__(self):
        return self.__str__()



def generate_hashes(path, checksumsize=524288):
    finalhash = path / 'hashes.txt'

    # Generate hashes.txt
    final_dir_size = 0
    hashes_text = ''
    hashes_text_orig = finalhash.read_bytes() if finalhash.exists() else b''
    header_split = re.search(b'^FileName =', hashes_text_orig, re.MULTILINE)
    hashes_text_header = hashes_text_orig[0:header_split.start()]
    hashes_text_content = hashes_text_orig[header_split.start():]
    endings = b'\r\n' if b'\r\n' in hashes_text_content else b'\n' 
    hashes_text_content = hashes_text_content.replace(b'\r\n', b'\n').decode()
    trailing_newlines = len(hashes_text_content) - len(hashes_text_content.rstrip('\n'))
    
    hashes_text = []
    
    hashes_chunks = re.split("(?=^FileName )", hashes_text_content, flags=re.MULTILINE)
    
    n = len(hashes_chunks)
    hashes_chunks = [HashFileDef.parse(chunk, n-i) for i, chunk in enumerate(hashes_chunks[1:])]

    def hash_dir(p, stem=''):
        nonlocal hashes_chunks, hashes_text, final_dir_size, checksumsize
        for f in p.iterdir():
            if f == finalhash:
                continue
            if f.is_dir():
                hash_dir(f, stem=f'{stem}{f.name}/')
            else:
                filename = stem + f.name
                idx = 0
                current = existing = existing_css = None
                if filename in hashes_chunks:
                    index = hashes_chunks.index(filename)
                    existing = hashes_chunks[index]
                    current = existing.CheckSum
                    existing_css = existing.CheckSumSize
                    idx = existing.idx
                # current = re.findall('CheckSum = "(.+?)"', hashes_chunks.get(f.name, b''))
                try:
                    size, shas = file_hash(f, existing_css or checksumsize, current=current)
                    css = existing_css
                    if len(shas) > 1:
                        css = checksumsize
                    chunk = HashFileDef(FileName=filename, FileSize=size, shas=shas, idx=idx, CheckSumSize=css)
                    hashes_text.append(chunk)

                except StopIteration:
                    hashes_text.append(existing)
                    size = existing.FileSize

                final_dir_size += size
    
    hash_dir(path)
    hashes_text.sort(key=lambda chunk:chunk.idx, reverse=True)

    new_text = '\n'.join([str(c) for c in hashes_text])
    
    footer_len = len(new_text) - len(new_text.rstrip('\n'))
    if trailing_newlines > footer_len:
        new_text += '\n' * (trailing_newlines - footer_len)

    new_text = (new_text).encode().replace(b'\n', endings)  # ensure line endings match original
    new_text = hashes_text_header + new_text
    if new_text != hashes_text_orig:
        finalhash.write_bytes(new_text)
        print("hashes.txt: Updated details for", path)
    final_dir_size += len(new_text)  
    return finalhash, final_dir_size


def handle_common_final(config):
    changed = False
    finalscript = repo / config['common']['FinalScript'].strip('"')
    common_dir_block = str(Path(config['common']['FinalScript'].strip('"')).parent / "dir").lower().replace('/', '\\')
    if common_dir_block.startswith('.\\'):
        common_dir_block = common_dir_block[2:]
    for s in config.sections:
        if s.lower() == common_dir_block.lower():
            common_dir_block = s
            break

    finalhash, final_dir_size = generate_hashes(finalscript.parent)

    _, finalscript_hash = file_hash(finalscript)
    current = config['common']['FinalScriptChecksum']
    if finalscript_hash[0] != current:
        print("\nmetainfo2.txt: Updated FinalScriptChecksum")
    changed |= config_set_key(config, 'common', 'FinalScriptChecksum', finalscript_hash[0])

    _, curr_finalhash_hash = file_hash(finalhash)
    if common_dir_block not in config:
        print("\nMissing block:", common_dir_block)
        # config.add_section(common_dir_block)
    current = config[common_dir_block].get('CheckSum')
    if current.lower() != curr_finalhash_hash[0].lower():
        print("\nmetainfo2.txt: Updated FinalScript block details")
    changed |= config_set_key(config, common_dir_block, 'CheckSum', curr_finalhash_hash[0].upper())
    changed |= config_set_key(config, common_dir_block, 'FileSize', '"%i"' % final_dir_size)

    return common_dir_block, changed


def config_set_key(config, section, key, value):
    current = config[section][key]
    if current != value:
        config[section][key] = value
        return True
    return False


print("Loading", metainfo)
metainfo_contents = metainfo.read_bytes()
windows_line_ending = b'\r\n' in metainfo_contents
metainfo_contents = metainfo_contents.replace(b'\r\n', b'\n')  # Ensure LF line endings while building

# split metainfo into original and new parts
metainfo_splits = re.findall(b'^signature\d* = "\S+"\n?', metainfo_contents, flags=re.MULTILINE)
divide = metainfo_contents.index(metainfo_splits[-1])
divide += len(metainfo_splits[-1])
metainfo_orig = metainfo_contents[0:divide]
metainfo_new = metainfo_contents[divide+1:]

if not metainfo_new.strip():
    print("metainfo2.txt: No donor header, adding now...")
    metainfo_new = re.split(b'^\[Signature\]', metainfo_orig, flags=(re.IGNORECASE | re.MULTILINE))[0]
    metainfo_orig = donor_header


metainfo_new_header = []
lines = metainfo_new.split(b'\n')

config = ConfigObj(lines, list_values=False)

common_dir = None

#Calculate hashes for each section
for section in config.sections:
    changed = False
    title = f"metainfo2.txt: {section}"
    print(title + (" " * (max(0,70-len(title)))), end="")
    if section == "common" and 'FinalScript' in config[section]:
        common_dir_block, changed = handle_common_final(config)
        
    elif common_dir and section.lower() == common_dir:
        # already handled above
        pass

    else:
        if 'CheckSum' in config[section]:
            section_path = repo / section.strip('"')
            source = section_path.parent
            stype = section_path.name.lower()
            checksumsize = int(config[section].get('CheckSumSize', '524288').strip('"'))
            if stype == 'dir': 
                if not source.is_dir():
                    print("Inconsistent dir/file for", section)
                    continue
                hashfile, hashfile_dir_size = generate_hashes(source)
                changed |= config_set_key(config, section, 'FileSize', '"%i"' % hashfile_dir_size)
                _, shas = file_hash(hashfile, checksumsize)
                changed |= config_set_key(config, section, 'CheckSum', shas[0].upper())
            elif stype == 'file':
                if 'Source' not in config[section]:
                    print('Source missing from', section) 
                    continue
                source = source / config[section]['Source'].strip('"')
                if not source.exists():
                    print(source, 'file missing') 
                    continue
                try:
                    current = config[section][f'CheckSum']
                    filesize, shas = file_hash(source, checksumsize, current=current)
                    changed |= config_set_key(config, section, 'FileSize', '"%i"' % filesize)
                    for n, sha in enumerate(shas):
                        n = '' if n == 0 else str(n)
                        changed |= config_set_key(config, section, f'CheckSum{n}', sha.upper())
                except StopIteration:
                    pass
            elif stype == 'application' or stype == 'bootloader':
                if 'FileName' not in config[section]:
                    print('FileName missing from', section) 
                    continue
                source = source / config[section]['FileName'].strip('"')
                if not source.exists():
                    print(source, 'file missing') 
                    continue
                try:
                    current = config[section][f'CheckSum']
                    filesize, shas = file_hash(source, checksumsize, current=current)
                    changed |= config_set_key(config, section, 'FileSize', '"%i"' % filesize)
                    for n, sha in enumerate(shas):
                        n = '' if n == 0 else str(n)
                        changed |= config_set_key(config, section, f'CheckSum{n}', sha.upper())
                except StopIteration:
                    pass
            else:
                print("Don't know how to process:", section_path)
            
    if changed:
        print(": UPDATED")
    else:
        print(": -------")


lines = config.write()

metainfo_contents = '\n'.join([metainfo_orig.decode(), *lines])

if windows_line_ending:
    # metainfo needs to be CRLF to maintain original crc's
    metainfo_contents = metainfo_contents.replace('\n', '\r\n')

metainfo.write_bytes(metainfo_contents.encode())
print("Finished")
