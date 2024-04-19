# texas parse

library(renv)
library(readr)
library(devtools)
# devtools::install_github("briatte/tidykml")
library(tidykml)


renv::snapshot()

rm(list=ls());cat('\f')

"https://thc.texas.gov/learn/historic-resources-survey/african-american-travel-guide-survey-project"



kmlpath <- "data/African-American Travel Guide_tx.kml"

kml <- tidykml::kml_read(kmlpath)

tidykml::kml_info(kml)
tidykml::kml_bounds(kml)
guide <- tidykml::kml_points(kml)



p.tx <- function(txt1){
  require(dplyr)
  require(glue)
  temp <- txt1
  
  df.out <- NULL
  for(i in 1:length(temp)){
    tempa <- unlist(strsplit(x = temp[i], 
             split = ": "))
    df.out <- rbind(df.out, 
          data.frame(name = tempa[1], 
               val = tempa[2]))
    
  }
  df.out

    as_tibble(data.frame(decade = "not stated",
                       State  = "Texas",
                       City   = df.out$val[df.out$name == "City"],
                       Type   = df.out$val[df.out$name == "Description"],
                       Name   = NA, #df.out$val[df.out$name == "Name"],
                       Address = glue("{df.out$val[df.out$name == \"Address #\"]} {df.out$val[grepl(pattern = \"^Street\",x =df.out$name)]}"),
                       oneline = glue("{df.out$val[df.out$name == \"Address #\"]} {df.out$val[grepl(pattern = \"^Street\", x =df.out$name)]}, {df.out$val[df.out$name == \"City\"]}, Texas"),
                       cen_lon = as.numeric(df.out$val[df.out$name == "Longitude"]),
                       cen_lat = as.numeric(df.out$val[df.out$name == "Latitude"]) ))
}


tx.out <- NULL
for(i in 1:nrow(guide)){
  tx.out <- rbind(tx.out, 
                  p.tx(unlist(strsplit(guide$description[i], "<br>"))))
  #p.tx(unlist((guide$description[i])))
}

tx.out
