# sundown towns

library(dplyr)
library(tigris)
library(ggplot2)
library(leaflet)
library(renv)
library(tidycensus)


renv::snapshot()

# https://justice.tougaloo.edu/sundown-towns/using-the-sundown-towns-database/state-map/

rm(list=ls());cat('\f')


counties <- tigris::counties(state = state.abb[!state.abb %in% c("AK", "HI")], 
                             cb = T)

