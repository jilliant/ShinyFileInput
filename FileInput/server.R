library(shiny)
library(dplyr)


shinyServer(function(input, output) {
  
  # first tab plot - just a basic ggplot of the base data set  
  output$baseplot <- renderPlot({
    print(ggplot(base, aes(Price,Quantity)) + geom_point())
  })

  # Second tab contents of csv   
  # output$contents <- renderTable({
  # 
  #   inFile <- input$file1
  #   
  #   if (is.null(inFile))
  #     return(NULL)
  #   
  #  fcsv <-  read.csv(inFile$datapath, header = input$header)
  # })
  
  output$csvfiltered <- renderTable({
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    fcsv <- read.csv(inFile$datapath, header = input$header)
    df.filtered <- base %>%
      filter(OrderId %in% fcsv$OrderId)
    df.filtered
  })
  
  # second tab plot - basic ggplot of the uploaded data set
  #output$csvtable <- renderTable(Data()$df.raw)
    # renderPlot({
    # if (is.null(input$file1)) { return() }
    # 
    # df.filtered <- base %>%
    #   filter(OrderId %in% df.raw$OrderId)
    # 
    # str(df.filtered)
    # print(ggplot(df.filtered, aes(Price,Quantity)) + geom_point())
    
 # })
  
  output$sexDiff <- renderPrint({
    if (is.null(input$file1)) { return() }
    df.gender<- subset(Data()$df.melt,Term!="Av")
    aov.by.gender <- aov(Mark ~ Gender, data=df.gender)
    summary(aov.by.gender) 
  })
  
  output$caption1 <- renderText( {
    if (is.null(input$file1)) { return() }
    
    "Ms Twizzle's Class - Science Results"
  })
  
  output$caption2 <- renderText( {
    if (is.null(input$file1)) { return() }
    paste0("Average Mark  Term 1:",Data()$t1Av," Term 2:",Data()$t2Av," Term 3:",Data()$t3Av)
  })
  
  
  output$caption3 <- renderText( {
    if (is.null(input$file1)) { return() }
    paste0("Analysis of Variance by Gender - Boys Average Mark:",Data()$boys, "  Girls Average Mark:",Data()$girls)
  })
  
  output$notes2 <- renderUI( {
    if (is.null(input$file1)) { return() }
    HTML("The above graph shows the variation in pupils' marks by term. The annual spread
         will normally be greater as the example data is random and normally some pupils will
         tend to be better than others over each term")
    
  })
  
  output$notes3 <- renderUI( {
    if (is.null(input$file1)) { return() }
    HTML("The Analysis of Variance indicates whether there is a statistically significant
         difference between boys and girls in the class. With this 'fixed' data, there is a
         significant difference at the 5% level")
    
  })
  
})