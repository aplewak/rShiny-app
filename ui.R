library(shiny)

shinyUI(fluidPage(
  titlePanel("Stock Market Values"),
  textOutput("text"),
  
  sidebarLayout(
    sidebarPanel(
      h3("COMPARE STOCKS",col = "red"),
      textInput("symb", "Stock Market CO.", "SPY"),
      textInput("symb2", "Compare with :", "NAS"),
    
      dateRangeInput("dates", 
        "DATES",
        start = "2013-01-01", 
        end = as.character(Sys.Date())),
      
      br(),
      br(),
      
      checkboxInput("log", "LOGARITHMIC SCALE", 
        value = FALSE),
      
      checkboxInput("adjust", 
        "COMPENSATE FOR INFLATION", value = FALSE)
      
    ),
    
    mainPanel(plotOutput("plot"),
              plotOutput("barplot")
               )
  )
))
#refrences are from http://shiny.rstudio.com/ i just tweaked code to enchance the feature