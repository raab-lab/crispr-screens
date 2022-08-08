# Take a path where mageck counts are for each sample (quantified 1 at a time)
# Return the full count table for use in mageck test
library(tidyverse)
library(purrr)
args <- commandArgs(trailingOnly = T)
input_path <- args
#input_path <- '~/proj/md_screens/liver_drug_combos/results/mageck_counts'
raw_counts_files <- args
#raw_counts_files <- list.files(path = input_path , pattern = '*count.txt', full.names = T)
#norm_counts_files <- list.files(path = input_path, pattern = '*count_normalized.txt', full.names = T )  
# probably don't care about these b/c I do the count without normalizing

raw_counts_df <- lapply(raw_counts_files, read_tsv)
raw_counts_df[2]

out_df <- raw_counts_df %>%  reduce(full_join, by = c('sgRNA', 'Gene'))
write_tsv(out_df, 'combined_counts.txt', col_names = T) 


