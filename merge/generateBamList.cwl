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

# generates the text files

baseCommand: python
inputs:
  bams:
    type: Directory
    inputBinding:
      position: 1
  pythonGenerate:
    type: File
    inputBinding:
      position: 0 

outputs:
  textFiles:
    type: Directory
    outputBinding:
      glob: "*"
