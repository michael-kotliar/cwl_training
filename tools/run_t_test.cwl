cwlVersion: v1.0
class: CommandLineTool


inputs:

  cleaned_gct_file:
    type: File
    inputBinding:
      position: 5


outputs:

  p_value_file:
    type: File
    outputBinding:
      glob: "*"


baseCommand:
  - Rscript
  - /Users/kot4or/workspaces/cwl_ws/cwl_training/scripts/run_t_test.R