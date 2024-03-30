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

gb <- read_xlsx("data/greenbook_citysummary.xlsx")

# get cities

tigris.cities <- NULL

for(i.st in unique(gb$state)){
  print(i.st)
  temp <- county_subdivisions(i.st, cb = T)
  
  for(i.ci in unique(gb$city[gb$state == i.st])){
    tigris.cities <- rbind(tigris.cities, 
                           temp[temp$STATE_NAME == i.st & 
                                  temp$NAME == i.ci,])
  }
  
  rm(temp)
}

tigris.cities

# sf_cities.al <- tigris::county_subdivisions(state = unique(gb$state), cb = T)
# sf_cities.al$green <- F
# sf_cities.al[sf_cities.al$NAME %in% gb$City & 
#                             sf_cities.al$STATE_NAME == "Alabama",]$green <- T
# 
# # counties
# sf_counties.al <- tigris::counties(state = "AL", cb = T)
# 
# # get states
# 
# sf_states <- tigris::states(cb = T) 
# sf_states <- sf_states[sf_states$NAME %in% gb$State,]
# 
# ggplot() + 
#   geom_sf(data = sf_states) +
#   geom_sf(data = sf_cities.al, aes(fill = green), 
#           color = "white")+
#   geom_sf(data = sf_counties.al, 
#           fill = NA, color = "black")+
#   # geom_point(data = gb, 
#   #            aes(x = cen_lon, y = cen_lat)) +
#   # geom_text_repel(data = gb_citylabs, 
#   #                 aes(x = lon, y = lat, 
#   #                     label = City)) +
#   theme_void()
