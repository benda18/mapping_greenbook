library(renv)
library(ggplot2)
library(tigris)
library(xlsx)
library(readxl)
library(janitor)
library(ggrepel)


renv::status()
renv::snapshot()

rm(list=ls());cat('\f')
gc()

gb <- read_xlsx("data/greenbook_addresses.xlsx")

# get states

sf_states <- tigris::states(cb = T) 
sf_states <- sf_states[sf_states$NAME %in% gb$State,]

ggplot() + 
  geom_sf(data = sf_states) +
  geom_point(data = gb, 
             aes(x = cen_lon, y = cen_lat))
