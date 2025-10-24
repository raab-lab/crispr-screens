// Merge count tables

process merge_counts {
	publishDir "${params.outdir}/counts/", mode: 'copy'
	module 'r/4.5.0'
	tag "Merge"

	input:
	path counts

	output:
	path 'combined_counts.txt'

	script:
	"""
	merge_counts.R $counts
	"""
}
