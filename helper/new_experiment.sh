#!/bin/bash

module add nextflow
source ~/.secrets/airtable

## MODIFY THE EXPERIMENT ID FOR THE EXPERIMENT YOU WANT TO RUN
nextflow run raab-lab/crispr-screens \
	--new_experiment $1 \
	-latest

