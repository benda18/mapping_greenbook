library(renv)
library(ggplot2)
library(tigris)
library(xlsx)
library(readxl)
library(janitor)
library(ggrepel)
library(dplyr)


renv::status()
renv::snapshot()

rm(list=ls());cat('\f')
gc()

gb <- read_xlsx("data/greenbook_addresses.xlsx")

# city labels
gb_citylabs <- gb |>
  group_by(State, City) |> 
  summarise(lon = mean(cen_lon, na.rm = T), 
            lat = mean(cen_lat, na.rm = T), 
            n = n()) 

# get states

sf_states <- tigris::states(cb = T) 
sf_states <- sf_states[sf_states$NAME %in% gb$State,]

ggplot() + 
  geom_sf(data = sf_states) +
  geom_point(data = gb, 
             aes(x = cen_lon, y = cen_lat)) +
  geom_text_repel(data = gb_citylabs, 
                  aes(x = lon, y = lat, 
                      label = City))
