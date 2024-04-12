library(renv)
#library(ggplot2)
#library(tigris)
library(xlsx)
library(readxl)
library(janitor)
#library(ggrepel)
#library(dplyr)
#library(leaflet)

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

# https://bookdown.org/nicohahn/making_maps_with_r5/docs/leaflet.html

renv::status()
#renv::snapshot()

rm(list=ls());cat('\f')
gc()

getwd()
gb <- read_xlsx("data/greenbook_citysummary.xlsx")

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

basemap
