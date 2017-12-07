library(dplyr)
library(ggplot2)

#read in CSV file for apprehended and determined inadmissible data  
data.apprehended <- read.csv("data/apprehended.csv", na.strings = c("X", "D", "-"), stringsAsFactors = FALSE)
data.inadmissible <- read.csv("data/inadmissable.csv", na.strings = c("X", "D", "-"), stringsAsFactors = FALSE)
# Filters dataframe to only include countries and their values for each year
filter.apprehended <- data.apprehended[c(15:187),]
filter.inadmissible <- data.inadmissible[c(15:200),]

#renames columns to make data easier to manipulate 
names(filter.apprehended) <- c("Country", "a.2006", "a.2007", "a.2008", "a.2009", "a.2010", "a.2011", 
                               "a.2012", "a.2013", "a.2014", "a.2015", "remove1", "remove2", "remove3", 
                               "remove4", "remove5", "remove6", "remove7", "remove8", "remove9", "remove10")
#selects only the usuable columns for later left join
apprehended.data <- select(filter.apprehended, Country, a.2006, a.2007, a.2008, a.2009, a.2010, a.2011, a.2012, a.2013, a.2014, a.2015)

#changes the values in the dataframe to be read as numeric and gets rid of commas
apprehended.data$a.2006 <- as.numeric(gsub(",", "", apprehended.data$a.2006))
apprehended.data$a.2007 <- as.numeric(gsub(",", "", apprehended.data$a.2007))
apprehended.data$a.2008 <- as.numeric(gsub(",", "", apprehended.data$a.2008))
apprehended.data$a.2009 <- as.numeric(gsub(",", "", apprehended.data$a.2009))
apprehended.data$a.2010 <- as.numeric(gsub(",", "", apprehended.data$a.2010))
apprehended.data$a.2011 <- as.numeric(gsub(",", "", apprehended.data$a.2011))
apprehended.data$a.2012 <- as.numeric(gsub(",", "", apprehended.data$a.2012))
apprehended.data$a.2013 <- as.numeric(gsub(",", "", apprehended.data$a.2013))
apprehended.data$a.2014 <- as.numeric(gsub(",", "", apprehended.data$a.2014))
apprehended.data$a.2015 <- as.numeric(gsub(",", "", apprehended.data$a.2015))

#renames columns to make data easier to manipulate
names(filter.inadmissible) <- c("Country", "i.2006", "i.2007", "i.2008", "i.2009", "i.2010", "i.2011", 
                                "i.2012", "i.2013", "i.2014", "i.2015", "remove1", "remove2", "remove3", 
                                "remove4")
#selects only the usable columns for later left join 
inadmissible.data <- select(filter.inadmissible, Country, i.2006, i.2007, i.2008, i.2009, i.2010, i.2011, i.2012, i.2013, i.2014, i.2015)

#changes the values in the dataframe to be read as numeric and gets rid of commas 
inadmissible.data$i.2006 <- as.numeric(gsub(",", "", inadmissible.data$i.2006))
inadmissible.data$i.2007 <- as.numeric(gsub(",", "", inadmissible.data$i.2007))
inadmissible.data$i.2008 <- as.numeric(gsub(",", "", inadmissible.data$i.2008))
inadmissible.data$i.2009 <- as.numeric(gsub(",", "", inadmissible.data$i.2009))
inadmissible.data$i.2010 <- as.numeric(gsub(",", "", inadmissible.data$i.2010))
inadmissible.data$i.2011 <- as.numeric(gsub(",", "", inadmissible.data$i.2011))
inadmissible.data$i.2012 <- as.numeric(gsub(",", "", inadmissible.data$i.2012))
inadmissible.data$i.2013 <- as.numeric(gsub(",", "", inadmissible.data$i.2013))
inadmissible.data$i.2014 <- as.numeric(gsub(",", "", inadmissible.data$i.2014))
inadmissible.data$i.2015 <- as.numeric(gsub(",", "", inadmissible.data$i.2015))

#temp comment to test code FIX LATER
# sorted.apprehended <- select(apprehended.data, Country, a.2006) %>% 
#   arrange(-a.2006) %>% 
#   na.omit() #in server, select column of year first then arrange then omit
# top.50.apprehended <- sorted.apprehended[2:50, ]

#graphs top 50 countries apprehended
graph1 <- function(year){
  plot1.data <- ggplot(data = top.50.apprehended) + 
    geom_bar(mapping = aes(x = top.50.apprehended$Country, y = as.numeric(top.50.apprehended$year)), 
             stat = "identity", width = 0.7) + 
    labs(title = "50 Countries with the Highest Number Apprehended", 
         x = "Country", 
         y = "Number Apprehended") + 
    coord_flip()
  return(plot1.data)
}

sorted.apprehended <- select(apprehended.data, Country, a.2006) %>% 
  arrange(a.2006) %>% 
  na.omit() #in server, select column of year first then arrange then omit
bottom.50.apprehended <- sorted.apprehended[2:50, ]

#graphs bottom 50 countries apprehended
graph2 <- function(bottom.50.apprehended){
  plot2.data <- ggplot(data = bottom.50.apprehended) + 
    geom_bar(mapping = aes(x = bottom.50.apprehended$Country, y = bottom.50.apprehended$a.2006), 
             stat = "identity", width = 1.0) + 
    labs(title = "50 Countries with the Lowest Number Apprehended", 
         x = "Country", 
         y = "Number Apprehended") + 
    coord_flip()
  return(plot2.data)
  
}

#selects on the top 50 countries with the highest number determined inadmissible 
sorted.inadmissible <- select(inadmissible.data, Country, i.2006) %>% 
  arrange(-i.2006) %>% 
  na.omit() #in server, select column of year first then arrange then omit
top.50.inadmissible <- sorted.inadmissible[3:50, ]

#graphs top 50 countries determined inadmissible
graph3 <- function(top.50.inadmissible){
  plot3.data <- ggplot(data = top.50.inadmissible) + 
    geom_bar(mapping = aes(x = top.50.inadmissible$Country, y = as.numeric(top.50.inadmissible$i.2006)), 
             stat = "identity", width = 0.7) + 
    labs(title = "Top Inadmissible Data", 
         x = "Country", 
         y = "Number Determined Inadmissible") + 
    coord_flip()
  return(plot3.data)
}

#selects the bottom 50 countries that have the lowest determined inadmissible
sorted.bottom.inadmissible <- select(inadmissible.data, Country, i.2006) %>% 
  arrange(i.2006) %>% 
  na.omit() #in server, select column of year first then arrange then omit
bottom.50.inadmissible <- sorted.bottom.inadmissible[1:50, ]

#graphs bottom 50 countries determined inadmissible
graph4 <- function(bottom.50.inadmissible){
  plot4.data <- ggplot(data = bottom.50.inadmissible) + 
    geom_bar(mapping = aes(x = bottom.50.inadmissible$Country, y = as.numeric(bottom.50.inadmissible$i.2006)), 
             stat = "identity", width = 0.7) + 
    labs(title = "Bottom Inadmissible Data", 
         x = "Country", 
         y = "Number Determined Inadmissible") + 
    coord_flip()
  return(plot4.data)
}
