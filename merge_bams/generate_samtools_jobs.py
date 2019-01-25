import re
import os
import sys

#directory = "../keep/by_id/su92l-4zz18-075pax5icw6vpk6"
directory = sys.argv[1]
split_re = r'_|\.'

samples = {}

for subdir, dirs, files in os.walk(directory):
    for f in files:
        info_split = re.split(split_re, f)
        if info_split[-1] != "bam" or "chrM" in f:
            continue
        if info_split[0] in samples:
            samples[info_split[0]].append(os.path.join(subdir, f))
        else:
            samples[info_split[0]] = [os.path.join(subdir, f)]

os.makedirs("jobs")
for sample in samples:
    with open("./jobs/" + sample + ".txt", 'w') as f:
        f.write("\n".join(samples[sample]))
        f.write('\n')
