library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)
library(markdown)
library(datasets)

source("information.r", local = TRUE)
source("map-plot.r", local = TRUE)
shinyServer(function(input, output) {
  select.year <- reactive({
    year.data <- year.list %>% input$year
    return(year.data)
  })
  output$map <- renderPlotly({
    if(input$status == "noncriminal") {
      select.year(input$year) <- filter(year.data, noncriminal < input$max)
      MakeNoncrimMap(year.data)
    } else {
      select.year(input$year) <- filter(year.data, criminal < input$max)
      MakeCrimMap(year.data)
    }
  })  
})
  
  
  

