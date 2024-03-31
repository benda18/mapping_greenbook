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


# get states----

tigris.states <- states(T)
tigris.states <- tigris.states[tigris.states$NAME %in% gb$state,]


# map
ggplot() + 
  geom_sf(data = tigris.states, color = "grey", fill = NA)+
  geom_sf(data = tigris.cities, alpha = 0.5,
          aes(size = total)) +
  #scale_color_viridis_c(option = "C") +
  scale_size_area()+
  theme_dark() + 
  theme(axis.text = element_blank(), 
        axis.ticks = element_blank())+
  labs(title = "Greenbook Locations by City")



