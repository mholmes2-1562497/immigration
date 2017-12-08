library(dplyr)
library(ggplot2)
library(tidyr)

#read in CSV file for apprehended, determined inadmissible, removed, and returned data  
country.apprehended <- read.csv("data/apprehended.csv", na.strings = c("X", "D", "-"), stringsAsFactors = FALSE)
country.inadmissible <- read.csv("data/inadmissable.csv", na.strings = c("X", "D", "-"), stringsAsFactors = FALSE)
country.returned <- read.csv("data/returned.csv", na.strings = c("X", "D", "-"), stringsAsFactors = FALSE)
country.removed <- read.csv("data/removed.csv", na.strings = c("X", "D", "-"), stringsAsFactors = FALSE)

#filters apprehended, inadmissible, returned, and removed to only relevant data
filtered.apprehended <- country.apprehended[c(15:187),]
filtered.inadmissible <- country.inadmissible[c(15:200),]
filtered.returned <- country.returned[c(15:189),]
filtered.removed <- country.removed[c(16:174),] 

#renames column names for filtered data for apprehended, inadmissible, returned, and removed
names(filtered.apprehended) <- c("Country", "2006", "2007", "2008", "2009", "2010", "2011", 
                               "2012", "2013", "2014", "2015", "remove1", "remove2", "remove3", 
                               "remove4", "remove5", "remove6", "remove7", "remove8", "remove9", "remove10")
names(filtered.inadmissible) <- c("Country", "2006", "2007", "2008", "2009", "2010", "2011", 
                               "2012", "2013", "2014", "2015", "remove1", "remove2", "remove3", 
                               "remove4")
names(filtered.returned) <- c("Country","2009", "2010", "2011","2012", "2013", "2014", "2015")
names(filtered.removed) <- c("Country", "2006", "criminal.2006", "noncriminal.2006", "2007", "criminal.2007", "noncriminal.2007", 
                               "2008", "criminal.2008", "noncriminal.2008", "2009", "criminal.2009", "noncriminal.2009", "2010", 
                               "criminal.2010", "noncriminal.2010", "2011", "criminal.2011", "noncriminal.2011", "2012", "criminal.2012",
                                "noncriminal.2012", "2013", "criminal.2013", "noncriminal.2013", "2014", "criminal.2014", "noncriminal.2014", 
                                "2015", "criminal.2015", "noncriminal.2015")
removed <- select(filtered.removed, "Country", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015")

 
#filters mexico from all the files to have one data frame of all the values for each file
mexico.removed <- filter(removed, Country == "Mexico")
mexico.returned <- filter(filtered.returned, Country == "Mexico")
mexico.apprehended <- select(filtered.apprehended, - remove1, -remove2, -remove3, -remove4, -remove5, -remove6, -remove7, -remove8, -remove9, -remove10) %>% 
  filter(Country == "Mexico") 
mexico.inadmissible <- select(filtered.inadmissible, -remove1, -remove2, -remove3, -remove4) %>% 
  filter(Country == "Mexico")
b <- gather(mexico.removed, "year", "removed", 2:length(mexico.removed))
c <- gather(mexico.returned, "year", "returned", 2:length(mexico.returned))
d <- gather(mexico.apprehended, "year", "apprehended", 2:length(mexico.apprehended))
e <- gather(mexico.inadmissible, "year", "inadmissible", 2:length(mexico.inadmissible))

merged.data <- left_join(b, c, by = "year") %>% 
  left_join(d, by = "year") %>% 
  left_join(e, by = "year") %>% 
  select(-Country.y, -Country.x.x, -Country.y.y)
merged.data$removed <- as.numeric(gsub(",", "", merged.data$removed))
merged.data$returned <- as.numeric(gsub(",", "", merged.data$returned))
merged.data$apprehended <- as.numeric(gsub(",", "", merged.data$apprehended))
merged.data$inadmissible <- as.numeric(gsub(",", "", merged.data$inadmissible))


graph <- function(){
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
}