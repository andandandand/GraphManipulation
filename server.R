

library(shiny)
library(igraph)


loadGraph <- function(dataPath) {
  
  loadedDF <- read.csv(dataPath,
                       header=FALSE,
                       sep=',', #separate by comma
                       quote="'", # quote by '
                       stringsAsFactors = FALSE,
                       check.names = FALSE)
  
  #selects numeric values, drops the rest
  loadedDF <- loadedDF[sapply(loadedDF, is.numeric)]
  
  rownames(loadedDF) <- colnames(loadedDF)
  loadedMat <- as.matrix(loadedDF)
  
  g <- graph_from_adjacency_matrix(loadedMat) %>%
    set_vertex_attr("label", value = rownames(loadedDF) )
  
  
  return(g)
}


shinyServer(function(input, output, session) {
   
  g <- make_star(10, mode = "undirected")
  
  #todo: change
  g_reduced <- g
  
  react_graph <- reactiveValues(g = g, g_reduced = g_reduced)
  
  ##### Update number of elements to delete
  observeEvent(input$elementsToDelete, {
    
    if(input$elementsToDelete == "vertices"){
    
        updateSliderInput(session,
                          "numberOfElementsToDelete",
                          max = vcount(react_graph$g),
                          value =  1)
      
    }
    
    if(input$elementsToDelete == "edges"){
      
      updateSliderInput(session,
                        "numberOfElementsToDelete",
                        max = ecount(react_graph$g),
                        value = 1)
      
    }
    
  })
  
  ### delete elements
  observeEvent(input$numberOfElementsToDelete, {
    
    if(input$elementsToDelete == "vertices"){
     
      print("delete vertices")
      
    }
    
    if(input$elementsToDelete == "edges"){
      
     print("delete edges")
      
    }
    
    
  })
  
  
  
  observeEvent(input$file, {
    
    in_file <- input$file
    
    if(is.null(in_file$datapath)){} 
    else {
      react_graph$g <- loadGraph(in_file$datapath)
      react_graph$g_reduced <- react_graph$g
      }
    
  }, ignoreInit = FALSE) 
  
  
  output$originalGraphPlot <- renderPlot({
    
    coords <- layout_(react_graph$g, as_star())
    
    plot(react_graph$g, layout=coords, edge.width = 2, edge.color = "Firebrick1",
         vertex.color = "Lightblue2", vertex.size = 25, 
         vertex.label.family = "Arial Black" )
      
  })
  
  output$reducedGraphPlot <- renderPlot({
    
    coords <- layout_(react_graph$g_reduced, as_star())
    
    
    plot(react_graph$g_reduced, layout=coords, edge.width = 2,
         edge.color = "Firebrick1",
         vertex.color = "Lightblue2", vertex.size = 25, 
         vertex.label.family = "Arial Black" )
    
  })
  
  
})
