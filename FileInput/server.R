library(shiny)
library(dplyr)

shinyServer(function(input, output) {
  
  # first tab plot - just a basic ggplot of the base data set  
  output$baseplot <- renderPlot({
    
    print(ggplot(base, aes(Price,Quantity)) + geom_point())
  
  })

  # Second tab contents of csv  
  output$csvfiltered <- renderPlot({
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    fcsv <- read.csv(inFile$datapath, header = input$header)
    df.filtered <- base %>%
      filter(OrderId %in% fcsv$OrderId)
    
    print(ggplot(df.filtered, aes(Price,Quantity)) + geom_point())
    
  })
  
  # tab 3 - combine the plots - csv are red 
  output$highlight <- renderPlot({
    
    inFile <- input$file1

    if (is.null(inFile))
      return(NULL)

    fcsv <- read.csv(inFile$datapath, header = input$header)
    df.filtered <- base %>%
      filter(OrderId %in% fcsv$OrderId)
    
    print(ggplot(base, aes(Price,Quantity)) + geom_point() + geom_point(data = df.filtered, col = 'red'))
    
  })
  
})