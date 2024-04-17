# transpose oklahoma data

library(renv)
library(readxl)
library(xlsx)
#library(remotes)
#library(censusxy)
#remotes::install_github("chris-prener/censusxy")
library(janitor)
library(data.table)

#renv::snapshot()
#renv::status()

rm(list=ls());cat('\f')
gc()

"https://docs.google.com/spreadsheets/d/1WSsBkYNjIPk3PqKZkyszcZA3HXEGPzbQY79G-BiAn0U/edit#gid=0"

# gbsum <- read_xlsx("data/greenbook_citysummary.xlsx")


# OLDER----
# read spreadsheet

okla <- readxl::read_xlsx(path = "data/greenbook_addresses.xlsx", 
                          sheet = "others")

okla <- janitor::clean_names(okla)
okla$gb_years <- strsplit(okla$years_included_in_green_book, 
                          ", |,") %>%
  lapply(., as.numeric)

okla$d30s <- F
okla$d40s <- F
okla$d50s <- F
okla$d60s <- F

for(i in 1:nrow(okla)){
  temp.dec <- floor((unlist(okla[i,]$gb_years)-1900)/10)*10
  
  if(30 %in% temp.dec){
    okla$d30s[i] <- T
  }
  if(40 %in% temp.dec){
    okla$d40s[i] <- T
  }
  if(50 %in% temp.dec){
    okla$d50s[i] <- T
  }
  if(60 %in% temp.dec){
    okla$d60s[i] <- T
  }
  
  
}

okla2 <- okla[!colnames(okla) %in% 
                c("years_included_in_green_book", 
                  "gb_years")]

okla2 <- melt(data = as.data.table(okla2), 
     id.vars = c("location_city", 
                 "business_name", 
                 "category", 
                 "address")) %>%
  as.data.table() %>%
  as_tibble() %>%
  mutate(., 
         decade = gsub("^d", "19", x = as.character(variable))) %>%
  .[.$value,c("location_city", "business_name", 
              "category", "address", 
              "decade")]

okla2$State <- "Oklahoma"

colnames(okla2)
colnames(okla2) <- c("City", 
                     "Name", 
                     "Type", 
                     "Address", 
                     "decade", 
                     "State")
