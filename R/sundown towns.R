# sundown towns

library(dplyr)
library(tigris)
library(ggplot2)
library(leaflet)
library(renv)
library(tidycensus)
library(leaflet)
library(sf)

#renv::snapshot()

# https://justice.tougaloo.edu/sundown-towns/using-the-sundown-towns-database/state-map/

rm(list=ls());cat('\f')


greenwood.tulsa.ok <- county_subdivisions(state = "OK",  
                                          cb = T)
grep(pattern = "Greenwood", x = greenwood.tulsa.ok$NAME, 
     value = T)

pl.ok <- tigris::places(state = "OK", cb = T)

grep(pattern = "Greenwood", x = pl.ok$NAME, 
     value = T)


tidycensus::get_decennial(geography = "county", 
                          state = "NC", 
                          year = 1990)

expelled.places <- tigris::places( cb = T) 
expelled.counties <- tigris::counties(cb = T) 

expelled.counties <- expelled.counties[paste(expelled.counties$NAME, 
                        expelled.counties$STUSPS, sep = ", ") %in% 
                    c("Comanche, TX", "Greene, IN", 
                      "Marshall, KY", "Forsyth, GA", 
                      "Lincoln, NE", "Marion, OH", 
                      "Humphreys, TN", "Scott, TN", 
                      "Vermillion, IN", "Boone, AR", "DeKalb, GA"),]  %>%
  mutate(., 
         desc = "Place that once expelled entire Black population")

expelled.places <- expelled.places[paste(expelled.places$NAME, 
                      expelled.places$STUSPS, sep = ", ") %in% 
                  c("Portsmouth, OH", 
                    "Birmingham, KY", 
                    "Blanford, IN",
                    "Wyandotte, MI", "Pollock, LA", 
                    "Colfax, LA",
                    "Celina, TN", 
                    "Paragould, AR", 
                    "Lexington, OK", 
                    "Blackwell, OK", 
                    "Monett, MO", 
                    "Linton, IN", 
                    "Elwood, IN", 
                    "Wilmington, NC", 
                    "Pana, IL", 
                    "Carterville, IL", 
                    "Mena, AR", 
                    "Pierce City, MO", 
                    "Decateur, IN", 
                    "Joplin, MS", 
                    "Sour Lake, TX", 
                    "Harrison, AR", 
                    "Cotter, AR" , 
                    "Anna, IL", 
                    "Jonesboro, IL", 
                    "East St. Louis, IL", 
                    "Corbin, KY", 
                    "Ocoee, FL",
                    "Tulsa, OK", 
                    "Jay, FL", 
                    "Rosewood, FL", 
                    "Blanford, IN", 
                    "Manhattan Beach, CA", 
                    "Vienna, IL", 
                    "Sheridan, AR", 
                    "Garrett, Ky", 
                    "Dothan, AL"),]  %>%
  mutate(., 
         desc = factor("Place that once expelled entire Black population"))

ggplot() + 
  geom_sf(data = expelled.counties) +
  geom_sf(data = expelled.places) 

df.polygons <- NULL

#View(expelled.counties$geometry)

out.df <- NULL
for(i in 1:length(expelled.counties$geometry)){
  temp <- expelled.counties$geometry[[i]][[1]][[1]] %>% 
    as.data.frame()
  colnames(temp) <- c("lon", "lat")
  temp$county <- expelled.counties$NAME[i]
  temp$state  <- expelled.counties$STUSPS[i]
  
  out.df <- rbind(out.df, 
                  temp)
  
}
out.df
library(data.table)


# palc <- colorFactor(palette = "viridis", 
#                    domain = expelled.counties$desc)

# colorFactor(
#   palette,
#   domain,
#   levels = NULL,
#   ordered = FALSE,
#   na.color = "#808080",
#   alpha = FALSE,
#   reverse = FALSE
# )


leaflet::leaflet() %>%
  addProviderTiles(
    "OpenStreetMap",
    # give the layer a name
    group = "OpenStreetMap"
  ) %>%
  addPolygons(data = expelled.counties, 
              stroke = T,
              fillColor = "blue", 
              fillOpacity = 0.2,
              opacity = 1,
              color = "blue",
              weight = 2, 
              popup = paste(expelled.counties$NAME, " County, ",
                            expelled.counties$STATE_NAME, 
                            sep = "")) %>%
  addPolygons(data = expelled.places, 
              stroke = T,
              fillColor = "blue", 
              fillOpacity = 0.2,
              opacity = 1,
              color = "blue",
              weight = 2, 
              popup = paste(expelled.places$NAME, 
                            expelled.places$STATE_NAME, 
                            sep = ", ")) %>%
  addLegend(position = "bottomright",
            title = "Legend",
            #pal = palc, 
            #colors = "magma", 
            colors = "#03F",
            opacity = 1,
            labels = "Place that once expelled<br>
            entire Black population")


saveRDS(expelled.counties, "shiny_remaining_greenbook_addresses/exp_co.rds")
saveRDS(expelled.places, "shiny_remaining_greenbook_addresses/exp_pl.rds")
