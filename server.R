library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)
library(markdown)
library(datasets)
library(bubbles)
devtools::install_github("jcheng5/bubbles", force = TRUE)

renderBubbles(expr, env = parent.frame(), quoted = FALSE)


# source("information.r", local = TRUE)
source("./map-plot.r", local = TRUE)
source("./apprehended-scatterplot.R", local = TRUE)
source("./country-over-time.R", local = TRUE)


shinyServer(function(input, output){
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
    
    #create size
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
  
   # output$returnplot <- renderPlot({
   #   
   #   
   #   # Render a barplot
   #   barplot(returns[,input$n], cex.names = .05,
   #         main="Immigrants that Returned", 
   #           ylab="Returned",
   #         xlab="Years from 2009-2015", col = input$color)
   #   
   # })
   # output$removeplot <- renderPlot({
   #   
   #   
   #   # Render a barplot
   #   barplot(removes[,input$g], cex.names = .05,
   #           main="Immigrants that was Removed", 
   #           ylab="Removed",
   #           xlab="Years from 2009-2015", col = input$color)
   #   
   # })

  #graphs top 50 apprehended countries
  output$graph_Apprehended <- renderPlot({
    sorted.apprehended <- select(apprehended.data, Country, a.2006) %>%
      arrange(-a.2006) %>%
      na.omit() #in server, select column of year first then arrange then omit
    top.50.apprehended <- sorted.apprehended[2:50, ]
    plot1.data <- ggplot(data = top.50.apprehended) + 
      geom_bar(mapping = aes(x = top.50.apprehended$Country, y = as.numeric(top.50.apprehended$a.2006)), 
               stat = "identity", width = 0.7) + 
      labs(title = "50 Countries with the Highest Number Apprehended", 
           x = "Country", 
           y = "Number Apprehended") + 
      coord_flip()
    return(plot1.data)
  })
  
  #graphs Mexico data from 2006-2015
  output$graph <- renderPlot({
    plot.data <- ggplot(data = merged.data) + 
      geom_line(mapping = aes(x = year, y = removed, group = 1, color = "#E69F00")) + 
      geom_line(mapping = aes(x = year, y = returned, group = 1, color = "#56B4E9")) +
      geom_line(mapping = aes(x = year, y = apprehended, group = 1, color = "#009E73")) + 
      geom_line(mapping = aes(x = year, y = inadmissible, group = 1, color = "#F0E442")) + 
      labs(title = "Mexico Data from 2006-2015", 
           x = "Year", 
           y = "Amount") + 
      scale_colour_discrete(name = "Legend", breaks = c("#E69F00", "#56B4E9", "#009E73", "#F0E442"), 
                            labels = c("Removed", "Returned", "Apprehended", "Inadmissible"))
    return(plot.data)
  })

  
 })
  

