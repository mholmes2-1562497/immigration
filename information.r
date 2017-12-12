library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)
library(markdown)
library(datasets)

rownames(removes) <- c("2009", "2010", "2011", "2012", "2013", "2014", "2015")
removes[1, 1] = 250000
removes[2, 1] = 333567
removes[3, 1] = 399890
removes[4, 1] = 420033
removes[5, 1] = 345093
removes[6, 1] = 322983
removes[7, 1] = 395402

removes[1, 4] = 12000
removes[2, 4] = 11837
removes[3, 4] = 11272
removes[4, 4] = 11030
removes[5, 4] = 12320
removes[6, 4] = 12320
removes[7, 4] = 11320




rownames(returns) <- c("2009", "2010", "2011", "2012", "2013", "2014", "2015")
return <- read.csv("~/Desktop/Info201/immigration/data/returned.csv", stringsAsFactors = FALSE)
remove <- read.csv("~/Desktop/Info201/immigration/data/removed.csv", stringsAsFactors = FALSE)


return.updated2 <- return[-c(10),]
return.updated <- return.updated2[c(6:10),]

names(return.updated) <- c("Regions", "2009", "2010", "2011", "2012", "2013","2014", "2015")


remove.updated2 <- remove[-c(11),]
remove.updated <- remove.updated2[c(7:11),]
return.updated.year <- select(return.updated,"2009","2010","2011", "2012","2013","2014","2015")

remove.updated.year <- select(remove.updated,"X.9", "X.12","X.15","X.18","X.21","X.24","X.27")
names(remove.updated.year) <- c("2009", "2010", "2011", "2012", "2013", "2014", "2015")




<<<<<<< HEAD
setwd("~/Info201/Immigration")
returned <- read.csv("data/returned.csv", stringsAsFactors = FALSE)
removed <- read.csv("data/removed.csv", stringsAsFactors = FALSE)
colnames(removed)[1] <- "region"
=======
>>>>>>> 129161f28d8a24c8e38470525d6c80b18b4cddf0



##2009 Removed
africa.criminal.2009 <- 718
africa.noncriminal.2009 <- 1304

asia.criminal.2009 <- 1334
asia.noncriminal.2009 <- 4906

europe.criminal.2009 <- 1078
europe.noncriminal.2009 <- 3537

northamerica.criminal.2009 <- 125416
northamerica.noncriminal.2009 <- 240531

southamerica.criminal.2009 <- 3118
southamerica.noncriminal.2009 <- 8951

##2010 Removed
africa.criminal.2010 <- 666
africa.noncriminal.2010 <- 1220

asia.criminal.2010 <- 1559
asia.noncriminal.2010 <- 4665

europe.criminal.2010 <- 1266
europe.noncriminal.2010 <- 2741

northamerica.criminal.2010 <- 162443
northamerica.noncriminal.2010 <- 195649

southamerica.criminal.2010 <- 3500
southamerica.noncriminal.2010 <- 7511

##2011 Removed
africa.criminal.2011 <- 647
africa.noncriminal.2011 <- 1015

asia.criminal.2011 <- 1567
asia.noncriminal.2011 <- 3737

europe.criminal.2011 <- 1236
europe.noncriminal.2011 <- 1999

northamerica.criminal.2011 <- 181887
northamerica.noncriminal.2011 <- 184009

southamerica.criminal.2011 <- 3396
southamerica.noncriminal.2011 <- 5892

##2012 Removed
africa.criminal.2012 <- 673
africa.noncriminal.2012 <- 761

asia.criminal.2012 <- 1469
asia.noncriminal.2012 <- 2862

europe.criminal.2012 <- 1275
europe.noncriminal.2012 <- 1468

northamerica.criminal.2012 <- 193320
northamerica.noncriminal.2012 <- 206206

southamerica.criminal.2012 <- 3204
southamerica.noncriminal.2012 <- 4372

##2013 Removed
africa.criminal.2013 <- 599
africa.noncriminal.2013 <- 615

