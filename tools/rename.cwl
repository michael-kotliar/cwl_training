cwlVersion: v1.0
class: CommandLineTool


inputs:

  src_file:
    type: File
    inputBinding:
      position: 1

  trgt_filename:
    type: string
    inputBinding:
      position: 2


outputs:

  renamed_file:
    type: File
    outputBinding:
      glob: "*"


baseCommand: cp
