
library(shiny)
library(ggplot2)

data(mtcars)
mtcars$cyl<-as.factor(mtcars$cyl)
mtcars$am<-factor(mtcars$am,labels= c('automatic', 'manual'))
mtcars$gear<-as.factor(mtcars$gear)
mtcars$carb<-as.factor(mtcars$carb)
names(mtcars)<-c("mpg","cylinders","displacement","horsepower","axle.ratio","weight","time","V/S","transmission","gears","carburetors")
dataset <- mtcars

shinyUI(navbarPage("1974 Road Testing, Motor Trend Magazine",
        tabPanel("Exploration",
                 fluidPage(
                   plotOutput('plot'),
                   hr(),
                   fixedRow(
                     column(12,
                            fixedRow(
                              column(width = 4,
                                     h4("Axes setup"),
                                     selectInput('x', 'X',names(dataset)[c(-2,-9,-10,-11)],names(dataset)[[6]]),
                                     selectInput('y', 'Y', "mpg"),
                                     selectInput('colour', 'Grouping', c('None', names(dataset)),names(dataset)[[9]])
                                     ),
                              column(width = 4, 
                                     h4("Facet setup"),
                                     selectInput('facet_row', 'Row',
                                                 c(None='.', names(dataset[sapply(dataset, is.factor)]))),
                                     selectInput('facet_col', 'Column',
                                                 c(None='.', names(dataset[sapply(dataset, is.factor)])))
                                     ),
                              column(width = 4,
                                     h4("Options"),
                                     checkboxInput('rug','Data distribution'),
                                     checkboxInput('smooth', 'Fit model'),
                                     conditionalPanel(
                                       condition = "input.smooth == true",
                                       selectInput("smoothMethod", "Pick modelling method",
                                                   list("lm", "glm", "gam", "loess", "rlm"))
                                       )  
                                     )
 
                              )
                            )
                     )
                   )
                 ),
        tabPanel("About",
                 h2("Description"),
                 p("The app uses the mtcars dataset which was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption
                    and 10 aspects of automobile design and performance for 32 automobiles (1973-74 models)."),
                 p("This app displays a point plot (using the ggplot2 libray) enabling the user to explore the design and performance aspects
                    influene on fuel consumption in miles per gallon (mpg)."),
                 h4("Source"),
                 p("Henderson and Velleman (1981). Building multiple regression models interactively. Biometrics, 37: 391-411."),
                 br(),
                 h3("How to use this app"),
                 tags$div(
                   tags$ul(
                     tags$li("Choose the descriptor variable via the 'X' dropdown, default: weight (lb/1000)"),
                     tags$li("The Y axis (responce variable) is limited to miles per gallon (mpg)"),
                     tags$li("Use the 'Grouping' dropdown to decide whether to examine data groupings using colour, default: transmission type"),
                     tags$li("View one or multiple plots by cylinder-, gear-, carburetor- number, or transmission type using the 'Facits' Row and
                             Column dropdowns"),
                     tags$li("View distribution of data points via the 'Data distribution' check box"),
                     tags$li("Option to fit a simple y~x model to the selected data, when grouping/facets selected one model per data subset. 
                             Visulised through predicted fits with 95% confidence intervals. Five methods to choose from:")
                   ),
                   tags$ol(offset=5,
                     tags$li("lm - linear model, default"),
                     tags$li("glm - generalised linear model"),
                     tags$li("gam - generalised additive model"),
                     tags$li("loess - local polynomial regression model"),
                     tags$li("rlm - robust linear model (iterated re-weighted least squares)")
                   )                   
                 ),
                 br(),
                 h2("Enjoy :)")
                 ),
        tabPanel("Code",
                 p("Source code for this app is hosted on GitHub...",
                 a("here", href = "https://github.com/S101/ShinyApp.git"))
                 )
        )
        )

