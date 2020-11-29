#source("data-raw/1_clean_dir_names.R")
source("data-raw/2_classify_files.R")
source("data-raw/3_relief.R")

usethis::use_data(
  inst, rrep, anal, rtyp, inke, topo, relief,
  internal = T, overwrite = T
)
