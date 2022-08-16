// Robust Rank Aggregation

process rra {
	publishDir "${params.outdir}/results/${contrast.name}", mode: 'copy'

	conda 'bioconda::mageck'
	tag "${contrast.name}"

	cpus 8
	time '24h'
	memory '16G'

	input:
	path counts
	path control_guides
	val contrast

	output:
	path "${contrast.name}*"

	script:
	"""
	mageck test \\
		-k $counts \\
		-t ${contrast.trt} \\
		-c ${contrast.control} \\
		-n ${contrast.name} \\
		--control-sgrna $control_guides \\
		--norm-method ${contrast.norm_method}
	"""

}
