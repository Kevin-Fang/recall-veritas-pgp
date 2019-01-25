cwlVersion: v1.0
class: ExpressionTool

$namespaces:
  arv: "http://arvados.org/cwl#"
  cwltool: "http://commonwl.org/cwltool#"

requirements:
- class: InlineJavascriptRequirement

inputs:
  bamTexts:
    type: Directory

outputs:
  names:
    type: File[]

expression: "${
    var bamNameFiles = [];
    for (var i = 0; i < inputs.bamTexts.listing.length; i++) {
      var name = inputs.bamTexts.listing[i];
      var location = name.location;
      var basename = name.basename;
      if (basename.indexOf('txt') !== -1) {
          bamNameFiles.push(name);
        }
    }
    return {'names': bamNameFiles};
}"
