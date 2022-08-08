CRISPR Screen 
=======

Basic nextflow implementation of our CRISPR Screen pipline. For now, it is dependent on longleaf and mageck. You must have installed mageck on longleaf. 

```
module load anaconda
conda create -n crispr-screen 
conda install -c bioconda mageck 
```
For editing the below sample sheets I suggest downloading them, opening in a excel or similar and saving as a csv or tsv (as the original was) and then reuploading to longleaf. 
To run: 
  1. Download this repository and copy to longleaf with a new name for your experiment
  2. Create a raw/ directory that contains your fastq.gz files 
  3. Edit sample_sheet.csv to have one row for each fastq file 
  4. Edit contrasts.tsv to set up samples that will be compared in mageck test (columns treatment and control are comma separated
  5. Run  ` sbatch run_analysis.sh `
