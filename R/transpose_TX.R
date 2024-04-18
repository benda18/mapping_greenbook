# texas parse

library(renv)
library(readr)

rm(list=ls());cat('\f')

"https://thc.texas.gov/learn/historic-resources-survey/african-american-travel-guide-survey-project"

p.tx <- function(txt1 = "Name
Conyer's Gifts
Description
retail
Latitude
31.772121
Longitude
-106.462785
Extant?
Y
Address #
2314
Street (Historic [Current])
Bassett Ave
City
El Paso
County
El Paso"){
  require(dplyr)
  require(glue)
  temp <- txt1 %>% read_tsv(., 
                            col_names = F)
  temp <- temp$X1 %>%
    as.vector
  
  gsub("#", "", "tim # b")
  
  temp[which((1:length(temp) %% 2) == 1)]
  temp.df <- data.frame(name = temp[which((1:length(temp) %% 2) == 1)], 
                        val = temp[which((1:length(temp) %% 2) == 0)])
  
  as_tibble(data.frame(decade = NA, 
                       State  = "Texas",
                       City   = temp.df$val[temp.df$name == "City"], 
                       Type   = temp.df$val[temp.df$name == "Description"],
                       Name   = temp.df$val[temp.df$name == "name"], 
                       Address = glue("{temp.df$val[temp.df$name == \"Address #\"]}"), 
                       oneline = NA, 
                       cen_lon = NA, 
                       cen_lat = NA ))
}

p.tx()
