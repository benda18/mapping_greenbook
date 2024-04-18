# texas parse

library(renv)
library(readr)
library(devtools)
# devtools::install_github("briatte/tidykml")
library(tidykml)


renv::snapshot()

rm(list=ls());cat('\f')

"https://thc.texas.gov/learn/historic-resources-survey/african-american-travel-guide-survey-project"

# p.tx <- function(txt1){
#   require(dplyr)
#   require(glue)
#   temp <- txt1 %>% read_tsv(., 
#                             col_names = F)
#   temp <- temp$X1 %>%
#     as.vector
#   
#   #gsub("#", "", "tim # b")
#   
#   #temp[which((1:length(temp) %% 2) == 1)]
#   temp.df <- data.frame(name = temp[which((1:length(temp) %% 2) == 1)], 
#                         val = temp[which((1:length(temp) %% 2) == 0)])
#   
#   as_tibble(data.frame(decade = "not stated", 
#                        State  = "Texas",
#                        City   = temp.df$val[temp.df$name == "City"], 
#                        Type   = temp.df$val[temp.df$name == "Description"],
#                        Name   = temp.df$val[temp.df$name == "Name"], 
#                        Address = glue("{temp.df$val[temp.df$name == \"Address #\"]} {temp.df$val[grepl(pattern = \"^Street\", 
#                                       x =temp.df$name)]}"), 
#                        oneline = glue("{temp.df$val[temp.df$name == \"Address #\"]} {temp.df$val[grepl(pattern = \"^Street\", x =temp.df$name)]}, {temp.df$val[temp.df$name == \"City\"]}, Texas"), 
#                        cen_lon = temp.df$val[temp.df$name == "Longitude"], 
#                        cen_lat = temp.df$val[temp.df$name == "Latitude"] ))
# }
# 
# some.tx <- c("")
