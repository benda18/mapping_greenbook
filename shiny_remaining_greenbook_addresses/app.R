#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(leaflet)
# library(readxl)
# library(xlsx)
#library(rsconnect)
library(qrcode)
library(jpeg)
library(ggplot2)
library(sf)
library(leaflegend)

 renv::snapshot()
 renv::status()
 #renv::record("renv@1.0.9")
 
sb.wid <- 3
mp.wid <- 12-sb.wid



# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Green Book Address Locations"),
  
  # Sidebar 
  sidebarLayout(
    sidebarPanel(width = sb.wid,
      # shiny::radioButtons(inputId = "legend.sel", 
      #                    label = "Sundown Towns", 
      #                    choices = c("Display Possible Sundown Towns" = "yes",
      #                                "Do Not Display Possible Sundown Towns" = "no"), 
      #                    selected = "no"),
     fluidRow(img(src="sometime1947.jpg", 
                   width = "300pt")),
      shiny::plotOutput(outputId = "qr_url", 
                        height = "200px")
    ),
    
    
    mainPanel(width = mp.wid,
      leaflet::leafletOutput(outputId = "leaf_map", 
                             width = "auto", 
                             height = "600px"), 
      wellPanel(
        fluidRow("Source Code: https://github.com/benda18/mapping_greenbook/blob/main/shiny_remaining_greenbook_addresses/app.R"), 
        fluidRow("Download Data: https://github.com/benda18/mapping_greenbook/raw/main/data/greenbook_addresses.xlsx")
      )
    )
  )
)

# Define server logic 
server <- function(input, output) {
  
   output$leaf_map <- leaflet::renderLeaflet({
    
    gba <- readRDS(file = "greenbook_addresses.rds")
    expelled.counties <- readRDS(file = "exp_co.rds")
    expelled.places   <- readRDS(file = "exp_pl.rds")
    
    sundown.co        <- readRDS(file = "sd_co.rds")
    sundown.pl        <- readRDS(file = "sd_pl.rds")
    
    gba$decade[gba$decade != "unknown"] <- paste("Decade of Publication: ", 
                                                 gba$decade[gba$decade != "unknown"], 
                                                 sep = " ")
    gba$decade[gba$decade == "unknown"] <- "Decade(s) of Publication Unknown"
    
    gba$marker_text <- paste(gba$decade, "//", gba$Type)
    
    
    leaf.out <- leaflet() %>%
      # add different provider tiles
      # addProviderTiles(
      #   "CartoDB.Positron",
      #   group = "CartoDB.Positron"
      # ) %>%
      addProviderTiles(
        "OpenStreetMap",
        # give the layer a name
        group = "OpenStreetMap"
      ) %>%
      # addProviderTiles(
      #   "Esri.WorldStreetMap",
      #   group = "Esri.WorldStreetMap"
      # ) %>%
      addProviderTiles(
        "Esri.WorldImagery",
        group = "Esri.WorldImagery"
      ) %>%
      addLegend(position = "bottomleft",
                title = "Legend",
                #pal = palc, 
                #colors = "magma", 
                colors = c("#03F", "brown"),
                opacity = 1,
                labels = c("Place that once expelled<br>
            entire Black population", 
                           "Possible Sundown Town")) %>%
      # add a layers control
      addLayersControl(
        baseGroups = c(
          #"CartoDB.Positron",
          "OpenStreetMap",
          #"Esri.WorldStreetMap",
          "Esri.WorldImagery"
        ),
        overlayGroups = c("Potential Sundown Towns", 
                          "Place that once expelled<br>
            entire Black population", 
                          "Green Book Addresses"),
        # position it on the topleft
        position = "bottomleft",
        options = layersControlOptions(collapsed = F)
      ) 
    
    #if("yes" %in% input$legend.sel){
      leaf.out <- leaf.out %>%
        addPolygons(data = sundown.co, 
                    group = "Potential Sundown Towns",
                    stroke = T,
                    fillColor = "brown", 
                    fillOpacity = 0.33,
                    opacity = 0.33,
                    color = "brown",
                    weight = NA, 
                    popup = paste(sundown.co$NAME, " County, ",
                                  sundown.co$STATE_NAME, 
                                  sep = "")) %>%
        addPolygons(data = sundown.pl, 
                    group = "Potential Sundown Towns",
                    stroke = T,
                    fillColor = "brown", 
                    fillOpacity = 0.33,
                    opacity = 0.33,
                    color = "brown",
                    weight = NA, 
                    popup = paste(sundown.pl$NAME, 
                                  sundown.pl$STATE_NAME, 
                                  sep = ", "))
    #}
    
    #if(T){
      leaf.out <- leaf.out %>%
        addPolygons(data = expelled.counties, 
                    group = "Place that once expelled<br>
            entire Black population",
                    stroke = T,
                    fillColor = "blue", 
                    fillOpacity = 0.33,
                    opacity = 0.33,
                    color = "blue",
                    weight = NA, 
                    popup = paste(expelled.counties$NAME, " County, ",
                                  expelled.counties$STATE_NAME, 
                                  sep = "")) %>%
        addPolygons(data = expelled.places, 
                    group = "Place that once expelled<br>
            entire Black population",
                    stroke = T,
                    fillColor = "blue", 
                    fillOpacity = 0.33,
                    opacity = 0.33,
                    color = "blue",
                    weight = NA, 
                    popup = paste(expelled.places$NAME, 
                                  expelled.places$STATE_NAME, 
                                  sep = ", "))
    #}
      
    
      
    #if(T){
      leaf.out <- leaf.out %>%
        # addMarkers(data = gba,
        #            icon = icons(iconUrl = symbols),
        #            lat = ~cen_lat, lng = ~cen_lon) %>%
        # addLegendSize(values = 8,
        #               pal = numPal,
        #               title = 'Depth',
        #               labelStyle = 'margin: auto;',
        #               shape = c('triangle'),
        #               #orientation = c('vertical', 'horizontal'),
        #               opacity = .7,
        #               breaks = 5) 
      
      
      addMarkers(lng = gba$cen_lon,#[gba$decade == input$year_sel.rb,]$cen_lon,
                 lat = gba$cen_lat,#[gba$decade == input$year_sel.rb,]$cen_lat,
                 #popup = "popup_foo",
                 group = "Green Book Addresses",
                 label = gba$marker_text,#[gba$decade == input$year_sel.rb,]$Type,
                 labelOptions = labelOptions(
                   interactive = FALSE,
                   clickable = NULL,
                   noHide = NULL,
                   permanent = FALSE,
                   direction = "auto",
                   offset = c(0, 0),
                   opacity = 1,
                   textsize = "15px",
                   textOnly = F,
                   style = NULL,
                   sticky = T,
                 ),
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
    #}
      
      leaf.out
      
  })
  
  output$qr_url <- renderPlot({
    qr_app <- qrcode::qr_code(x = "https://tim-bender.shinyapps.io/shiny_remaining_greenbook_addresses/", 
                              ecl = "H")
    qr_app_logo <- add_logo(qr_app, 
                            logo = "www/QRLOGO.jpg")
    plot(qr_app_logo)
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

