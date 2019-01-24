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

baseCommand: mkdir 
inputs:
  tgz: 
    type: File
    inputBinding:
      position: 6

outputs:
  unzipped:
    type: File
    outputBinding:
      glob: "*"

arguments:
  - valueFrom: |
      ${
        return runtime.outdir + "/" + inputs.tgz.basename.split(".")[0];
      }
    position: 1

  - valueFrom: "-p"
    position: 2

  - valueFrom: "&&"
    position: 3

  - valueFrom: "tar"
    position: 4
  
  - valueFrom: "xzvf"
    position: 5

  - prefix: -C
    valueFrom: |
      ${
        return runtime.outdir + "/" + inputs.tgz.basename.split(".")[0];
      }
    position: 10000
