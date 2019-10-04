# kontrola a aktualizace prostředí - stačí pustit jednou na každé instalaci

# toto potřebuju:
required <- c("rprojroot", "tidyverse", "curl", "readxl", "DBI", "RPostgreSQL", "odbc",
              "stringi", "dbplyr", "lubridate", "scales", "sf", "RCzechia", "knitr", "kableExtra")
# toto mám:
installed <- installed.packages()[, 1]

# a tedy rozdíl stahnu z CRANu...
install.packages(setdiff(required, installed))