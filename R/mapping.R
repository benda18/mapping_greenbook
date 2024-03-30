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

# get cities
sf_cities.al <- tigris::county_subdivisions(state = "AL", cb = T)
sf_cities.al$green <- F
sf_cities.al[sf_cities.al$NAME %in% gb$City & 
                            sf_cities.al$STATE_NAME == "Alabama",]$green <- T


# get states

sf_states <- tigris::states(cb = T) 
sf_states <- sf_states[sf_states$NAME %in% gb$State,]

ggplot() + 
  geom_sf(data = sf_states) +
  geom_sf(data = sf_cities.al, aes(fill = green))+
  geom_point(data = gb, 
             aes(x = cen_lon, y = cen_lat)) +
  # geom_text_repel(data = gb_citylabs, 
  #                 aes(x = lon, y = lat, 
  #                     label = City)) +
  theme_void()
