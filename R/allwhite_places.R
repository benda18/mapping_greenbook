# allwhites.census

library(dplyr)
library(tigris)
library(ggplot2)
library(leaflet)
library(renv)
library(tidycensus)
library(leaflet)
library(sf)
library(readr)

rm(list=ls());cat('\f')
gc()

pl.est <- tidycensus::get_estimates(geography = "place")

args(get_estimates)

acs5.vars <- tidycensus::load_variables(dataset = "acs5", year = 2022)

acs5.vars$concept %>% grep("race", ., ignore.case = T, value = T) %>%
  unique()

acs5.vars[acs5.vars$concept == "Race",]

theones <- c("B02001_001", "B02001_002")


cw.racevars <- data.frame(variable = theones, 
                          race = c("total", "white"))

data.race.pl <- tidycensus::get_acs(geography = "place", 
                    variables = theones)

data.race.co <- tidycensus::get_acs(geography = "county", 
                                    variables = theones)
