library(tidyverse)
library(odbc)
library(DBI)

con <- dbConnect(odbc::odbc(), .connection_string = "Driver={PostgreSQL Unicode};Server=db.jla-data.net;Port=5432;Database=R4SU;Uid=R4SU;Pwd=R4SU;", timeout = 10)

sql_code <- readLines("./extras/potraviny.sql")

asdf <- dbGetQuery(con, sql_code)

dbDisconnect(con) # uklidit po sobě je slušnost...