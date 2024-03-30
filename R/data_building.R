library(renv)
library(readxl)
#library(remotes)
library(censusxy)
#remotes::install_github("chris-prener/censusxy")
library(janitor)


renv::snapshot()
renv::status()

rm(list=ls());cat('\f')
gc()

# read spreadsheet----

gb <- read_xlsx(path = "data/greenbook_addresses.xlsx")

gb$oneline <- paste(gb$Address, 
                    gb$City, 
                    gb$State, sep = ", ")

