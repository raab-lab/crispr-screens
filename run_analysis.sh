#!/bin/bash

#SBATCH --cpus-per-task=4 
#SBATCH --time=12:00:00
#SBATCH --mail-user=jraab@email.unc.edu
#SBATCH --job-name crispr
#SBATCH --mail-type=end

START=$(date +"%Y-%m-%d")
echo "Starting: $START"
source activate crispr-screen
module load r/4.2.1


nextflow run bin/crispr_screen.nf -resume -work-dir /pine/scr/j/r/jraab/crispr/work -with-report logs/rna/novogene.html --outdir results/

END=$(date +"%Y-%m-%d")
echo "Ending: $END"



