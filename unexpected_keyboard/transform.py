import json
import sys

name = sys.argv[1]

out = open(f"{name}.xml", "w")
out.write(f'<?xml version="1.0" encoding="utf-8"?>\n')
out.write(f'<keyboard name="{name}" script="latin">')

for row in json.load(open(f"{name}.json")):
    out.write('<row>\n')
    for key in row:
        out.write(f'<key')
        for i, variant in enumerate(key):
            out.write(f' key{i}=\"{variant}\"')
        out.write(f'/>\n')
    out.write(f'</row>\n')

out.write(f'</keyboard>\n')
