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
library(readxl)
library(xlsx)
#library(rsconnect)
library(qrcode)
library(jpeg)


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Remaining GreenBook Addresses that Still Geocode in 2024"),
  
  # Sidebar 
  sidebarLayout(
    sidebarPanel(
      # shiny::textInput(inputId = "year_sel.ti", 
      #                     label = "Filter by GreenBook Edition", 
      #                     value = c(1938, 1947, 1954, 1963)), 
      # shiny::selectInput(inputId = "year_sel.si", 
      #                    label = "Filter by GreenBook Edition", 
      #                    choices = c(1938, 1947, 1954, 1963), 
      #                    selected = c(1938, 1947, 1954, 1963), 
      #                    multiple = T), 
      shiny::radioButtons(inputId = "year_sel.rb", 
                          label = "Filter by GreenBook Edition",
                          choices = c(1938, 1947, 1954, 1963), 
                          selected = 1938), 
      shiny::plotOutput(outputId = "qr_url", 
                        height = "200px")
    ),
    
    
    mainPanel(
      leaflet::leafletOutput(outputId = "leaf_map", 
                             width = "auto", 
                             height = "600px"), 
      wellPanel(
        fluidRow("Source Code: https://github.com/benda18/mapping_greenbook/blob/main/shiny_remaining_greenbook_addresses/app.R")
      )
    )
  )
)

# Define server logic 
server <- function(input, output) {
  
  
  output$leaf_map <- leaflet::renderLeaflet({
    
    gba <- read_xlsx("greenbook_addresses.xlsx")
    
    
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
          "CartoDB.Positron",
          "OpenStreetMap",
          "Esri.WorldStreetMap",
          "Esri.WorldImagery"
        ),
        # position it on the topleft
        position = "topleft"
      ) %>%
      addMarkers(lng = gba[!duplicated(gba$Address) & 
                             gba$greenbook_edition == input$year_sel.rb,]$cen_lon, 
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