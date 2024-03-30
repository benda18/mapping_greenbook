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

tigris.cities <- sf::st_centroid(tigris.cities)

tigris.cities <- left_join(tigris.cities, 
                           gb, by = c("STATE_NAME" = "state", 
                                      "NAME" = "city"))


# get states----

tigris.states <- states(T)
tigris.states <- tigris.states[tigris.states$NAME %in% gb$state,]


# map
ggplot() + 
  geom_sf(data = tigris.cities, 
          aes(size = count)) +
  geom_sf(data = tigris.states, color = "grey", fill = NA)+
  #scale_color_viridis_c(option = "C") +
  scale_size_area()+
  theme_dark() + 
  theme(axis.text = element_blank(), 
        axis.ticks = element_blank())+
  labs(title = "Greenbook Locations by City")


grep("albany", tigris.cities$NAME, 
     ignore.case = T, value = T)
