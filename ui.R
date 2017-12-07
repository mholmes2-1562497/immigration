library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)
library(markdown)

fluidPage(    
  
  # Give the page a title
  titlePanel("Immigration"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput(inputId = "dataset",
                  label = "Choose a dataset:", 
                  choices=c("graph.2009", "graph.2010", "graph.2011", "graph.2012", "graph.2013", "graph.2014", "graph.2015"))
    
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("plot")  
    )
    
  )
)
