#' Create CRISPR contrasts
#' 
#' Creates a dataframe of contrasts that can be passed to mageck in the CRISPR pipeline
#' 
#' @param samplesheet samplesheet containing two columns:
#' ID and Treatment. ID should correspond to the columns nextflow uses
#' for forming a unique ID, currently: SampleNumber, SampleID, `Cell Line`, Treatment, Replicate
#' (see example)
#' @param contrast_list a list of named vectors. Vectors should be named with the
#' contrast name. Each vector should contain control, treatment, and method (see example)
#' 
#' @returns a dataframe of contrasts
#' 
#' @example
#' x <- read.csv("/path/to/samplesheet.csv", check.names = F) %>%
#'  mutate(ID = paste(SampleNumber, SampleID, `Cell Line`, Treatment, Replicate, sep = "_")) %>%
#'  select(ID, Treatment) 
#'
#' contrast_list <- list(sndx_vs_dmso = c(control = "DMSO", treatment = "SNDX", method = 'control'),
#'                       d7_vs_d0 = c(control = 'd0', treatment = 'd7', method = 'control')) 
#' crispr_contrasts <- makeContrasts(samplesheet = x, contrast_list = contrast_list)
#' write.table(crispr_contrasts, "/contrast/output/path.tsv", sep = "\t", row.names = F, quote = F)

makeContrasts <- function(samplesheet, contrast_list) {
  purrr::imap(contrast_list, function(contrast, name) {
    control_samples <-
      paste0(samplesheet$ID[samplesheet$Treatment == contrast["control"]],
             collapse = ',')
    treatment_samples <-
      paste0(samplesheet$ID[samplesheet$Treatment == contrast["treatment"]],
             collapse = ',')
    
    data.frame(name = name,
               control = control_samples,
               treatment = treatment_samples,
               method = contrast['method'])
  }) %>%
    purrr::list_rbind() %>%
    tibble::remove_rownames()
}
