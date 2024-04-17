library(dplyr)
library(renv)
library(htmltools)
library(httr)
library(httr2)
library(xml2)
library(rvest)
#library(openssl)
rm(list=ls());cat('\f')

ncurl <- function(nc.name = "Alexander's Barber Shop"){
  require(glue)
  require(dplyr)
  
  var <- nc.name %>%
    tolower() %>%
    gsub("'|&|\\(|\\)|\\.", "", .) %>%
    
    gsub(" {1,}", "-", .)
  
  return(glue("https://aahc.nc.gov/green-book/{var}"))
}

nc.urls <- data.frame(name =  c("2nd St. Barber Shop",
  "Adams Tourist Home",
  "Addie Motel",
  "Alexander Hotel",
  "Alexander's Barber Shop",
  "Anchor Inn",
  "Apex (Julia Ellison)",
  "Arcade (Tailor)",
  "Arcade Hotel & Dining Room",
  "Arthur's Sea Food Grill Restaurant",
  "Ashland Avenue YWCA",
  "Atlantic",
  "B & H Cafe",
  "Ballard's Barber Shop",
  "Battle Grill",
  "Bedford Inn",
  "Bell's Restaurant",
  "Belmont",
  "Beth's Beauty Parlor",
  "Biddleville Luncheonette"), 
  url = NA) %>% as_tibble()

nc.urls$url <- unlist(lapply(nc.urls$name, 
                      ncurl))


for(i in 1:nrow(nc.urls)){
  nc.urls$url[i]
  
  temp_nameaddr <- rvest::read_html(nc.urls$url[i]) %>% 
    rvest::html_element(., xpath = "/html/body/div[1]/div/div/div[2]/div/div[2]/main/section/article/div/div[1]/div[1]/div[2]") %>%
    as.character() %>% 
    gsub("\n| {2,}", "", .) %>%
    gsub("</div></div>", "", .) %>%
    gsub("^<.*>", "", .) %>%
    strsplit(., "---") %>%
    unlist()
  
  colnames(temp_nameaddr) <- c("Name", "Address")
}

# fails bc no city name
