cwlVersion: v1.0
class: CommandLineTool


inputs:

  gct_file:
    type: File
    inputBinding:
      position: 5


outputs:

  cleaned_gct_file:
    type: File
    outputBinding:
      glob: "*"


baseCommand:
  - Rscript
  - /Users/kot4or/workspaces/cwl_ws/cwl_training/scripts/clean_up_data.R