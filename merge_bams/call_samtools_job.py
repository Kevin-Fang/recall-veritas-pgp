import subprocess
import sys

with open(sys.argv[1]) as bam_list:
    bam_files = bam_list.read().split('\n')
    new_bam_filename = bam_files[0].split("/")[-1].split('.')[0] + ".bam"
    print(subprocess.check_output("ls -l /keep/b03be865128b6d0ee14bcb9b532c6816+57145", shell=True))
    command_to_run = ["samtools", "cat", "-h", bam_files[0], "-b"]
    command_to_run.extend(bam_files)
    command_to_run.extend(["|", "samtools", "sort", "-o", new_bam_filename])
    command_to_run = list(filter(lambda x: x != '', command_to_run))

    index_command = ["samtools", "index", new_bam_filename])
    print(command_to_run)
    print(" ".join(command_to_run))
    subprocess.check_output(" ".join(command_to_run), shell=True)
    subprocess.check_output(" ".join(index_command), shell=True)
