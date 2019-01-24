#/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

$namespaces:
  arv: "http://arvados.org/cwl#"
  cwltool: "http://commonwl.org/cwltool#"

requirements:
  - class: DockerRequirement
    dockerPull: kfangcurii/bcbioarvados
  - class: InlineJavascriptRequirement

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
outputs:
  cram:
    type: File[]
    outputBinding:
      glob: "*"
