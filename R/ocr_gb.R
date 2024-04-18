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

#https://cran.r-project.org/web/packages/tesseract/index.html
# https://digitalcollections.nypl.org/items/f62ceaf0-847a-0132-6c49-58d385a7bbd0

"https://iiif-prod.nypl.org/index.php?id=5206459&t=v"

rm(list=ls());cat('\f')
gc()

getwd()


#tesseract_download("eng", datapath = "data/dict/")

# example----
#eng <- tesseract("eng")
#text <- tesseract::ocr("http://jeroen.github.io/images/testocr.png", engine = eng)
#cat(text)
#results <- tesseract::ocr_data("http://jeroen.github.io/images/testocr.png", engine = eng)
#results

# greenbook----

#gba <- read_xlsx("data/greenbook_addresses.xlsx")
#gbs <- read_xlsx("data/greenbook_citysummary.xlsx")

eng <- tesseract("eng")
ct1 <- ocr("img/temp.jpg", engine = eng)
cat(ct1)
