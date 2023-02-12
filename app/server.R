#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
###############################Install Related Packages #######################
if (!require("shiny")) {
    install.packages("shiny")
    library(shiny)
}
if (!require("leaflet")) {
    install.packages("leaflet")
    library(leaflet)
}
if (!require("leaflet.extras")) {
    install.packages("leaflet.extras")
    library(leaflet.extras)
}
if (!require("dplyr")) {
    install.packages("dplyr")
    library(dplyr)
}
if (!require("magrittr")) {
    install.packages("magrittr")
    library(magrittr)
}
if (!require("mapview")) {
    install.packages("mapview")
    library(mapview)
}
if (!require("leafsync")) {
    install.packages("leafsync")
    library(leafsync)
}
if (!require("rsconnect")) {
  install.packages("rsconnect")
  library(rsconnect)
}

#host website
# rsconnect::setAccountInfo(name='pro2group4',
#                          token='92BA26D98A047B5E18CD8066A81600CA',
#                          secret='78lDLcwIDL7DvQulMKfnAzqRlGgqErmc/Yc8Mn0h')
# deployApp()


#library(rsconnect)

#rsconnect::deployApp(appDir = "path/to/your/shiny/app")
#deployApp(account= "proj2group4")

#Data Processing
df = read.csv('./data/Queens_Library_Branches.csv')
df <- df[which(!is.na(df$Latitude) & !is.na(df$Longitude)),]
# Check for missing or invalid lat/lon values
df <- df[, c("Latitude", "Longitude")]
# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  # create a point plot with the latitude and longitude columns
output$map <- renderLeaflet({
    leaflet(data = df) %>% 
    addMarkers(lng = df$Longitude, lat = df$Latitude)
  })
  
  
  ## search table output #############################################
output$search_result = DT::renderDataTable({
    read.csv("./data/Queens_Library_Branches.csv")%>%
      select(name,City,Postcode)
  },selection = 'single')

})


