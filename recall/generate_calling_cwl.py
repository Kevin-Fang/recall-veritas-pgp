import re
import subprocess
import json
import os
import sys
import shutil

TMP_DIR = "./tmp"
CALL_JOB_NAME = "call_job"

collection = sys.argv[1]

# change ../keep to whatever directory keep is mounted at
directory = "../keep/by_id/{}".format(collection)
split_re = r'_|\.'

samples = {}

# template for bcbio_system.yaml
bcbio_system_template = """resources:
  default:
    memory: 3g
    cores: 4
    jvm_opts: ["-Xms750m", "-Xmx3500m"]
  gatk:
    jvm_opts: ["-Xms500m", "-Xmx3500m"]

arvados:
  reference: su92l-4zz18-hc9ln1agfzrgn3h
  input: [{}]
"""

# outline for bcbio job yaml
bcbio_job_outline = """details:
{jobs}fc_name: """ + CALL_JOB_NAME

# template for each individual job 
bcbio_job_template = """- algorithm:
    aligner: false
    variantcaller: gatk-haplotype
  analysis: variant2
  description: {description}
  files:
  - {filename}
  genome_build: GRCh37
"""

if os.path.exists(TMP_DIR):
    print("./tmp directory exists. Deleting...")
    shutil.rmtree(TMP_DIR)

os.makedirs(TMP_DIR)

# write system template
with open(os.path.join(TMP_DIR, "bcbio_system.yaml"), 'w') as f:
    f.write(bcbio_system_template.format(collection))

# iterate through collection and find all bam files, adding to dictionary
for subdir, dirs, files in os.walk(directory):
    for f in files:
        info_split = re.split(split_re, f)
        if info_split[-1] != "bam" or "chrM" in f:
            continue
        if info_split[0] in samples:
            samples[info_split[0]].append(os.path.join(subdir, f))
        else:
            samples[info_split[0]] = [os.path.join(subdir, f)]

# create bcbio job template file
jobs = []
for name in samples:
    for name_chr in samples[name]:
        filename = name_chr.split("/")[-1]
        description = filename[:-4]
        jobs.append(bcbio_job_template.format(description=description, filename = filename))

with open(os.path.join(TMP_DIR, CALL_JOB_NAME + '.yaml'), "w") as f:
    f.write(bcbio_job_outline.format(jobs="".join(jobs), job_name=CALL_JOB_NAME))

# generate cwl from template with bcbio
cwl_command = ["bcbio_vm.py", "cwl", "--systemconfig", os.path.join(TMP_DIR, "bcbio_system.yaml"), os.path.join(TMP_DIR, CALL_JOB_NAME + '.yaml')]
subprocess.call(cwl_command)

print("Finished making CWL with bcbio. Fixing samples..")

# add missing references to CWl samples file
with open('./{job_name}-workflow/main-call_job-samples.json'.format(job_name = CALL_JOB_NAME)) as f:
    data = json.load(f)

path_to_add = "/".join(data["reference__fasta__base"][0]["secondaryFiles"][0]["path"].split("/")[:-1])

ref_name = data["reference__fasta__base"][0]["secondaryFiles"][0]["path"].split("/")[-1].split(".")[0]

# need to add: root.fa.gz, root.fa.gz.gzi, root.fa.gz.fai, root-resources.yaml, replace 'root' with whatever reference (GRCh37, hg38, etc)

add_postfixes = [".fa.gz", ".fa.gz.gzi", ".fa.gz.fai", "-resources.yaml"]

for postfix in add_postfixes:
    file_to_add = os.path.join(path_to_add, ref_name) + postfix
    to_add_dict = {u'path': u'{}'.format(file_to_add), u'class': u'File'}
    data["reference__fasta__base"][0]["secondaryFiles"].append(to_add_dict)


with open('./{job_name}-workflow/main-call_job-samples-fixed.json'.format(job_name = CALL_JOB_NAME), 'w') as f:
    json.dump(data, f, indent=2)


print("To call variants, run the following command:\narvados-cwl-runner --enable-reuse --api=containers --submit --no-wait ./{job_name}-workflow/main-{job_name}.cwl ./{job_name}-workflow/main-{job_name}-samples-fixed.json".format(job_name = CALL_JOB_NAME))
