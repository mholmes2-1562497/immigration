library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)
library(markdown)

shinyUI(navbarPage("U.S. Immigration data", 
  tabPanel("homepage",
    titlePanel("Introduction"),
    sidebarLayout(
      mainPanel(
        p("Immigration is such an important aspect of American life, it is an instition that affects us all. Through these tough political times, 
            immigration have become a crucial part of the lives of Americans - both citizens, and immigrants themeslves. The Trump administration 
            particularly has put a negative connotation on the word 'immigrant'; claiming that immigrants coming into the U.S. (especially from Mexico), 
            are contributing to the nation's most pressing issues (such as drug epidemics, loss of jobs, more crime, etc). This app is an exploration of
            analyzing facts through true statistics, and seeing the effects of the current situation on countless individuals seeking the American dream.
            Using data gathered from the Department of Homeland Security (DHS) and the Bureau of Justice, we have formulated a holistic study of immigration 
            trends in the U.S., with a specific emphasis on Mexico."
        ),
        p("Through our research, we've found that there are different types of statuses immigrants can have. Each of which the Department of Homeland Security
            had different data sets for:"
        ), 
        p(strong("Returned: "), "A returned immigrant is one who has voluntarily returned to their home country after their access into the U.S. has been denied,
                                or their visa expired. As a returned immigrant they waive their right to a formal proceeding, or in response to a removal proceeding."
        ),
        p(strong("Removed: "), "A removed immigrant is one who has been determined as deportable (like a returned immigrant) but has not decided to leave the U.S. 
                                voluntarily, meaning they could be subject to administrative penalties and may face criminal charges upon re-entry. The DHS data set
                                on removed immigrants includes numbers on those who did have a criminal record upon removal, and those who did not."
        ),
        p(strong("Apprehended: "), "An apprehension is an action taken by law enforcement agency to take physical control of a person. If one individual is apprehended 
                                    more than once in one given year, it is counted twice in the data set"),
        p(strong("Determined Inadmissable: "), "An immigrant may be denied access to the U.S. at a port of entry for not meeting criteria for admission. Once given this 
                                                status, they may be placed in removal proceedings or given the opportunity to withdraw their application.")
      ),
      sidebarPanel(
        helpText("here are some links to our sources:",
                 br(),
                 a("Full glossary of terms", 
                   href = "https://www.dhs.gov/immigration-statistics/data-standards-and-definitions/definition-terms",
                   target = "_blank"),
                 br(),
                 a("Webpage with original datasets from DHS",
                   href = "https://www.dhs.gov/immigration-statistics/enforcement-actions#",
                   target = "_blank"),
                 br(),
                 a("DHS frequently asked questions",
                   href = "https://www.dhs.gov/immigration-statistics/FAQs",
                   target = "_blank")
        )
      )
    )
  ),
  tabPanel("World map",
    titlePanel("Mapping removed immigrants based on criminal background"),
    sidebarLayout(
      sidebarPanel(
        selectInput("status", "Select criminal status:", 
                    choices = list("Criminal" = "criminal", "Non-criminal" = "noncriminal")
        ),
        selectInput("year", "Select year:",
                     choices = list("2006" = 1, "2007" = 2, "2008" = 3, "2009" = 4, "2010" = 5, "2011" = 6, "2012" = 7, 
                                    "2013" = 8, "2014" = 9, "2015" = 10)
        ),
        sliderInput("max", "Select maximum amount to display:", 
                     min = 0, max = 100000, value = 100000
        ), 
        helpText("Helps get rid of outliers to look at more minute relationships between countries"
        )
      ),
      mainPanel(
        plotlyOutput("map"),
        p("All of the datasets are arranged by individual country, thus we wanted to take advantage of this by visualizing the geographic distribution 
          of immigrants removed from the U.S.. The 'removed' dataset is the only one that differentiates between immigrants who did and did not have a 
          criminal background, this plot accounts for that difference. You can use the widget to choose precisely which immigrant status to view and analyze. 
          One very telling observation we made was that of the outliers. Mexico is an incredibly extreme variable, which ofset the entire visualization. 
          This is why we included the slider to set the maximum number of immigrants to see removed to a given country. This allows us to look at smaller differnces
          between countries. After removing Mexico from the mix, neighboring Central American countries emerge as the nearest outliers."
        )
      )
    )
  ),
  tabPanel("Returned",
    titlePanel("Returned Immigrants by Region"),
     sidebarLayout(
       #Define the sidebar with two inputs
       sidebarPanel(
        selectInput("n", "Year:",
              choices=colnames(returns)),
              selectInput('color', label = 'Color', choices = list("Black" = 'black', 'Gold' = 'gold', 'Purple' = 'purple')),
              br(),
              helpText("Data Immigration")
        ),
       mainPanel(
         plotOutput("returnplot")
       )
     )
   ),
   tabPanel("Removed",
            titlePanel("Removed Immigrants by Region"),
            sidebarLayout(
  
              # Define the sidebar with two inputs
              sidebarPanel(
                selectInput("g", "Year:",
                            choices=colnames(removes)),
                selectInput('color', label = 'Color', choices = list("Black" = 'black', 'Gold' = 'gold', 'Purple' = 'purple')),
  
                hr(),
                helpText("Data Immigration")
              ),
              mainPanel(
                plotOutput("removeplot")
              )
            )
  )
))
