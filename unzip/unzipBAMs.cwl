cwlVersion: v1.0
class: Workflow

$namespaces:
  arv: "http://arvados.org/cwl#"
  cwltool: "http://commonwl.org/cwltool#"

requirements:
  - class: ScatterFeatureRequirement
  - class: DockerRequirement
    dockerPull: kfangcurii/bcbioarvados
  - class: SubworkflowFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  pgpDirectory:
    type: Directory

outputs:
  unzippedBam:
    type:
      type: array
      items:
        type: array
        items: File
    outputSource: unzip/unzipped

steps:
  readBAMList:
    run: readBAMList.cwl
    in:
      pgp: pgpDirectory
    out: [tgzFiles]
  unzip:
    run: unzip.cwl
    scatter: [tgz]  
    scatterMethod: dotproduct
    in:
      tgz: readBAMList/tgzFiles
    out:
      [unzipped]
