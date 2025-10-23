process check_ss{
	module 'r/4.5.0'
	tag "Samplesheet"

	input:
	path SS

	output:
	path 'samplesheet_*.csv'

	script:
	"""
	check_samplesheet.R $SS
	"""
}
