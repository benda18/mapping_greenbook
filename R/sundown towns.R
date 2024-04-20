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


jus.in <- read_lines("Advance
Albany
Albion
Alexandria
Andrews
Arcadia
Argos
Attica
Auburn
Aurora
Austin
Avilla
Batesville
Bedford
Beech Grove
Berne
Bicknell
Bloomfield
Bluffton
Boswell
Bourbon
Bremen
Brook
Brooklyn
Brookston
Brookville
Brownsburg
Brownstown
Burnettsville
Butler City
Cambridge City
Camden
Campbellsburg
Cannelton
Carmel
Cayuga
Cedar Lake
Centerville
Chandler
Chesterfield
Chesterton
Churubusco
Cicero
Clarksville
Clay City
Columbia City
Converse
Corydon
Covington
Crawford
Crothersville
Crown Point
Dale
Daleville
Danville
Decatur
Delphi
Deputy
Dillsboro
Dublin
Dugger
Dyer
East Gary
Eaton
Ellettsville
Elnora
Elwood
English
Fairmount
Fairview Park
Farmersburg
Farmland
Ferdinand
Flora
Fort Branch
Fortville
Francesville
Frankfort
Frankton
Fremont
Fulton County
Galena
Gas City
General
Geneva
Goodland
Goshen
Grand View
Greendale
Greenfield
Greensburg
Greentown
Greenwood
Hagerstown
Hancock County
Hartford City
Haubstadt
Hebron
Henryville
Highland
Hobart
Hope
Howard County
Huntingburg
Huntington
Hymera
Jamestown
Jasonville
Jasper
Jonesboro
Kendallville
Kentland
Knox
Kouts
Ladoga
LaGrange
Lagro
Lapel
Laurel
Leavenworth
Lexington
Ligonier
Linton
Lizton
Long Beach
Loogootee
Lowell
Lynn
Marengo
Martinsville
Mentone
Merrillville
Middlebury
Middletown
Milan
Milltown
Milton
Mishawaka
Mitchell
Monon
Monroeville
Montezuma
Monticello
Montpelier
Mooresville
Morgantown
Morocco
Morristown
Mulberry
Munster
Nappanee
New Carlisle
New Chicago
New Harmony
New Haven
New Palestine
New Paris
New Pekin
New Whiteland
Newburg
North Judson
North Liberty
North Manchester
North Webster
Odon
Ogden Dunes
Oolitic
Orleans
Osceola
Osgood
Ossian
Owensville
Oxford
Parker City
Pendleton
Perry County
Petersburg
Pierceton
Plymouth
Porter
Poseyville
Redkey
Remington
Rensselaer
Ridgeville
Roachdale
Roann
Roanoke
Rochester
Rockport
Rome City
Rossville
Royal Center
Russiaville
Salem
Schererville
Scottsburg
Seelyville
Sellersburg
Shelburn
Shirley
Shoals
Sidney
Silver Lake
South Whitley
Speedway
St. John
Stinesville
Summitville
Sunman
Swayzee
Sweetser
Syracuse
Tell City
Thorntown
Tipton
Trail Creek
Tri-Lakes
Utica
Valparaiso
Van Buren
Veedersburg
Versailles
Vevay
Wabash
Wakarusa
Walkerton
Walton
Warren
Waterloo
West Lafayette
West Terre Haute
Westfield
Whiteland
Whitestown
Whiting
Williamsport
Winamac
Windfall City
Winslow
Wolcott
Woodburn
Worthington
Yorktown
Zionsville
") %>% paste(., ", Indiana", sep = "")

jus.ar <- read_lines("Alix
Altus
Amity
Ash Flat
Bauxite
Baxter County
Black Rock
Bonanza
Booneville
Bradford
Brookland
Cabot
Calico Rock
Cammack Village
Clay County
Cleburne County
Cotter
Crawford County
Decatur
Delight
Desha
Diamond City
Dierks
Dover
Dyer
Dyess
Elkins
Elm Springs
Etowah
Eureka Springs
Evening Shade
Fairfield Bay
Fouke
Gentry
Glenwood
Goshen
Grannis
Gravette
Greenway
Greenwood
Greers Ferry
Grubbs
Hardy
Harrison
Hillcrest
Imboden
Johnson
Kibler
Lacrosse
Lamar
Lavaca
Leachville
Leslie
Little Flock
London
Magazine
Magnet Cove
Manila
Marion County
Marshall
Mena
Mount Ida
Mountain Home
Mountain View
Mt. Ida
Mulberry
Newton County
Oak Grove Heights
Oakland
Oppelo
Oxford
Ozark
Pangburn
Paragould
Perryville
Piggott
Portia
Pottsville
Provo
Quitman
Rogers
Scott County
Sheridan
Siloam Springs
Springdale
St. Francis
Stone County
Subiaco
Sulphur Springs
Taylor
Van Buren
Waldron
Wickes
Williford
")  %>% paste(., ", Arkansas", sep = "")
jus.ok <- read_lines("Allen
Alva
Apache
Arkoma
Barnsdall
Bixby
Blackwell
Blair
Boise City
Broken Arrow
Caddo
Carnegie
Cherokee
Cleveland
Collinsville
Colony
Comanche
Commerce
Durant
Edmond
Erick
Fox
General
Gore
Greer County
Grove
Haileyville
Healdton
Henryetta
Hinton
Hooker
Jenks
Lawton
Lexington
Lindsay
Madill
Marlow
Marshall
Medford
Moore
Morris
Noble
Norman
Okeene
Okemah
Ottawa County
Paden
Picher
Purcell
Sapulpa
Skiatook
Stilwell
Stroud
Taft
Tecumseh
Tioga
Walters
Welch
")  %>% paste(., ", Oklahoma", sep = "")
jus.tx <- read_lines("Alamo
Alba
Archer City
Armstrong County
Aubrey
Benavides
Bevil Oaks
Big Spring
Boerne
Bowie
Briscoe County
Brownsville
Canadian
Canyon
Carson County
Castro County
Childress County
Collingsworth County
Comanche
Comanche County
Copperas Cove
Cotulla
Cumby
Cut and Shoot
Dalhart
Dallam County
De Leon
Deaf Smith
Deaf Smith County
Donley County
Donna
Dumas
Edcouch
Evadale
Everman
Fremont
Glen Rose
Goldthwaite
Grand Saline
Gray County
Hall County
Hamilton
Hamilton County
Hansford County
Hartley County
Hemphill County
Hereford
Hico
Highland Park
Highlands
Hillcrest
Holliday
Hutchinson County
Iowa Park
Irving
Jacinto City
Killeen
Kirvin
Lake Jackson
Lakeview
Lipscomb County
Lumberton
Montague County
Moore County
Moulton
Nederland
Nocona
Oak Knoll
Ochiltree County
Oldham County
Orange
Paradise
Parmer County
Pasadena
Perryton
Perryton
Pharr
Phillips
Pinewood Estates
Port Neches
Porter Heights
Potter County
Randall County
Rio Grande City
River Oaks
Robert Lee
Roberts County
San Diego
San Juan
Santa Fe
Scurry County
Shamrock
Sherman County
Slocum
Spearman
Stinnett
Sunnyvale
Swisher County
Throckmorton
Throckmorton County
Tioga
Vidor
West Orange
Wheeler County
White Deer
White Settlement
Whitesboro
Winnie
")  %>% paste(., ", Texas", sep = "")
jus.tn <- read_lines("Baxter
Celina
Cookeville
Copperhill
Crossville
Ducktown
Dunlap
East Ridge
Englewood
Erwin
Fairview
Gatlinburg
General
Greenbrier
Jamestown
Lafayette
Lenoir City
Monterey
Norris
North Chattanooga
Oneida
Palmer
Signal Mountain
Soddy-Daisy
Teste
Tracy City
Waynesboro
")  %>% paste(., ", Tennessee", sep = "")
jus.ky <- read_lines("Albany
Alexandria
Audubon Park
Beechwood Village
Bellevue
Benton
Brodhead
Bromley
Burnside
Calvert City
Caneyville
Catlettsburg
Centertown
Clay
Cold Spring
Corbin
Dayton
Edgewood
Elkhorn City
Erlanger
Florence
Fort Mitchell
Fort Thomas
Highland Heights
Irvine
Jeffersonville
Liberty
Livermore
London
Loyall
Ludlow
Lynnview
Marshall County
Martin
Meadow Vale
Minor Lane Heights
Mount Vernon
Mount Washington
North Corbin
Olive Hill
Paintsville
Park Hills
Parkway Village
Petersburg
Pompeii
Prestonsburg
Raceland
Russell
Russell Springs
Salyersville
Shively
Silver Grove
Southgate
St. Regis Park
Stanton
Van Lear
Vanceburg
Whitesburg
Williamstown
Windy Hills
Worthington
")  %>% paste(., ", Kentucky", sep = "")

jus.ms <- read_lines("Baxterville
Belmont
Burnsville
Clinton
d’Iberville
General
It
Mize
Pearl
Southaven
") %>% paste(., ", Mississippi", sep = "")

jus.la <- read_lines("Anacoco
Golden Meadow
Grand Isle
Jean Lafitte
Krotz Springs
Pitkin
Pollock
Simpson
") %>% paste(., ", Louisiana", sep = "")

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
") %>% paste(., ", Alabama", sep = "")

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
               jus.ga, 
               jus.ar, 
               jus.tn, 
               jus.ky, 
               jus.ok, 
               jus.tx, 
               jus.in, 
               jus.ms, jus.la),]
sundown.pl <- sundown.pl[paste(sundown.pl$NAME, ", ", 
                               sundown.pl$STATE_NAME, sep = "") %in% 
                           c(jus.nc, 
                             jus.sc, 
                             jus.al, 
                             jus.fl, 
                             jus.ga, 
                             jus.ar, 
                             jus.tn, 
                             jus.ky, 
                             jus.ok, 
                             jus.tx, 
                             jus.in, 
                             jus.ms, 
                             jus.la),]


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