asia.criminal.2013 <- 1135
asia.noncriminal.2013 <- 2013

europe.criminal.2013 <- 1082
europe.noncriminal.2013 <- 988

northamerica.criminal.2013 <- 193235
northamerica.noncriminal.2013 <- 227223

southamerica.criminal.2013 <- 2721
southamerica.noncriminal.2013 <- 3153

##2014 Removed
africa.criminal.2014 <- 521
africa.noncriminal.2014 <- 745

asia.criminal.2014 <- 1080
asia.noncriminal.2014 <- 1729

europe.criminal.2014 <- 890
europe.noncriminal.2014 <- 827

northamerica.criminal.2014 <- 167622
northamerica.noncriminal.2014 <- 226738

southamerica.criminal.2014 <- 2433
southamerica.noncriminal.2014 <- 2751

##2015 Removed
africa.criminal.2015 <- 380
africa.noncriminal.2015 <- 986

asia.criminal.2015 <- 812
asia.noncriminal.2015 <- 1852

europe.criminal.2015 <- 726
europe.noncriminal.2015 <- 737

northamerica.criminal.2015 <- 135466
northamerica.noncriminal.2015 <- 180578

southamerica.criminal.2015 <- 2087
southamerica.noncriminal.2015 <- 3122

## Africa Returned
africa.return.2009 <- 3073
africa.return.2010 <- 3441
africa.return.2011 <- 2389
africa.return.2012 <- 2389
africa.return.2013 <- 1505
africa.return.2014 <- 1710
africa.return.2015 <- 2187

## Asia Returned
asia.return.2009 <- 53825
asia.return.2010 <- 57788
asia.return.2011 <- 56693
asia.return.2012 <- 46361
asia.return.2013 <- 44554
asia.return.2014 <- 46552
asia.return.2015 <- 45424

## Europe Returned
europe.return.2009 <- 19254
europe.return.2010 <- 18196
europe.return.2011 <- 17185
europe.return.2012 <- 13291
europe.return.2013 <- 12403
europe.return.2014 <- 12159
europe.return.2015 <- 11493

## North America Returned
northamerica.return.2009 <- 501532
northamerica.return.2010 <- 390678
northamerica.return.2011 <- 241927
northamerica.return.2012 <- 166038
northamerica.return.2013 <- 117288
northamerica.return.2014 <- 100139
northamerica.return.2015 <- 67232

## South America Returned
southhamerica.return.2009 <- 3640
southhamerica.return.2010 <- 3139
southhamerica.return.2011 <- 2961
southhamerica.return.2012 <- 2174
southhamerica.return.2013 <- 2222
southhamerica.return.2014 <- 1957
southhamerica.return.2015 <- 2315



## 2009 Graph

Regions <- c("Africa", "Asia", "Europe", "North America", "South America")
remove_criminal_2009 <- c(africa.criminal.2009, asia.criminal.2009, europe.criminal.2009, northamerica.criminal.2009, 
                 southamerica.criminal.2009)
remove_noncriminal_2009 <- c(africa.noncriminal.2009, asia.noncriminal.2009, europe.noncriminal.2009, 
                             northamerica.noncriminal.2009, southamerica.noncriminal.2009)
return_2009 <- c(africa.return.2009, asia.return.2009, europe.return.2009, northamerica.return.2009, southhamerica.return.2009)
data.2009 <- data.frame(Regions, remove_criminal_2009, remove_noncriminal_2009)

graph.2009 <- plot_ly(data.2009, x = ~Regions, y = ~remove_criminal_2009, type = 'bar', name = 'Removed_Criminals') %>%
  add_trace(y = ~return_2009, name = 'Returned') %>%
  add_trace(y = ~remove_noncriminal_2009, name = 'Removed_NonCriminals') %>%
  layout(title = "2009 Removal Criminal/Non Criminal and Returned", yaxis = list(title = 'Count'), barmode = 'group')
