library(renv)
library(tesseract)
library(dplyr)
library(readxl)
library(xlsx)
#library(remotes)
#library(censusxy)
#remotes::install_github("chris-prener/censusxy")
library(janitor)

#renv::snapshot()

rm(list=ls());cat('\f')
gc()

getwd()

tesseract_info()
tesseract_download("eng", datapath = "data/dict/")
