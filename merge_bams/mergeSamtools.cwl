#/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

$namespaces:
  arv: "http://arvados.org/cwl#"
  cwltool: "http://commonwl.org/cwltool#"

requirements:
  - class: DockerRequirement
    dockerPull: kfang/samtools
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    ramMin: 6000

hints:
  arv:RuntimeConstraints:
    outputDirType: keep_output_dir
    keep_cache: 4096

baseCommand: python
inputs:
  name:
    type: File
    inputBinding: 
      position: 2
  mergeScript:
    type: File
    inputBinding: 
      position: 1
  bams:
    type: Directory
outputs:
  mergedBams:
    type: File[]
    outputBinding:
      glob: "*"