returns <- print(WorldPhones)
removes <- print(WorldPhones)
rownames(removes) <- c("2009", "2010", "2011", "2012", "2013", "2014", "2015")
removes[1, 1] = 250000
removes[2, 1] = 333567
removes[3, 1] = 399890
removes[4, 1] = 420033
removes[5, 1] = 345093
removes[6, 1] = 322983
removes[7, 1] = 395402

removes[1, 4] = 12000
removes[2, 4] = 11837
removes[3, 4] = 11272
removes[4, 4] = 11030
removes[5, 4] = 12320
removes[6, 4] = 12320
removes[7, 4] = 11320
## 2010 Graph

Regions <- c("Africa", "Asia", "Europe", "North America", "South America")
remove_criminal_2010 <- c(africa.criminal.2010, asia.criminal.2010, europe.criminal.2010, northamerica.criminal.2010, 
                          southamerica.criminal.2010)
remove_noncriminal_2010 <- c(africa.noncriminal.2010, asia.noncriminal.2010, europe.noncriminal.2010, 
                             northamerica.noncriminal.2010, southamerica.noncriminal.2010)
return_2010 <- c(africa.return.2010, asia.return.2010, europe.return.2010, northamerica.return.2010, southhamerica.return.2010)
data.2010 <- data.frame(Regions, remove_criminal_2010, remove_noncriminal_2010)

graph.2010 <- plot_ly(data.2010, x = ~Regions, y = ~remove_criminal_2010, type = 'bar', name = 'Removed_Criminals') %>%
  add_trace(y = ~return_2010, name = 'Returned') %>%
  add_trace(y = ~remove_noncriminal_2010, name = 'Removed_NonCriminals') %>%
  layout(title = "2010 Removal Criminal/Non Criminal and Returned", yaxis = list(title = 'Count'), barmode = 'group')

## 2011 Graph

Regions <- c("Africa", "Asia", "Europe", "North America", "South America")
remove_criminal_2011 <- c(africa.criminal.2011, asia.criminal.2011, europe.criminal.2011, northamerica.criminal.2011, 
                          southamerica.criminal.2011)
remove_noncriminal_2011 <- c(africa.noncriminal.2011, asia.noncriminal.2011, europe.noncriminal.2011, 
                             northamerica.noncriminal.2011, southamerica.noncriminal.2011)
return_2011 <- c(africa.return.2011, asia.return.2011, europe.return.2011, northamerica.return.2011, southhamerica.return.2011)
data.2011 <- data.frame(Regions, remove_criminal_2011, remove_noncriminal_2011)

graph.2011 <- plot_ly(data.2011, x = ~Regions, y = ~remove_criminal_2011, type = 'bar', name = 'Removed_Criminals') %>%
  add_trace(y = ~return_2011, name = 'Returned') %>%
  add_trace(y = ~remove_noncriminal_2011, name = 'Removed_NonCriminals') %>%
  layout(title = "2011 Removal Criminal/Non Criminal and Returned", yaxis = list(title = 'Count'), barmode = 'group')

## 2012 Graph

Regions <- c("Africa", "Asia", "Europe", "North America", "South America")
remove_criminal_2012 <- c(africa.criminal.2012, asia.criminal.2012, europe.criminal.2012, northamerica.criminal.2012, 
                          southamerica.criminal.2012)
remove_noncriminal_2012 <- c(africa.noncriminal.2012, asia.noncriminal.2012, europe.noncriminal.2012, 
                             northamerica.noncriminal.2012, southamerica.noncriminal.2012)
return_2012 <- c(africa.return.2012, asia.return.2012, europe.return.2012, northamerica.return.2012, southhamerica.return.2012)
data.2012 <- data.frame(Regions, remove_criminal_2012, remove_noncriminal_2012)

