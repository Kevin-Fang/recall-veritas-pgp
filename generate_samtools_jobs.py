import re
import os

directory = "./keep/by_id/su92l-4zz18-075pax5icw6vpk6"
split_re = r'_|\.'

samples = {}

for subdir, dirs, files in os.walk(directory):
    for f in files:
        info_split = re.split(split_re, f)
        if info_split[0] in samples:
            samples[info_split[0]].append(f)
        else:
            samples[info_split[0]] = [f]

for sample in samples:
    with open("output/" + sample + ".txt", 'w') as f:
        f.write("\n".join(samples[sample]))
        f.write('\n')
