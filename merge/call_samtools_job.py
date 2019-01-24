import subprocess
import sys

with open(sys.argv[1]) as bam_list:
    bam_files = bam_list.read().split('\n')
    new_bam_filename = bam_files[0].split('.')[0] + ".bam"
    command_to_run = ["samtools", "cat", "-h", bam_files[0], "-b"]
    command_to_run.extend(bam_files)
    command_to_run.extend(["|", "samtools", "sort", "-o", new_bam_filename])
    command_to_run.extend(["&&", "samtools", "index", new_bam_filename])
    #print(" ".join(command_to_run))
    subprocess.call(command_to_run, shell=True)
