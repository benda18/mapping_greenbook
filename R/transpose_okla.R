# transpose oklahoma data

library(renv)
library(readxl)
library(xlsx)
#library(remotes)
#library(censusxy)
#remotes::install_github("chris-prener/censusxy")
library(janitor)


renv::snapshot()
renv::status()

rm(list=ls());cat('\f')
gc()

"https://docs.google.com/spreadsheets/d/1WSsBkYNjIPk3PqKZkyszcZA3HXEGPzbQY79G-BiAn0U/edit#gid=0"

# gbsum <- read_xlsx("data/greenbook_citysummary.xlsx")


# OLDER----
# read spreadsheet

okla <- readxl::read_xlsx(path = "data/greenbook_addresses.xlsx", 
                          sheet = "others")
