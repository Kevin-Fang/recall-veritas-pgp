cwlVersion: v1.0
class: ExpressionTool

$namespaces:
  arv: "http://arvados.org/cwl#"
  cwltool: "http://commonwl.org/cwltool#"

requirements:
- class: InlineJavascriptRequirement

inputs:
  pgp:
    type: Directory

outputs:
  tgzFiles:
    type: File[]

expression: "${
    var tgzFiles = [];
    for (var i = 0; i < inputs.pgp.listing.length; i++) {
      var name = inputs.pgp.listing[i];
      var location = name.location;
      var basename = name.basename;
      if (basename.indexOf('tgz') !== -1) {
          tgzFiles.push(name);
        }
    }
    return {'tgzFiles': tgzFiles};
}"
