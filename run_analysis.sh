#!/bin/bash

#SBATCH --cpus-per-task=4 
#SBATCH --time=12:00:00
#SBATCH --mail-user=<EMAIL>
#SBATCH --job-name crispr
#SBATCH --mail-type=end

START=$(date +"%Y-%m-%d")
echo "Starting: $START"
source activate crispr-screen
module load r/4.2.1

# Directories 
WORKDIR=work
LOGS=logs/crispr.html
OUTDIR=results/

nextflow run bin/crispr_screen.nf -resume -work-dir $WORKDIR -with-report $LOGS --outdir $OUTDIR

END=$(date +"%Y-%m-%d")
echo "Ending: $END"



