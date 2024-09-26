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
library(data.table)

rm(list=ls());cat('\f')
gc()

#pl.est <- tidycensus::get_estimates(geography = "place", geometry = T)

acs5.vars <- tidycensus::load_variables(dataset = "acs5", year = 2022)

acs5.vars$concept %>% grep("race", ., ignore.case = T, value = T) %>%
  unique()

acs5.vars[acs5.vars$concept == "Race",]

theones <- c("B02001_001", "B02001_002")


cw.racevars <- data.frame(variable = theones, 
                          race = c("total", "white"))

data.race.pl <- tidycensus::get_acs(geography = "place", 
                                    variables = theones, 
                                    geometry = T)

data.race.co <- tidycensus::get_acs(geography = "county", 
                                    variables = theones, 
                                    geometry = T)


race.pl <- left_join(data.race.pl, 
                     cw.racevars) %>% 
  as.data.table() %>%
  dcast(., 
         geometry+NAME ~ race, value.var = "estimate") %>%
  as.data.frame() %>%
  as_tibble() %>%
  mutate(., 
         pct_white = white/total, 
         n_notwhite = total-white)

race.co <- left_join(data.race.co, 
                     cw.racevars) %>%
  as.data.table() %>%
  dcast(., 
        NAME ~ race, value.var = "estimate") %>%
  as.data.frame() %>%
  as_tibble() %>%
  mutate(., 
         pct_white = white/total, 
         n_notwhite = total-white)


# top N percentage white OR less than 100 black ppl
top_n      <- 0.01
pct.cutoff <- 0.95
n.cutoff   <- 10

counties.out <- race.co[race.co$pct_white >= pct.cutoff |
                          race.co$n_notwhite <= n.cutoff,]

places.out <- race.pl[race.pl$pct_white >= pct.cutoff |
                        race.pl$n_notwhite <= n.cutoff,]
