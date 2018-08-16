

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
                          max = vcount(react_graph$g))
      
    }
    
    if(input$elementsToDelete == "edges"){
      
      updateSliderInput(session,
                        "numberOfElementsToDelete",
                        max = ecount(react_graph$g))
      
    }
    
  })
  
  
  output$originalGraphPlot <- renderPlot({
    
    plot(react_graph$g, edge.width = 2, edge.color = "Firebrick1",
         vertex.color = "Lightblue2", vertex.size = 25, 
         vertex.label.family = "Arial Black" )
      
  })
  
  output$reducedGraphPlot <- renderPlot({
    
    plot(react_graph$g, edge.width = 2, edge.color = "Firebrick1",
         vertex.color = "Lightblue2", vertex.size = 25, 
         vertex.label.family = "Arial Black" )
    
  })
  
  
})
