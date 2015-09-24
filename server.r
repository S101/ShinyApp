library(shiny)
library(ggplot2)

cols<-c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
          "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999")

data(mtcars)
mtcars$cyl<-as.factor(mtcars$cyl)
mtcars$am<-factor(mtcars$am,labels= c('automatic', 'manual'))
mtcars$gear<-as.factor(mtcars$gear)
mtcars$carb<-as.factor(mtcars$carb)
names(mtcars)<-c("mpg","cylinders","displacement","horsepower","axle.ratio","weight","time","V/S","transmission","gears","carburetors")
dataset <- mtcars


shinyServer(
  function(input, output) {
    output$plot <- renderPlot({
      p <- ggplot(dataset, aes_string(x=input$x, y=input$y)) + geom_point(size = 3) 
      if (input$colour != 'None') {
          p <- p + aes_string(colour=input$colour)  
          if(input$colour%in%c("cylinders","transmission","gears","carburetors")) {
             p <- p + scale_colour_brewer(palette="Set1")
             } else {
             p <- p + scale_colour_continuous(low="red", high = "green")
             }
          }
      facets <- paste(input$facet_row, '~', input$facet_col)
      if (facets != '. ~ .')
          p <- p + facet_grid(facets)
      if (input$smooth) 
            p <- p + geom_smooth(method = input$smoothMethod)
      if (input$rug)
        p <- p + geom_rug(sides="b")    
      print(p)
    })

  }
)

