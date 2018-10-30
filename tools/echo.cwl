cwlVersion: v1.0
class: CommandLineTool


inputs:

  message:
    type: string
    inputBinding:
      position: 1


outputs:

  echo_file:
    type: File
    outputBinding:
      glob: "*"


stdout: "echo.txt"


baseCommand: echo