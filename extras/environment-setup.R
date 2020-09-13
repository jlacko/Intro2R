# kontrola a aktualizace prostředí - stačí pustit jednou na každé instalaci

# toto potřebuju:
required <- c("rprojroot", "tidyverse", "curl", "readxl", "DBI", "RPostgreSQL", "odbc", "writexl",
              "stringi", "dbplyr", "lubridate", "scales", "sf", "RCzechia", "knitr", "kableExtra")
# toto mám:
installed <- installed.packages()[, 1]

# a tedy rozdíl stahnu z CRANu...
install.packages(setdiff(required, installed))

# best practice nastavení RStudia - https://gist.github.com/jlacko/8c6e19e59c6c78d8143e67d0f2c8eddb

# make certain jsonlite is available
if(!require(jsonlite, quietly = TRUE)) {
   install.packages("jsonlite")
   library(jsonlite)
}

# get the path to settings file
path <- if (Sys.info()[["sysname"]] == "Windows") {
   paste0(Sys.getenv('APPDATA'), "\\RStudio\\rstudio-prefs.json")
} else {
   "~/.config/rstudio/rstudio-prefs.json"
}

# is there a settings file present?
if(file.exists(path)) {
   settings <- jsonlite::read_json(path) # if yes, read it in
} else {
   settings <- list() # if not, initiate an empty list
}

# amend as required
settings["load_workspace"] <- FALSE
settings["save_workspace"] <- "never"
settings["default_encoding"] <- "UTF-8"
settings["always_save_history"] <- FALSE

# save the settings & get done with it...
jsonlite::write_json(settings, path, auto_unbox = TRUE, pretty = TRUE)