Parameters
==========

Defaults can be found either in nextflow.config or main.nf

`--sample_sheet`

Path to the experiment samplesheet in csv format. It should be formatted as follows:

|Column	        |Description					|
|---------------|-----------------------------------------------|
|R1		|Full path to the first read 			|
|SampleID	|Unique sequencing library ID		   	|
|Cell Line	|Cell line identifier (i.e. HepG2)		|
|Treatment	|Treatment or experimental conditions		|
|Replicate	|Experimental replicate number			|

Example:

    R1,SampleID,Cell Line,Treatment,Replicate
    /path/to/R1,UniqID,HepG2,Sorafenib,1

`--contrasts </path/>`

Path to contrasts file in tsv format. It should be formatted as follows:

|Column	        |Description											|
|---------------|-----------------------------------------------------------------------------------------------|
|name		|A name for the contrast									|
|control	|Comma separated list of control sample names <br> (MUST MATCH SampleID from sample sheet) 	|
|treatment	|Comma separated list of treatment sample names <br> (MUST MATCH SampleID from sample sheet) 	|
|norm_method	|Default to control										|

Example:

    name	control	treatment	norm_method
    drug_vs_control	veh1,veh2	treat1,treat2	control

`--grna </path/>`

Path to guide RNA library file

`--control_guides </path/>`

Path to control guide file

`--help`

Display this message

`--create_samplesheet </path/>`

Path to a directory of fastq.gz files

`--new_experiment <ID>`

Experiment ID for new experiment to add to airtable

`--pull_samples <ID>`

Experiment ID to pull from airtable to run through pipeline

`-w </path/>`

Path to your desired work directory for intermediate output [Default: work]

`--outdir </path/>`

Path to your desired output directory [Default: Output]

`-latest`

Flag to pull the latest pipeline release from GitHub

`-with-report`

Flag to output a run report

`-N <user@email.edu>`

Email address to notify when the pipeline has finished

`-resume`

Flag to pick back up from last pipeline execution (works even if first time)
