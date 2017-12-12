library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)
library(markdown)
library(datasets)
library(bubbles)
devtools::install_github("jcheng5/bubbles", force = TRUE)

# source("information.r", local = TRUE)
# source("map-plot.r", local = TRUE)
source("usinfo.r", local = TRUE)

renderBubbles(expr, env = parent.frame(), quoted = FALSE)


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
  
  
  output$bubbles <- renderBubbles({
    
   
    
    at <- as.numeric(input$years)
    
    ims <- filter(immigrant, Year == at)

    
    ims<- gather(ims,"Reason","Amount", 1:7) %>% 
      filter(Reason == "Ratio")
    
    n<-1000
    random<-1:n
    ratio<- as.numeric(ims$Amount)*n
    sample <- sample(random,ratio)
    
    #use bubbles!
    bubble.frame <- data.frame(random,0)
    
    colnames(bubble.frame) <- c("Set", "Hit")
    
    bubble.frame$Hit <- "green"
    bubble.frame$Hit[sample] <- "blue"
    
    
    bubbles(value = sample(10), label=" ", key = , tooltip = "One out of A Thousand", color = bubble.frame$Hit,
            textColor = "#333333")
    
    
    
  })

  
  })
  
  
  

