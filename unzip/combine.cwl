#/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

$namespaces:
  arv: "http://arvados.org/cwl#"
  cwltool: "http://commonwl.org/cwltool#"

requirements:
  - class: DockerRequirement
    dockerPull: kfangcurii/bcbioarvados

hints:
  arv:RuntimeConstraints:
    outputDirType: keep_output_dir
    keep_cache: 4096

baseCommand: ["samtools", "merge"]

inputs:
  files: 
    type: File[]
    inputBinding:
      position: 2
      glob: ".bam"

outputs:
  combinedBAM:
    type: File
    outputBinding:
      glob: "*"

arguments:
  - valueFrom: ${
      inputs.files.listing[0].basename
