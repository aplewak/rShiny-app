# server.R

library(quantmod)
source("helpers.R")

shinyServer(function(input, output) {
  
  
  
  dataInput <- reactive({
    getSymbols(input$symb, src = "yahoo", 
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
  })
  
  output$plot <- renderPlot({   
    data <- dataInput()
    if (input$adjust) data <- adjust(dataInput())
    
    chartSeries(data, theme = chartTheme("white"), 
                type = "line", log.scale = input$log, TA = NULL)
  })

  output$plot <- renderPlot({
    data <- getSymbols(input$symb, src = "google", 
      from = input$dates[1],
      to = input$dates[2],
      auto.assign = FALSE)
                 
    chartSeries(data,main = input$symb, theme = chartTheme('black',up.col='cyan',dn.col='pink'), 
      type = "line",log.scale = input$log, TA ="addVo();addBBands();addCCI()")
  })
  ##add the second grapgh to compare the data between two over month frames
  output$barplot <- renderPlot({
    data <- getSymbols(input$symb2, src = "google", 
                       from = input$dates[1],
                       to = input$dates[2],
                       auto.assign = FALSE)

    chartSeries(data, main=input$symb2, theme = chartTheme('black',up.col='yellow',dn.col='red'), 
         type = "line",log.scale = input$log, TA="addVo();addBBands();addCCI()", show.grid = TRUE)
  })

  ###CURRENT DATE ON THE APP
  output$text <- renderText({
    paste("Todays date :", Sys.Date(), Sys.time())
    
  })
  
})