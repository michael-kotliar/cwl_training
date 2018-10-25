cwlVersion: v1.0
class: Workflow


requirements:
  - class: MultipleInputFeatureRequirement


inputs:

  gct_file:
    type: File

  clean_up_data_script:
    type: File

  run_t_test_script:
    type: File

  make_heatmap_script:
    type: File


outputs:

  heatmap_file:
    type: File
    outputSource: make_heatmap/output_file


steps:

  clean_up_data:
    run: ../tools/run_custom_script.cwl
    in:
      script: clean_up_data_script
      input_file: gct_file
    out: [output_file]

  run_t_test:
    run: ../tools/run_custom_script.cwl
    in:
      script: run_t_test_script
      input_file: clean_up_data/output_file
    out: [output_file]

  make_heatmap:
    run: ../tools/run_custom_script.cwl
    in:
      script: make_heatmap_script
      input_file:
        - clean_up_data/output_file
        - run_t_test/output_file
    out: [output_file]
