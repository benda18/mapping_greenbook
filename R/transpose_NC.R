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

url_title <- c("2nd St. Barber Shop",
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
  "Biddleville Luncheonette", 
  "Chicken 'N' Ribs")

url.url <- c("https://aahc.nc.gov/green-book/2nd-st-barber-shop", 
             "https://aahc.nc.gov/green-book/adams-tourist-home", 
             "https://aahc.nc.gov/green-book/addie-motel", 
             "https://aahc.nc.gov/green-book/alexander-hotel", 
             "https://aahc.nc.gov/green-book/alexanders-barber-shop", 
             NA, 
             "https://aahc.nc.gov/green-book/apex-julia-ellison", 
             NA, 
             "https://aahc.nc.gov/green-book/arcade-hotel-dining-room", 
             rep(NA, 3), 
             "https://aahc.nc.gov/green-book/b-h-cafe", 
             rep(NA, 7), 
             "https://aahc.nc.gov/green-book/chicken-n-ribs")

test <- as_tibble(data.frame(name = url_title, 
           url = url.url)) %>%
  mutate(test.url = NA)

test$test.url <- unlist(lapply(test$name, 
       ncurl))

test$test.url == test$url

tail(test)
