import sys
import math

name = sys.argv[1]

out = open(f"{name}.xml", "w")
out.write(f'<?xml version="1.0" encoding="utf-8"?>\n')
out.write(f'<keyboard name="{name}" script="latin">')

keys = open(f"{name}.keys").read().splitlines()
keys_amt = math.ceil(len(keys) / 5)
assert keys_amt % 2 == 0
top_row_length = keys_amt // 2 + 1
all_ = [{} for _ in range(keys_amt)]
for i, key in enumerate(keys):
    layer = i//keys_amt
    all_[i%keys_amt][f"key{layer}"] = key

def write_key(key):
    out.write(f'<key')
    for attr, value in key.items()
            out.write(f' {attr}=\"{value}\"')
    out.write(f' />')
for key in all_[:top_row_length]: # Top row
    out.write('<row>\n')
    write_key(key)
    out.write('</row>\n')
for key in all_[top_row_length:]: # Bottom row
    out.write('<row>\n')
    out.write('<key key0="shift" key2="loc capslock" />\n')
    write_key(key)
    out.write('<key key0="backspace" key1="delete" />\n')
    out.write('</row>\n')

out.write(f'</keyboard>\n')
