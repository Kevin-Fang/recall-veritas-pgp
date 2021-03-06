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

baseCommand: ["tar", "xzvf"]
inputs:
  tgz: 
    type: File
    inputBinding:
      position: 6

outputs:
  unzipped:
    type: File[] 
    outputBinding:
      glob: "*"

