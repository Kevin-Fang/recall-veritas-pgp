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

baseCommand: ["tar", "xzvf"]

arguments: ["-C", $(runtime.outdir)] 

inputs:
  tgz: 
    type: File
    inputBinding:
      position: 1

outputs:
  unzipped:
    type: File
    outputBinding:
      glob: "*"
