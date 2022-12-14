#!/usr/bin/env nextflow


process ECHO_INPUT {
  debug true

  container 'public.ecr.aws/ubuntu/ubuntu:20.04_stable'

  publishDir "${params.output_dir}"

  input:
  tuple val(meta), val(data)

  output:
  tuple val(meta), path('*txt'), emit: txt

  script:
  """
  echo "meta: ${meta}"
  echo "data: ${data}" | tee ${task.process}_${task.index}.txt
  sleep 5
  """
}


workflow {

  inputs = Channel.of(
    [[id: 1], 'one'],
    [[id: 2], 'two'],
    [[id: 3], 'three'],
    [[id: 4], 'four'],
    [[id: 5], 'five'],
  )
  ECHO_INPUT(inputs)

}
