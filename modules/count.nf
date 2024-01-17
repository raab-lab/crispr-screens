// Count each sample

process count {
	publishDir "${params.outdir}/counts", mode: 'copy'

	//conda 'bioconda::mageck'
	tag "${meta.id}"

	cpus 8
	time '24h'
	memory '16G'

	input:
	tuple val(meta), path(fq)
	path grna

	output:
	path "*.count.txt",		emit: counts
	path "*.count_normalized.txt",	emit: norm_counts
	path "*.countsummary.txt",	emit: summary

	script:
	"""
	singularity exec -B /work -B /proj/jraablab docker://davidliwei/mageck:latest mageck count \\
		-l $grna \\
		-n ${meta.id} \\
		--sample-label ${meta.id} \\
		--fastq $fq \\
		--norm-method none 
	"""
	
}
