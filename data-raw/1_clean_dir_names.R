# Get all the directory names in inst/extdata
dir_names <- fs::dir_ls(path = here::here("inst/extdata/"), type = "directory", recurse = TRUE)

# Find the ones with combined a umlaut accents
dir_dirty_names <- fs::dir_names[stringr::str_detect(dir_names, "\\u004E\\u0303[^/]*$")]

# Remplace the the combined accents with clean ones
dir_clean_names <- stringr::str_replace_all(dir_dirty_names, "\\u004E\\u0303", "ä")

# Function to rename the directories
clean_dir_name <- function(old_name, new_name) {
  if(old_name != new_name) fs::file_move(old_name, new_name)
}

# Apply the function where necessary
purrr::walk2(dir_dirty_names, dir_clean_names, clean_dir_name)
