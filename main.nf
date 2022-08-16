#!/usr/bin/env nextflow
nextflow.enable.dsl=2

/*
 * DSL2 Implementation of Raab Lab CRISPR pipeline
 *
 * Authors:	Peyton Kuhlers <peyton_kuhlers@med.unc.edu>
 * 		Jesse Raab <jesse_raab@med.unc.edu>
 *
 */

// Define pipeline-wide params
params.sample_sheet		= ''
params.outdir			= 'Output'
params.create_samplesheet	= ''
params.grna			= ''
params.control_guides		= ''
params.contrasts		= ''

// Import modules

include { create_ss }		from './modules/create_samplesheet'
include { check_ss }		from './modules/check_samplesheet'
include { count }		from './modules/count'
include { merge_counts }	from './modules/merge'
include { rra }			from './modules/test'

// Define workflow

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

// Create the samplesheet given a data directory

workflow CREATE_SAMPLESHEET {

	take:
	inventory

	main:

	create_ss(inventory)

	emit:
	create_ss.out

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

workflow {

	if (params.create_samplesheet && params.sample_sheet) {
		exit 1, "ERROR: Conflicting samplesheet arguments. Choose one or the other."
	}

	if (params.create_samplesheet) {
		CREATE_SAMPLESHEET(params.create_samplesheet)
	}

	if (params.sample_sheet) {
		CRISPR(params.sample_sheet)
	}
}
