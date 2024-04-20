# sundown towns

library(dplyr)
library(tigris)
library(ggplot2)
library(leaflet)
library(renv)
library(tidycensus)
library(leaflet)
library(sf)
library(readr)

#renv::snapshot()

# https://justice.tougaloo.edu/sundown-towns/using-the-sundown-towns-database/state-map/

rm(list=ls());cat('\f')

jus.al <- read_lines("Arab
Chickasaw
Cullman
Cullman County
Dixie
Fyffe
Good Hope
Hanceville
Hokes Bluff
Nauvoo
Oneonta
Orange Beach
Sand Mountain
Vestavia Hills
West Point
Winston County
")%>% paste(., ", Alabama", sep = "")

jus.fl <- read_lines("Altha
Cedar Key
Coral Gables
Daytona Beach Shores
Delray Beach
Elfers
Flagler Beach
Gulfport
Holmes Beach
Longboat Key
Melbourne Beach
Miami Beach
Myakka City
Ocoee
Old Homosassa
Palm Beach
Samsula
Southport
St. Cloud
Venice
Winterhaven
Yankeetown
") %>% paste(., ", Florida", sep = "")

jus.ga <- read_lines("Avondale Estates
Banks County
Blairsville
Blue Ridge
Chamblee
Clayton
Dahlonega
Dawson County
Forsyth County
Gilmer County
Murray County
Palmetto
Pickens County
Rabun County
Thomas County
Towns County
Tybee Island
Union County
Watkinsville") %>%
  paste(., ", Georgia", sep = "")

jus.sc <- read_lines("Ellenton
Folly Beach
Georgetown
Hamburg
Isle of Palms
Moncks Corner
Princeton
Salem
Shandon
") %>%
  paste(., ", South Carolina", sep = "")

jus.nc <- readr::read_lines("Bakersville
Brasstown
Faith
Graham County
Hot Springs
King
Kure Beach
Mayodan
Mitchell County
Rosman
Southern Shores
Spruce Pine
Surf City
Swain County
Trent Woods
Wrightsville Beach") %>%
  paste(., ", North Carolina", sep = "")


sundown.co <- tigris::counties(cb = T) %>%
  mutate(., 
         desc = "Possible Sundown Town")
sundown.pl <- tigris::places(cb = T) %>%
  mutate(., 
         desc = "Possible Sundown Town")

ls(pattern = "jus")
sundown.co <- sundown.co[paste(sundown.co$NAMELSAD, ", ", 
                 sundown.co$STATE_NAME, sep = "") %in% 
             c(jus.nc, 
               jus.sc, 
               jus.al, 
               jus.fl, 
               jus.ga),]
sundown.pl <- sundown.pl[paste(sundown.pl$NAME, ", ", 
                               sundown.pl$STATE_NAME, sep = "") %in% 
                           c(jus.nc, 
                             jus.sc, 
                             jus.al, 
                             jus.fl, 
                             jus.ga),]


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
  addPolygons(data = sundown.co, 
              stroke = T,
              fillColor = "brown", 
              fillOpacity = 0.2,
              opacity = 1,
              color = "brown",
              weight = 2, 
              popup = paste(sundown.co$NAME, " County, ",
                            sundown.co$STATE_NAME, 
                            sep = "")) %>%
  addPolygons(data = sundown.pl, 
              stroke = T,
              fillColor = "brown", 
              fillOpacity = 0.2,
              opacity = 1,
              color = "brown",
              weight = 2, 
              popup = paste(sundown.pl$NAME, 
                            sundown.pl$STATE_NAME, 
                            sep = ", ")) %>%
  addLegend(position = "bottomright",
            title = "Legend",
            #pal = palc, 
            #colors = "magma", 
            colors = c("#03F", "brown"),
            opacity = 1,
            labels = c("Place that once expelled<br>
            entire Black population", 
                       "Possible Sundown Town"))


saveRDS(expelled.counties, "shiny_remaining_greenbook_addresses/exp_co.rds")
saveRDS(expelled.places, "shiny_remaining_greenbook_addresses/exp_pl.rds")

saveRDS(sundown.co, "shiny_remaining_greenbook_addresses/sd_co.rds")
saveRDS(sundown.pl, "shiny_remaining_greenbook_addresses/sd_pl.rds")
