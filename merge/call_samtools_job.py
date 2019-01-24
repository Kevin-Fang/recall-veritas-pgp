import subprocess
import sys

with open(sys.argv[1]) as bam_list:
    bam_files = bam_list.read().split('\n')
    command_to_run = ["samtools", "cat", "-h", bam_files[0], "-b"]
    command_to_run.extend(bam_files)
    command_to_run.extend(["|", "samtools", "sort", "-o", bam_files[0].split('.')[0] + '.bam'])
    print(" ".join(command_to_run))
