
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
                            style = "padding: 5%; background-color: rgba(0, 0, 0, .3);font-family: alegreya; font-size: 420%; color: White; text-align: center",
                            "LibGo"
                          ),
                          tags$p(
                            style = "padding: 5%; background-color: rgba(0, 0, 0, .3); color: White;font-size: 120%;", 
                            "LibGo is an app developed based on the Queens libraries provided by NYC OpenData. Our goal is to satisfy the needs of those who need to visit the library and provide them with the information they are seeking for. Specifically, this app visualizes the location, operating time and relative popularity data in the greater Queens borough. The user can use either the interactive maps or the search panels to retrieve the required information. "
                          )
                        )
                      )
             ), # tabPanel closing 
             ##########------------------------------- tab panel - Maps By Days ---------------------------------
             tabPanel("Map By Days",
                      sidebarLayout(
                        sidebarPanel(
                          titlePanel("Look up for open libraries"),
                          fluidRow(column(7,
                                          selectInput("Day", label = h2("Select Day"), 
                                                      choices = list("Monday","Tuesday","Wednesday","Thursday","Friday",
                                                                     "Saturday","Sunday")
                                          ))),
                          width = 3),
                        mainPanel(
                          leafletOutput("map"),
                          width = 9
                        ),
                        position = c("left", "right"),
                        fluid = TRUE
                      )
                      
                      
                      
             ), #tabPanel maps closing
             #########################PopularityHeatMap#######          
             
             tabPanel("Map By Popularity",
                      leafletOutput("m", height = "800px")
             ),
             
             
             ##########################--------------------------------------------------------------------
#######plot#########
# ------------------------------- tab panel - Interactive Plot by Location - Shiver ---------------------------------
tabPanel("Interactive Plot By Location",
         sidebarPanel(
           selectInput(inputId = "City",
                       label = "Choose by City:",
                       choices = c( "Jamaica", "Flushing", "Long Island City","Elmhurst","Ozone Park","Corona",
                                    "Hollis","Elmhurst","Rockaway"))
           
         ),
         mainPanel(
           plotOutput('city_piechart')
         ),
         
         sidebarPanel(
           selectInput(inputId = "Zipcode",
                       label = "Choose by first 3 digit of Zipcode:",
                       choices = c( '111','113','114','116'
                       ))
           
         ),
         mainPanel(
           plotOutput('zip_piechart')
         )
         
         
),# tabPanel closing 



# ------------------------------ tab panel - Interactive Plot By Day - Jingshu ------------------------
tabPanel("Interactive Plot By Day",
         
         
         fluidPage(
           # Page title ----
           titlePanel("Library Availability by Day"),
           
           # Sidebar layout with input and output definitions ----
           sidebarLayout(
             position = 'left',
             
             # Sidebar panel for inputs ----
             sidebarPanel(
               
               # Input: Slider for the number of bins ----
               selectInput(inputId = "mmm", 
                           label = "Choose by day:", 
                           choices = c("Monday", "Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"))
               
             ), #sidebarpanel closes
             
             
             
             
             
             # Main panel for displaying outputs ----
             mainPanel(
               
               # Output: Histogram ----
               plotOutput(outputId = "distPlot")
               
               
             ) # MainPanel closes
             
           ) # Sidebarlayout closes
           
           
           
         ) # Fluidpage closes
         
         
         
), # tabPanel closes










########
             
             
             
             
             
             
             
             
             ######Search ########
             
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
                            style = "padding: 5%; background-color: rgba(0, 0, 0, .3); color: White;font-size: 120%;",
                            "Data Source:Queens libraries provided by NY OpenData https://data.cityofnewyork.us/Education/Queens-Library-Branches/kh3d-xhq7 "
                          ),
                          tags$p(
                            style = "padding: 5%; background-color: rgba(0, 0, 0, .3); color: White;font-size: 120%;", 
                            "Acknowledgements: This application is built using the R Shiny App. The following R packages were used: 
shiny  
leaflet 
dplyr 
magrittr 
mapview 
leafsync 
rsconnect 
tidyr
geojson
tidyverse
"
                          ),
                          tags$p(
                            style = "padding: 5%; background-color: rgba(0, 0, 0, .3); color: White;font-size: 120%;", 
                            "Contributors
Liang Hu lh3057@columbia.edu
Kejun Liu kl3434@columbia.edu
Yunfan Liu yl5111@columbia.edu
Han Wang hw2900@columbia.edu
Jingshu Zhang jz3552@columbia.edu
Renqi Zhang rz2600@columbia.edu"

                          )
                        )
                      ),
                      
                      
                      
                      
                      
             ) # tabPanel closing 
             
             
  ) #navbarPage closing  
) #Shiny UI closing    
