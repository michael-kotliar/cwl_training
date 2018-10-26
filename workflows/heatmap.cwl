cwlVersion: v1.0
class: Workflow


inputs:

  gct_file:
    type: File


outputs:

  heatmap_file:
    type: File
    outputSource: make_heatmap/heatmap_file


steps:

  clean_up_data:
    run: ../tools/clean_up_data.cwl
    in:
      gct_file: gct_file
    out: [cleaned_gct_file]

  run_t_test:
    run: ../tools/run_t_test.cwl
    in:
      cleaned_gct_file: clean_up_data/cleaned_gct_file
    out: [p_value_file]

  make_heatmap:
    run: ../tools/make_heatmap.cwl
    in:
      cleaned_gct_file: clean_up_data/cleaned_gct_file
      p_value_file: run_t_test/p_value_file
    out: [heatmap_file]

