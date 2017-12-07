library(dplyr)
library(tidyr)
library(shiny)
library(plotly)
library(ggplot2)
library(markdown)
devtools::install_github("jcheng5/bubbles")

library(bubbles)


setwd("~/Info201/immigration")

removed <- read.csv("data/removed.csv", stringsAsFactors = FALSE)
removed <- removed[3:13,2:16 ]

#Get the right amount of Apprehended data 
apprehended <- read.csv("data/apprehended.csv", stringsAsFactors = FALSE)
apprehended <- apprehended[3:5, 2:6 ] 
colnames(apprehended) <- c("2006","2007","2008","2009","2010")
apprehended <- apprehended[-c(2), ] 
apprehended <- gather(apprehended,"Year", "Apprehended",1:5)
apprehended <- apprehended[-c(1,3,5,7,9), ]
#Same with Immigrant
immigrant <- read.csv("data/us.immigrant.csv", stringsAsFactors = FALSE)
cols <- c("Year","Drug","Immigration","Other")
colnames(immigrant) <- cols
immigrant <- immigrant[31:35, ]
#Join together to plot later
immigrant <- full_join(immigrant,apprehended)
#Get rid of commas in the values
immigrant$Drug<-as.numeric(gsub(",", "", immigrant$Drug))
immigrant$Immigration<-as.numeric(gsub(",", "", immigrant$Immigration))
immigrant$Other<-as.numeric(gsub(",", "", immigrant$Other))
immigrant$Apprehended<-as.numeric(gsub(",", "", immigrant$Apprehended))
#Create extra tables based on the data
immigrant <- mutate(immigrant,Total = Drug+Immigration)
immigrant <- mutate(immigrant,Ratio = Total/Apprehended)

#Present graph 
main.plot <- ggplot(data = immigrant)+
  geom_line(mapping = aes(x= Year, y= Ratio, group=1))+
  ggtitle("Percentage of People who are Arrested/Apprehended") 
  
#Call above graph and use this function at the bottom   
bar.it <- function(year){
year <- as.numeric(year)

#How big youd want the bubble graph to be
n<-1000
random<-1:n
ims <- filter(immigrant,Year == year) 
ims<- gather(ims,"Reason","Amount", 1:7) %>% 
  filter(Reason == "Ratio")
ratio<- as.numeric(ims$Amount)*n
sample <- sample(random,ratio)

#use bubbles!
bubble.frame <- data.frame(random,0)
colnames(bubble.frame) <- c("Set", "Hit")

bubble.frame$Hit <- "green"
bubble.frame$Hit[sample] <- "blue"


bubbles(value = sample(10), label=" ", key = , tooltip = "One out of A Thousand", color = bubble.frame$Hit,
        textColor = "#333333", width = NULL, height = NULL)
  
}

# bubblesOutput(outputId, width = "600px", height = "600px")
# 
# renderBubbles(expr, env = parent.frame(), quoted = FALSE)
# 


