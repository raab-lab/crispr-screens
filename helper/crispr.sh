#!/bin/bash

#SBATCH -c 2

#SBATCH --mem=10G

#SBATCH -t 24:00:00

#SBATCH -J NF

module add nextflow

## MODIFY ALL OF THE PATHS TO YOUR SPECIFIC PROJECT
nextflow run raab-lab/crispr-screens \
		--sample_sheet /path/to/sample_sheet \
		--grna /path/to/guide/library \
		--control_guides /path/to/control/guides \
		--contrast /path/to/contrast.tsv \
		--outdir /path/to/Output \
		-w /path/to/work \
		-with-report \
		-N <user@email.edu> \
		-latest \
		-ansi-log false \
		-resume


