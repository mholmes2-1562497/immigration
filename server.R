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
})
  
  
  

