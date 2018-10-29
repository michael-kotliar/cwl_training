cwlVersion: v1.0
class: CommandLineTool


inputs:

  cleaned_gct_file:
    type: File
    inputBinding:
      position: 5

  p_value_file:
    type: File
    inputBinding:
      position: 6

  max_p_value:
    type: float
    inputBinding:
      position: 7

outputs:

  heatmap_file:
    type: File
    outputBinding:
      glob: "*"


baseCommand:
  - Rscript
  - /Users/kot4or/workspaces/cwl_ws/cwl_training/scripts/make_heatmap_updated.R