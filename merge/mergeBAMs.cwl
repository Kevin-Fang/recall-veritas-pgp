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
  bamDirectory:
    type: Directory
  generateBamListScript:
    type: File
  mergeBamScript:
    type: File

outputs:
  mergedBamDirectory:
    type:
      type: array
      items:
        type: array
        items: File
    outputSource: merge/mergedBams

steps:
  generateBamList:
    run: generateBamList.cwl
    in:
      bams: bamDirectory
      pythonGenerate: generateBamListScript
    out: [textFiles]
  readBamList:
    run: readBamList.cwl
    in:
      bamTexts: generateBamList/textFiles
    out: [names]
  merge:
    run: mergeSamtools.cwl
    scatter: [name]   
    scatterMethod: dotproduct
    in:
      name: readBamList/names
      mergeScript: mergeBamScript
    out:
      [mergedBams]
