

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

       #TODO: update max value dynamically 
       sliderInput("numberOfElementsToDelete",
                   "Number of elements to delete",
                   min = 1,
                   max = 50,
                   value = 30)
       
       
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
