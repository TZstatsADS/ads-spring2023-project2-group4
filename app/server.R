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

if (!require("leafsync")) {
  install.packages("leafsync")
  library(leafsync)
}
if (!require("rsconnect")) {
  install.packages("rsconnect")
  library(rsconnect)
}
if (!require("geojsonio")) {
  install.packages("geojsonio")
  library(geojsonio)
}
if (!require("tidyverse")) {
  install.packages("tidyverse")
  library(tidyverse)
}
if (!require("ggplot2")) {
  install.packages("ggplot2")
  library(ggplot2)
}
if (!require("tidyr")) {
  install.packages("tidyr")
  library(tidyr)
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
#df <- df[which(!is.na(df$Latitude) & !is.na(df$Longitude)),]
# Check for missing or invalid lat/lon values
#df <- df[, c("Latitude", "Longitude")]
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  ######################. map  by days################################  
  queensLat <- 40.742054
  queensLon <- -73.769417
  usaZoom <- 10.4
  
  
  
  filtered = reactive({
    if (input$Day=="Monday"){
      return (subset(df,grepl("Closed",df[,"Mn"])==FALSE))}
    if (input$Day=="Tuesday"){
      return (subset(df,grepl("Closed",df[,"Tu"])==FALSE))}
    if (input$Day=="Wednesday"){
      return (subset(df,grepl("Closed",df[,"We"])==FALSE))}
    if (input$Day=="Thursday"){
      return (subset(df,grepl("Closed",df[,"Th"])==FALSE))}
    if (input$Day=="Friday"){
      return (subset(df,grepl("Closed",df[,"Fr"])==FALSE))}
    if (input$Day=="Saturday"){
      return (subset(df,grepl("Closed",df[,"Sa"])==FALSE))}
    if (input$Day=="Sunday"){
      return (subset(df,grepl("Closed",df[,"Su"])==FALSE))}
  })
  
  icons <- awesomeIcons(
    icon = 'ios-close',
    iconColor = 'white',
    library = 'ion',
    markerColor = "blue"
  )
  
  ####### map ##############################################################
  
  output$map = renderLeaflet(
    
    leaflet() %>%
      setView(lat = queensLat, lng = queensLon, zoom = usaZoom) %>%
      addTiles(urlTemplate = 'http://mt0.google.com/vt/lyrs=m&hl=en&x={x}&y={y}&z={z}&s=Ga', attribution = 'Google') %>% 
      addMarkers(data=filtered(), ~Longitude, ~Latitude, icon = icons,
                 popup = paste("Name: ", df$name, "<br>",
                               "Address: ", df$Address)))
  
  
  ##################################### Map ends ###################################
  
  
  
  
  
  
  
  ##############plot###########
  # ---------------------Search By Location output - by Shiver ------------------------
  df2=read.csv('./data/Queens_Library_Branches.csv')
  output$city_piechart <- renderPlot({
    df2$City <- trimws(df2$City)
    temp <- df2[grepl(input$City, df2$City), ]
    data <- c(temp$Community.Board)
    labels <- c(temp$name)
    pie(data, labels <- labels, main = 'Library popularity by city' ) 
  })
  
  output$zip_piechart <- renderPlot({
    df2$City <- trimws(df2$City)
    temp <- df2[substr(df2$Postcode, 1, 3) == input$Zipcode, ]
    data <- c(temp$Community.Board)
    labels <- c(temp$name)
    pie(data, labels <- labels, main = 'Library popularity by zipcode' )
  })
  
  
  # ---------------------Search By day output - by Jingshu ------------------------
  output$distPlot <- renderPlot({
    
    data = read.csv("./data/Queens_Library_Branches.csv")
    
    data_cleaned = data[which(!is.na(data$Latitude) & !is.na(data$Longitude)),] 
    
    cleaned_data = data_cleaned %>%
      rename('Monday' = 'Mn', 'Tuesday' = 'Tu', 'Wednesday' = 'We', 'Thursday' = 'Th', 'Friday' = 'Fr', 'Saturday' = 'Sa', 'Sunday' = 'Su') %>%
      gather("Day", "Time", 6:12) %>%
      filter(Day == input$mmm)
    
    ggplot(cleaned_data, aes(x = Time, fill = factor(Time))) +
      geom_bar(stat = "count") +
      xlab("Time Slot") +
      ylab("Number of Available Libraries") + scale_x_discrete(guide = guide_axis(angle = 45))+
      ggtitle("Library Availablity across Day") +
      theme(legend.position = "none")
  }) #renderPlot closes
  
  
  
  
  
  
  
  
  
  
  
  
  
  ##################
  
  ########### popularity map   #############
  neighbor <- geojsonio::geojson_read("https://data.beta.nyc/dataset/0ff93d2d-90ba-457c-9f7e-39e47bf2ac5f/resource/35dd04fb-81b3-479b-a074-a27a37888ce7/download/d085e2f8d0b54d4590b1e7d1f35594c1pediacitiesnycneighborhoods.geojson", what = "sp")
  bins <- c(0,2,4,6,8,10,12, Inf)
  pal <- colorBin("YlOrRd", domain = df$Community.Board, bins = bins)
  labels <- sprintf("<strong>%s</strong><br/>%g Community Boards", neighbor$neighborhood, rep(df$Community.Board, length.out = length(neighbor$neighborhood)))%>%lapply(htmltools::HTML)
  output$m = renderLeaflet(leaflet(neighbor) %>%
                             setView(lat = queensLat, lng = queensLon, zoom = usaZoom) %>%
                             addTiles(urlTemplate = 'http://mt0.google.com/vt/lyrs=m&hl=en&x={x}&y={y}&z={z}&s=Ga', attribution = 'Google') %>%
                             addProviderTiles("MapBox", options = providerTileOptions(
                               id = "mapbox.light",
                               accessToken = Sys.getenv('MAPBOX_ACCESS_TOKEN'))) %>%
                             addPolygons(
                               fillColor = ~pal(df$Community.Board),
                               weight = 2,
                               opacity = 1,
                               color = "white",
                               dashArray = "3",
                               fillOpacity = 0.7,
                               highlightOptions = highlightOptions(
                                 weight = 5,
                                 color = "#999",
                                 dashArray = "",
                                 fillOpacity = 0.7,
                                 bringToFront = TRUE),
                               label = labels,
                               labelOptions = labelOptions(
                                 style = list("font-weight" = "normal", padding = "3px 8px"),
                                 textsize = "15px",
                                 direction = "auto")) %>% 
                             addLegend(pal = pal, values = ~df$Community.Board, opacity = 0.7, title = "Number of Community Board",
                                       position = "topright"))
  
#####################  
  
 
  
  
  
  #####
  
  ## search table output #############################################
  output$search_result = DT::renderDataTable({
    read.csv("./data/Queens_Library_Branches.csv")%>%
      select(name,City,Postcode)
  },selection = 'single')
  
})
  


