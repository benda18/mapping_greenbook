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

sb.wid <- 3
mp.wid <- 12-sb.wid

gba <- readRDS(file = "greenbook_addresses.rds")
# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Remaining Green Book Addresses that Geocode in 2024"),
  
  # Sidebar 
  sidebarLayout(
    sidebarPanel(width = sb.wid,
      # shiny::textInput(inputId = "year_sel.ti", 
      #                     label = "Filter by GreenBook Edition", 
      #                     value = c(1938, 1947, 1954, 1963)), 
      # shiny::selectInput(inputId = "year_sel.si", 
      #                    label = "Filter by GreenBook Edition", 
      #                    choices = c(1938, 1947, 1954, 1963), 
      #                    selected = c(1938, 1947, 1954, 1963), 
      #                    multiple = T), 
      shiny::radioButtons(inputId = "year_sel.rb", 
                          label = "Filter by Decade of Publication",
                          choices = c("1930s (dataset in progress)" = "1930s", 
                                      "1940s (dataset in progress)" = "1940s", 
                                      "1950s (dataset in progress)" = "1950s", 
                                      "1960s (dataset in progress)" = "1960s"), 
                          selected = "1930s"), 
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
    
    #gba <- read_xlsx("greenbook_addresses.xlsx")
    
    
    leaflet() %>%
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
          "Esri.WorldStreetMap",
          "CartoDB.Positron",
          "OpenStreetMap",
          "Esri.WorldImagery"
        ),
        # position it on the topleft
        position = "topleft"
      ) %>%
      addMarkers(lng = gba[gba$decade == input$year_sel.rb,]$cen_lon, 
                 lat = gba[gba$decade == input$year_sel.rb,]$cen_lat, 
                 #popup = "popup_foo", 
                 label = gba[gba$decade == input$year_sel.rb,]$Type,
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

