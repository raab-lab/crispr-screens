// Import CRISPR Screen modules

include { check_ss }		from './modules/check_samplesheet'
include { count }		from './modules/count'
include { merge_counts }	from './modules/merge'
include { rra }			from './modules/test'

// Define parsing functions

def parse_samplesheet(LinkedHashMap row) {
	def meta = [:]
	meta.id		= row.SampleID
	meta.cell_line	= row["Cell Line"]
	meta.trt	= row.Treatment

	def array = [meta, file(row.R1)]

	return array

}

def parse_contrasts(LinkedHashMap row) {
	def meta = [:]
	meta.name		= row.name
	meta.control		= row.control
	meta.trt		= row.treatment
	meta.norm_method 	= row.norm_method

	return meta
}

workflow CRISPR {

	take:
	samplesheet

	main:

	// Check the sample sheet
	check_ss(samplesheet)
	check_ss.out
		.splitCsv(header:true)
		.map { parse_samplesheet(it) }
		.set { READS }

	// Count reads by sample
	count(READS, params.grna)

	// Merge to count matrix
	merge_counts(count.out.counts.collect())

	// Test contrasts
	Channel
		.fromPath(params.contrasts)
		.splitCsv(header:true, sep: '\t')
		.map { parse_contrasts(it) }
		.set { contrasts }

	rra(merge_counts.out, params.control_guides, contrasts)
}
