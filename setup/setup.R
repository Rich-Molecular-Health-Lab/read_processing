here::i_am("setup/setup.R")

source(here::here(global$packages))
source(here::here(global$conflicts))
source(here::here(global$functions))
source(here::here(global$inputs))


scripts           <- config::get(config = "scripts")
loris             <- config::get(config = "loris")
bats              <- config::get(config = "bats")
isolates          <- config::get(config = "isolates")
methods_16s       <- config::get(config = "methods_16s")
sample_sheets     <- config::get(config = "sample_sheets")
abund_wf16s_files <- config::get(config = "abund_wf16s_files")
barcode_alignments<- config::get(config = "barcode_alignments")

seqruns      <- seqruns %>% keep_at(params$sampleset)       %>% list_flatten(name_spec = "")
subject_list <- keep_at(subjects, paste0(params$sampleset)) %>% list_flatten(name_spec = "{inner}")
path         <- config::get(config = paste0(params$sampleset))

knitr::knit_engines$set(terminal = function(options) {
  code <- paste(options$code, collapse = "\n")
  
  params <- map(params, ~ if (is.atomic(.)) {list(.)} else {(.)}) %>%
    list_flatten()
  
  patterns <- list(
    params             = list(
      sampleset    = paste0(params$sampleset),
      seqrun       = paste0(params$seqrun),
      samplesheet  = as.character(sample_sheets[paste0(tolower(params$seqrun))])
    )            ,
    scripts            = scripts           ,
    path               = path              ,
    loris              = loris             ,
    isolates           = isolates          ,
    methods_16s        = methods_16s       ,
    sample_sheets      = sample_sheets     ,
    abund_wf16s_files  = abund_wf16s_files ,
    barcode_alignments = barcode_alignments
  )
  
  
  # Replace placeholders group by group
  for (group in names(patterns)) {
    placeholder_list <- patterns[[group]]
    for (name in names(placeholder_list)) {
      placeholder <- paste(group, name, sep = "\\$") # Match exact placeholder
      value <- placeholder_list[[name]]
      
      # Replace placeholders exactly and avoid breaking suffixes
      code <- gsub(placeholder, value, code, perl = TRUE)
    }
  }
  
  options$warning <- FALSE
  knitr::engine_output(options, code, out = code)
})

opts_chunk$set(message = FALSE,
               warning = FALSE,
               echo    = TRUE,
               include = TRUE,
               eval    = TRUE,
               comment = "")

