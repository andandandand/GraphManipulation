

library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Delete elements from graph"),
  
  sidebarLayout(
    sidebarPanel(
      
      fileInput(inputId = "file",
                label = "Choose a CSV file",
                accept = c('text/comma-separated-values',
                           'text/plain',
                           'text/csv',
                           '.csv')),
      
      radioButtons("elementsToDelete", 
                   "Elements to delete",
                   choices =c("vertices", "edges"),
                   selected = "vertices"),

       #these values are ignored and get updated in the server
       sliderInput("numberOfElementsToDelete",
                   "Number of elements to delete",
                   min = 1,
                   max = 5,
                   value = 5),
      
      actionButton(inputId="updateGraphButton", 
                   label="Update original graph")
       
       
    ),
    
    mainPanel(
      
      fluidRow(
        
        column(width = 6,
               HTML('<center><h3>Original graph</h3></center>'),
               plotOutput("originalGraphPlot")),
       
        column(width = 6,
               HTML('<center><h3>Reduced graph</h3></center>'),
               plotOutput("reducedGraphPlot"))
      )
    )
  )
))
