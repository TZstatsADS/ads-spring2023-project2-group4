
if (!require("shiny")) {
  install.packages("shiny")
  library(shiny)
}
if (!require("shinyWidgets")) {
  install.packages("shinyWidgets")
  library(shinyWidgets)
}
if (!require("shinythemes")) {
  install.packages("shinythemes")
  library(shinythemes)
}
if (!require("leaflet")) {
  install.packages("leaflet")
  library(leaflet)
}
if (!require("leaflet.extras")) {
  install.packages("leaflet.extras")
  library(leaflet.extras)
}

# Define UI for application that draws a histogram
shinyUI(
    navbarPage(strong("LibGo",style="color: white;"), 
               theme=shinytheme("cosmo"), # select your themes https://rstudio.github.io/shinythemes/
               
               tabPanel("Introduction",
                        tags$img(
                          src = "https://live.staticflickr.com/5151/5914733818_983804b390_b.jpg",
                          width = "100%",
                          style = "opacity: 0.90"
                        ),
                        fluidRow(
                          absolutePanel(
                            style = "background-color: rgba(0, 0, 0, .3)",
                            top = "40%",
                            left = "25%",
                            right = "25%",
                            height = 270,
                            tags$p(
                              style = "padding: 5%; background-color: rgba(0, 0, 0, .3);font-family: alegreya; font-size: 220%; color: White; text-align: center",
                              "LibGo"
                            ),
                            tags$p(
                              style = "color: White", 
                              "a brief introduction"
                            )
                          )
                        )
               ), # tabPanel closing 
#------------------------------- tab panel - Maps ---------------------------------
                tabPanel("Maps",
                         leafletOutput("map", width="100%", height="100%"),
                        ), #tabPanel maps closing

                  tabPanel("Search by category",
                           sidebarPanel(
                             selectInput(inputId = "Day", 
                                          label = "Choose by day:", 
                                         choices = c("Monday", "Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday")),
                             selectInput(inputId = "Borough",
                                           label = "Choose by borough:",
                                           choices = c("Manhattan", "Bronx", "Brooklyn", "Queens", "Staten Island")),
                               
                            selectInput(inputId = "Accessibility",
                                           label = "Choose by accessibility:",
                                           choices = c("fully access", "partially access"))
                               
                             )
                           
                  ), # tabPanel closing 

tabPanel("Search", icon = icon("table"), 
         tags$style(HTML("
                    .dataTables_filter input {
                            color: black;
                            background-color: black;
                           }

                    thead {
                    color: black;
                    }

                     tbody {
                    color: black;
                    }

                   "
         )),
         
         DT::dataTableOutput("search_result")), 

#https://shiny.rstudio.com/articles/datatables.html


      tabPanel("Reference",
                     
                  ) # tabPanel closing 

  
    ) #navbarPage closing  
) #Shiny UI closing    
