library(ggplot2)
library(plotly)
library(dplyr)

#import data file of immigrants removed from the US
removed.data <- read.csv("data/removed.csv", stringsAsFactors = FALSE)
colnames(removed.data)[colnames(removed.data) == "Table.41."] <- "country"
coordinates <- read.csv("data/country-coordinates.csv", stringsAsFactors = FALSE)
country.codes <- read.csv("data/country-codes.csv", stringsAsFactors = FALSE)
removed.data <- left_join(removed.data, coordinates, by = "country") #add lat / long data for mapping
removed.data <- left_join(removed.data, country.codes, by = "country")

#create separate dataframes for each year
data.06 <- removed.data %>% #2006 data
           select(country, X, X.1, X.2, latitude, longitude, code)
cols <- c("country", "total", "criminal", "noncriminal", "lat", "long", "code")
colnames(data.06) <- cols
data.06 <- data.06[c(16 : 174), ] #remove region data
data.06$total <- as.numeric(gsub(",", "", data.06$total))
data.06$criminal <- as.numeric(gsub(",", "", data.06$criminal))
data.06$noncriminal <- as.numeric(gsub(",", "", data.06$noncriminal))

data.07 <- removed.data %>% #2007 data
  select(country, X, X.1, X.2, latitude, longitude, code)
cols <- c("country", "total", "criminal", "noncriminal", "lat", "long","code")
colnames(data.07) <- cols
data.07 <- data.07[c(15 : 174), ] #remove region data
data.07$total <- as.numeric(gsub(",", "", data.07$total))
data.07$criminal <- as.numeric(gsub(",", "", data.07$criminal))
data.07$noncriminal <- as.numeric(gsub(",", "", data.07$noncriminal))

data.08 <- removed.data %>% #2008 data
  select(country, X, X.1, X.2, latitude, longitude, code)
cols <- c("country", "total", "criminal", "noncriminal", "lat", "long","code")
colnames(data.08) <- cols
data.08 <- data.08[c(15 : 174), ] #remove region data
data.08$total <- as.numeric(gsub(",", "", data.08$total))
data.08$criminal <- as.numeric(gsub(",", "", data.08$criminal))
data.08$noncriminal <- as.numeric(gsub(",", "", data.08$noncriminal))

data.09 <- removed.data %>% #2009 data
  select(country, X, X.1, X.2, latitude, longitude, code)
cols <- c("country", "total", "criminal", "noncriminal", "lat", "long", "code")
colnames(data.09) <- cols
data.09 <- data.09[c(15 : 174), ] #remove region data
data.09$total <- as.numeric(gsub(",", "", data.09$total))
data.09$criminal <- as.numeric(gsub(",", "", data.09$criminal))
data.09$noncriminal <- as.numeric(gsub(",", "", data.09$noncriminal))

data.10 <- removed.data %>% #2010 data
  select(country, X, X.1, X.2, latitude, longitude, code)
cols <- c("country", "total", "criminal", "noncriminal", "lat", "long", "code")
colnames(data.10) <- cols
data.10 <- data.10[c(15 : 174), ] #remove region data
data.10$total <- as.numeric(gsub(",", "", data.10$total))
data.10$criminal <- as.numeric(gsub(",", "", data.10$criminal))
data.10$noncriminal <- as.numeric(gsub(",", "", data.10$noncriminal))

data.11 <- removed.data %>% #2011 data
  select(country, X, X.1, X.2, latitude, longitude, code)
cols <- c("country", "total", "criminal", "noncriminal", "lat", "long", "code")
colnames(data.11) <- cols
data.11 <- data.11[c(15 : 174), ] #remove region data
data.11$total <- as.numeric(gsub(",", "", data.11$total))
data.11$criminal <- as.numeric(gsub(",", "", data.11$criminal))
data.11$noncriminal <- as.numeric(gsub(",", "", data.11$noncriminal))

data.12 <- removed.data %>% #2007 data
  select(country, X, X.1, X.2, latitude, longitude, code)
cols <- c("country", "total", "criminal", "noncriminal", "lat", "long", "code")
colnames(data.12) <- cols
data.12 <- data.12[c(15 : 174), ] #remove region data
data.12$total <- as.numeric(gsub(",", "", data.12$total))
data.12$criminal <- as.numeric(gsub(",", "", data.12$criminal))
data.12$noncriminal <- as.numeric(gsub(",", "", data.12$noncriminal))

data.13 <- removed.data %>% #2007 data
  select(country, X, X.1, X.2, latitude, longitude, code)
cols <- c("country", "total", "criminal", "noncriminal", "lat", "long", "code")
colnames(data.13) <- cols
data.13 <- data.13[c(15 : 174), ] #remove region data
data.13$total <- as.numeric(gsub(",", "", data.13$total))
data.13$criminal <- as.numeric(gsub(",", "", data.13$criminal))
data.13$noncriminal <- as.numeric(gsub(",", "", data.13$noncriminal))

data.14 <- removed.data %>% #2007 data
  select(country, X, X.1, X.2, latitude, longitude, code)
cols <- c("country", "total", "criminal", "noncriminal", "lat", "long", "code")
colnames(data.14) <- cols
data.14 <- data.14[c(15 : 174), ] #remove region data
data.14$total <- as.numeric(gsub(",", "", data.14$total))
data.14$criminal <- as.numeric(gsub(",", "", data.14$criminal))
data.14$noncriminal <- as.numeric(gsub(",", "", data.14$noncriminal))

data.15 <- removed.data %>% #2007 data
  select(country, X, X.1, X.2, latitude, longitude, code)
cols <- c("country", "total", "criminal", "noncriminal", "lat", "long", "code")
colnames(data.15) <- cols
data.15 <- data.15[c(15 : 174), ] #remove region data
data.15$total <- as.numeric(gsub(",", "", data.15$total))
data.15$criminal <- as.numeric(gsub(",", "", data.15$criminal))
data.15$noncriminal <- as.numeric(gsub(",", "", data.15$noncriminal))

#create map plot 
#create map plot for noncriminals
MakeNoncrimMap <- function(year.data) {
  #year <- 
  l.1 <- list(color = toRGB("grey"), width = 0.5)
  
  # specify map projection/options
  g.1 <- list(
    showframe = FALSE,
    showcoastlines = FALSE,
    projection = list(type = 'Mercator')
  )
  
  noncriminal.map <- plot_geo(year.data) %>%
    add_trace(
      z = ~noncriminal, color = ~noncriminal, colors = 'Blues',
      text = ~country, locations = ~code, marker = list(line = l)
    ) %>%
    colorbar(title = 'total noncriminal immigrants') %>%
    layout(
      title = 'noncriminal immigrants removed from the US in ((selected year))',
      geo = g
    )
  return(noncriminal.map)
}
MakeNoncrimMap(data.06)
#create map plot for criminals
l.2 <- list(color = toRGB("grey"), width = 0.5)

# specify map projection/options
g.2 <- list(
  showframe = FALSE,
  showcoastlines = FALSE,
  projection = list(type = 'Mercator')
)

p.2 <- plot_geo(data.06) %>%
  add_trace(
    z = ~noncriminal, color = ~criminal, colors = 'Reds',
    text = ~country, locations = ~code, marker = list(line = l)
  ) %>%
  colorbar(title = 'total criminal immigrants') %>%
  layout(
    title = 'criminal immigrants removed from the US in _______ ',
    geo = g
  )
  