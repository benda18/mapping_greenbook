library(renv)
#library(ggplot2)
library(tigris)
library(xlsx)
library(readxl)
library(janitor)
#library(ggrepel)
#library(dplyr)
#library(leaflet)
library(censusxy)

# for loading our data
library(readr)
library(sf)
# for plotting
library(leaflet)
library(leaflet.extras)
# for more stuff
library(dbscan)
library(dplyr)
#library(openrouteservice)
library(geosphere)
library(magrittr)
library(shiny)

# https://bookdown.org/nicohahn/making_maps_with_r5/docs/leaflet.html

renv::status()
#renv::snapshot()

rm(list=ls());cat('\f')
gc()

getwd()
gb <- read_xlsx("data/greenbook_citysummary.xlsx")
gba <- read_xlsx("data/greenbook_addresses.xlsx")

# tidy
gb$lodging[is.na(gb$lodging)] <- 0
gb$dining[is.na(gb$dining)] <- 0
gb$beauty[is.na(gb$beauty)] <- 0
gb$entertainment[is.na(gb$entertainment)] <- 0
gb$automotive[is.na(gb$automotive)] <- 0
gb$tailor[is.na(gb$tailor)] <- 0

gb$total[is.na(gb$total) | gb$total == 0] <- 
  gb$lodging[is.na(gb$total)] + 
  gb$dining[is.na(gb$total)] + 
  gb$beauty[is.na(gb$total)] + 
  gb$beauty[is.na(gb$total)] + 
  gb$entertainment[is.na(gb$total)] + 
  gb$automotive[is.na(gb$total)] +
  gb$tailor[is.na(gb$total)]

gb

# get cities

tigris.cities <- NULL

for(i.st in unique(gb$state)){
  print(i.st)
  #temp <- county_subdivisions(i.st, cb = T)
  temp <- places(i.st, cb = T)
  
  for(i.ci in unique(gb$city[gb$state == i.st])){
    tigris.cities <- rbind(tigris.cities, 
                           temp[temp$STATE_NAME == i.st & 
                                  temp$NAME == i.ci,])
  }
  
  rm(temp)
}

tigris.cities <- sf::st_centroid(tigris.cities)

tigris.cities <- left_join(tigris.cities, 
                           gb, by = c("STATE_NAME" = "state", 
                                      "NAME" = "city"))


tigris.cities <- cbind(tigris.cities,
                       as_tibble(as.data.frame(sf::st_coordinates(tigris.cities)))) %>%
  sf::st_drop_geometry()



# get states----

tigris.states <- states(T)
tigris.states <- tigris.states[tigris.states$NAME %in% gb$state,]

# leaflet----

basemap <- leaflet() %>%
  # add different provider tiles
  addProviderTiles(
    "OpenStreetMap",
    # give the layer a name
    group = "OpenStreetMap"
  ) %>%
  addProviderTiles(
    "Esri.WorldStreetMap",
    group = "Esri.WorldStreetMap"
  ) %>%
  addProviderTiles(
    "CartoDB.Positron",
    group = "CartoDB.Positron"
  ) %>%
  addProviderTiles(
    "Esri.WorldImagery",
    group = "Esri.WorldImagery"
  ) %>%
  # add a layers control
  addLayersControl(
    baseGroups = c(
      "OpenStreetMap",
      "Esri.WorldStreetMap",
      "Esri.WorldImagery",
      "CartoDB.Positron"
    ),
    # position it on the topleft
    position = "topleft"
  ) 

gba[!duplicated(gba$Address),]

# address map
basemap %>%
  addMarkers(lng = gba[!duplicated(gba$Address),]$cen_lon, 
             lat = gba[!duplicated(gba$Address),]$cen_lat, 
             clusterOptions = 
               markerClusterOptions(
                 showCoverageOnHover = TRUE,
                 zoomToBoundsOnClick = T,
                 spiderfyOnMaxZoom = T,
                 removeOutsideVisibleBounds = F,
                 spiderLegPolylineOptions = list(weight = 1.5,
                                                 color = "black", 
                                                 opacity = 0.5),
                 freezeAtZoom = FALSE)) 
                   #radius = 15, #tigris.cities$total*1.5,
                   #fillOpacity = 0.2,
                   #color  = "black",
                   #fill = "white")

# summary map
# basemap %>%
#   addCircleMarkers(lng=tigris.cities$X,
#                    lat=tigris.cities$Y, 
#                    clusterOptions = 
#                      markerClusterOptions(
#                        showCoverageOnHover = TRUE,
#                        zoomToBoundsOnClick = T,
#                        spiderfyOnMaxZoom = T,
#                        removeOutsideVisibleBounds = F,
#                        spiderLegPolylineOptions = list(weight = 1.5,
#                                                        color = "black", 
#                                                        opacity = 0.5),
#                        freezeAtZoom = FALSE), 
#                    radius = tigris.cities$total*1.5,
#                    fillOpacity = 0.2,
#                    color  = "black",
#                    fill = "white");basemap
# 
