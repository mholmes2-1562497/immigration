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
    year.data <- year.list %>% input$year
    return(year.data)
  })
  output$map <- renderPlotly({
    #renders a different plot based on status 
    if(input$status == "noncriminal") {
      #filters to exlude outliers 
      select.year(input$year) <- filter(year.data, noncriminal < input$max)
      MakeNoncrimMap(year.data)
    } else {
      select.year(input$year) <- filter(year.data, criminal < input$max)
      MakeCrimMap(year.data)
    }
  })  
})
  
  
  

