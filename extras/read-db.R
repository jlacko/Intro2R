library(tidyverse)
library(dbplyr)
library(odbc)
library(DBI)

# připojení databáze - pozor, vyžaduje volný port 5432!! (může být problém v korporátu)
con <- dbConnect(odbc::odbc(), driver = "PostgreSQL Unicode",
                 server = "db.jla-data.net", port = 5432, uid = "R4SU",
                 password = "R4SU", database = "R4SU")

# vytvořím query o kapříkovi na Vánoce
kaprik <- tbl(con, "potraviny") %>% 
   filter(reprcen_kod == "2000001"
          & uzemi_kod != 19
          & obdobiod >= "2017-12-01" 
          & obdobido <= "2018-01-01") 

# prohlédnu si sql kód odpovídající kapříkovi (zatím žádná exekuce!)
sql_render(kaprik)

# exekuce kódu - teprve teď se pustí kód proti databázi
realny_kaprik <- collect(kaprik)

dbDisconnect(con) # uklidit po sobě je slušnost...