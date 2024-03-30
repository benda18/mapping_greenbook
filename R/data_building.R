library(renv)
library(readxl)
#library(remotes)
library(censusxy)
#remotes::install_github("chris-prener/censusxy")

renv::snapshot()
renv::status()

rm(list=ls());cat('\f')
gc()

# 