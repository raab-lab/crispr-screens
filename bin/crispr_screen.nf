#!/usr/bin/env nextflow 

/*
vim: syntax=groovy
-*- mode: grrovy; -*-
*/

// Parameters
params.outdir = 'results/'
params.sample_sheet = 'MD_sample_sheet.csv'
params.grna_lib  = 'epi_lib.tsv' // human epigenome guide library
params.data = 'raw/'
params.control_guides = 'controls_sgRNAs.txt'
params.contrasts = 'contrasts.tsv'



ch_grna_lib = Channel.fromPath(params.grna_lib)
ch_control_guides = Channel.fromPath(params.control_guides)

// samples for counting
Channel.fromPath(params.sample_sheet)
   .splitCsv(header:true)
   .map {tuple(it.SampleName, file("$params.data/" + it.Fastq)) }  
   .into { ch_files; ch_tmp_names } 
   

Channel.fromPath(params.contrasts)
   .splitCsv(header:true, sep : '\t')
   .map { tuple (it.name, it.control, it.treatment, it.norm_method )} 
   .into { ch_contrasts ; ch_tmp_contrasts} 


process count  { 
   publishDir "${params.outdir}/mageck_counts/" , mode: 'copy'

   input: 
   set val(name), file(fq)  from ch_files
   file (grna) from ch_grna_lib.collect()
 

   output: 
   file("${name}.count.txt") into ch_counts_table // think this gives a couple version - 
   file("${name}.count_normalized.txt") into ch_count_norm
   file("${name}.countsummary.txt") into ch_count_summary
 
   script:    
   """   
   mageck count -l $grna --sample-label $name --fastq $fq --norm-method none  -n $name
   """
   } 


process merge_counts { 
   publishDir "${params.outdir}/mageck_counts/", mode: 'copy'

   input: 
   file(counts) from ch_counts_table.collect()

   output: 
   file('combined_counts.txt') into ch_combined_counts

   script: 
   """
   Rscript --vanilla '$baseDir/combine_mageck_out.R' ${counts}
   """
}



process rra { 
   publishDir "${params.outdir}/mageck_results/rra/", mode: 'copy'


   input: 
   file(counts) from ch_combined_counts.collect()
   file(control_guides) from ch_control_guides.collect()
   set val(name), val(controls), val(treatments), val(norm_method) from ch_contrasts  
  

   output: 
   file("${name}*") into ch_final_rra

   script: 
   """  
   mageck test -k $counts -t $treatments -c $controls -n $name --control-sgrna ${control_guides}  --norm-method $norm_method
   """
} 
