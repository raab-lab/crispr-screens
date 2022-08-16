#!/usr/bin/env Rscript
# Take a path where mageck counts are for each sample (quantified 1 at a time)
# Return the full count table for use in mageck test
library(purrr)
library(readr)
library(dplyr)
library(magrittr)

args <- commandArgs(trailingOnly = T)

raw_counts_df <- lapply(args, read_tsv)

out_df <- raw_counts_df %>%  reduce(full_join, by = c('sgRNA', 'Gene'))
write_tsv(out_df, 'combined_counts.txt', col_names = T) 
