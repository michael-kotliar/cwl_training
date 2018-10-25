cwlVersion: v1.0
class: CommandLineTool


inputs:

  script:
    type: File
    inputBinding:
      position: 1

  input_file:
    type:
      - File
      - File[]
    inputBinding:
      position: 2


outputs:

  output_file:
    type: File
    outputBinding:
      glob: "*"


baseCommand: [Rscript]