graph.2012 <- plot_ly(data.2012, x = ~Regions, y = ~remove_criminal_2012, type = 'bar', name = 'Removed_Criminals') %>%
  add_trace(y = ~return_2012, name = 'Returned') %>%
  add_trace(y = ~remove_noncriminal_2012, name = 'Removed_NonCriminals') %>%
  layout(title = "2012 Removal Criminal/Non Criminal and Returned", yaxis = list(title = 'Count'), barmode = 'group')

## 2013 Graph

Regions <- c("Africa", "Asia", "Europe", "North America", "South America")
remove_criminal_2013 <- c(africa.criminal.2013, asia.criminal.2013, europe.criminal.2013, northamerica.criminal.2013, 
                          southamerica.criminal.2013)
remove_noncriminal_2013 <- c(africa.noncriminal.2013, asia.noncriminal.2013, europe.noncriminal.2013, 
                             northamerica.noncriminal.2013, southamerica.noncriminal.2013)
return_2013 <- c(africa.return.2013, asia.return.2013, europe.return.2013, northamerica.return.2013, southhamerica.return.2013)
data.2013 <- data.frame(Regions, remove_criminal_2013, remove_noncriminal_2013)

graph.2013 <- plot_ly(data.2013, x = ~Regions, y = ~remove_criminal_2013, type = 'bar', name = 'Removed_Criminals') %>%
  add_trace(y = ~return_2013, name = 'Returned') %>%
  add_trace(y = ~remove_noncriminal_2013, name = 'Removed_NonCriminals') %>%
  layout(title = "2013 Removal Criminal/Non Criminal and Returned", yaxis = list(title = 'Count'), barmode = 'group')

## 2014 Graph

Regions <- c("Africa", "Asia", "Europe", "North America", "South America")
remove_criminal_2014 <- c(africa.criminal.2014, asia.criminal.2014, europe.criminal.2014, northamerica.criminal.2014, 
                          southamerica.criminal.2014)
remove_noncriminal_2014 <- c(africa.noncriminal.2014, asia.noncriminal.2014, europe.noncriminal.2014, 
                             northamerica.noncriminal.2014, southamerica.noncriminal.2014)
return_2014 <- c(africa.return.2014, asia.return.2014, europe.return.2014, northamerica.return.2014, southhamerica.return.2014)
data.2014 <- data.frame(Regions, remove_criminal_2014, remove_noncriminal_2014)

graph.2014 <- plot_ly(data.2014, x = ~Regions, y = ~remove_criminal_2014, type = 'bar', name = 'Removed_Criminals') %>%
  add_trace(y = ~return_2014, name = 'Returned') %>%
  add_trace(y = ~remove_noncriminal_2014, name = 'Removed_NonCriminals') %>%
  layout(title = "2014 Removal Criminal/Non Criminal and Returned", yaxis = list(title = 'Count'), barmode = 'group')

## 2015 Graph

Regions <- c("Africa", "Asia", "Europe", "North America", "South America")
remove_criminal_2015 <- c(africa.criminal.2015, asia.criminal.2015, europe.criminal.2015, northamerica.criminal.2015, 
                          southamerica.criminal.2015)
remove_noncriminal_2015 <- c(africa.noncriminal.2015, asia.noncriminal.2015, europe.noncriminal.2015, 
                             northamerica.noncriminal.2015, southamerica.noncriminal.2015)
return_2015 <- c(africa.return.2015, asia.return.2015, europe.return.2015, northamerica.return.2015, southhamerica.return.2015)
data.2015 <- data.frame(Regions, remove_criminal_2015, remove_noncriminal_2015)

graph.2015 <- plot_ly(data.2015, x = ~Regions, y = ~remove_criminal_2015, type = 'bar', name = 'Removed_Criminals') %>%
  add_trace(y = ~return_2015, name = 'Returned') %>%
  add_trace(y = ~remove_noncriminal_2015, name = 'Removed_NonCriminals') %>%
  layout(title = "2015 Removal Criminal/Non Criminal and Returned", yaxis = list(title = 'Count'), barmode = 'group')



