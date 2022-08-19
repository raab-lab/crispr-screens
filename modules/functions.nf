def helpMessage() { 
"""\
	==========================================================================================
	______            _       _           _       _____ ______ _____ _________________ 
	| ___ \\          | |     | |         | |     /  __ \\| ___ \\_   _/  ___| ___ \\ ___ \\
	| |_/ /__ _  __ _| |__   | |     __ _| |__   | /  \\/| |_/ / | | \\ `--.| |_/ / |_/ /
	|    // _` |/ _` | '_ \\  | |    / _` | '_ \\  | |    |    /  | |  `--. \\  __/|    / 
	| |\\ \\ (_| | (_| | |_) | | |___| (_| | |_) | | \\__/\\| |\\ \\ _| |_/\\__/ / |   | |\\ \\ 
	\\_| \\_\\__,_|\\__,_|_.__/  \\_____/\\__,_|_.__/   \\____/\\_| \\_|\\___/\\____/\\_|   \\_| \\_|
	===========================================================================================
	Usage:
	nextflow run raab-lab/crispr-screens --create_samplesheet </path/>
	nextflow run raab-lab/crispr-screens (--new_experiment|--pull_samples) <ID>
	nextflow run raab-lab/crispr-screens --sample_sheet </path/> --grna </path/> --control_guides </path/> --contrasts </path/>

	Arguments:
	--help
		Display this message

	--create_samplesheet </path/>
		Path to a directory of fastq.gz files

	--sample_sheet </path/>
		Path to CSV with fastq paths and sample metadata

	--new_experiment <ID>
		Experiment ID for new experiment to add to airtable

	--pull_samples <ID>
		Experiment ID to pull from airtable to run through pipeline

	--grna </path/>
		Path to guide RNA library

	--control_guides </path/>
		Path to control guides

	--contrasts </path/>
		Path to contrasts file

	-w </path/>
		Path to your desired work directory for intermediate output [Default: work]

	--outdir </path/>
		Path to your desired output directory [Default: Output]


	Arguments to Always Include:
	-latest
		Flag to pull the latest pipeline release from GitHub

	-with-report
		Flag to output a run report

	-N <user@email.edu>
		Email address to notify when the pipeline has finished

	-resume
		Flag to pick back up from last pipeline execution (works even if first time)

""".stripIndent()

}
