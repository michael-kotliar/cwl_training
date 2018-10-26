cwlVersion: v1.0
class: Workflow


inputs:

  message:
    type: string

  trgt_filename:
    type: string


outputs:

  renamed_file:
    type: File
    outputSource: rename/renamed_file


steps:

  echo:
    run: ../tools/echo.cwl
    in:
      message: message
    out: [echo_file]

  rename:
    run: ../tools/rename.cwl
    in:
      src_file: echo/echo_file
      trgt_filename: trgt_filename
    out: [renamed_file]