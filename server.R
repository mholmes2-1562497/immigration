library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)
library(markdown)
library(datasets)

source("information.r", local = TRUE)
source("map-plot.r", local = TRUE)

shinyServer(function(input, output) {
  # reactive function to determine which year data frame to use (using year.list in R file)
  select.year <- reactive({
    year.data <- data.frame(year.list[as.numeric(input$year)])
    return(year.data)
  })
  output$map <- renderPlotly({
    #renders a different plot based on status 
    if(input$status == "noncriminal") {
      #filters to exlude outliers 
      final.data <- filter(select.year(), noncriminal < input$max)
      MakeNoncrimMap(final.data)
    } else {
      final.data <- filter(select.year(), criminal < input$max)
      MakeCrimMap(final.data)
    }
  })
  
  output$returnplot <- renderPlot({
    
    
    # Render a barplot
    barplot(returns[,input$n], cex.names = 1,
            main="Immigrants that Returned", 
            ylab="Returned",
            xlab="Years from 2009-2015", col = input$color)
    
  })
  output$removeplot <- renderPlot({
    
    
    # Render a barplot
    barplot(removes[,input$g], cex.names = 1,
            main="Immigrants that was Removed", 
            ylab="Removed",
            xlab="Years from 2009-2015", col = input$color)
    
  })
  
})
  
 
  

