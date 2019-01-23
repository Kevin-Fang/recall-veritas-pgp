import os
import subprocess

directory = "./keep/by_id/su92l-4zz18-075pax5icw6vpk6"

if not os.path.exists('bams'):
    os.makedirs('bams')

for subdir, dirs, files in os.walk(directory):
    for f in files:
        extension = f.split('.')[-1]
        if extension == "tgz":
            print("Unzipping {}".format(os.path.join(subdir, f)))
            output_dir = os.path.join('./bams', f.split(".")[0])
            command = ["tar", "xzvf", os.path.join(subdir, f), "-C", output_dir]
            os.makedirs(output_dir)
            print(" ".join(command))
            subprocess.call(command)
