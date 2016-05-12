
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)
library(plyr)

## defining the functions that are used in the app, first the saveData function to save the data from the sliders and then the circle function that is used to generate the points

outputDir <- "responses"
fields <- c("slide")

saveData <- function(data) {
  data <- t(data)
  # Create a unique file name
  fileName <- sprintf("%s_%s.csv", as.integer(Sys.time()), digest::digest(data))
  # Write the file to the local system
  write.csv(
    x = data,
    file = file.path(outputDir, fileName), 
    row.names = FALSE, quote = TRUE
  )
}

circleFun <- function(center = c(0,0),diameter = 1, npoints = 100){
  r = diameter / 2
  tt <- seq(0,2*pi,length.out = npoints)
  xx <- center[1] + r * cos(tt)
  yy <- center[2] + r * sin(tt)
  return(data.frame(xx = xx, yy = yy))
}


x <- 1:500
y   <- runif(500,0,1)
z   <- runif(500,0,1)
theta <- runif(500,0,360)
ycoor <- y * cos(theta)
zcoor <- z * sin(theta)

##origin, diameter and points
cir <- circleFun(c(0,0),2,npoints = 500)
test <- cbind.data.frame(x, y, z,ycoor,zcoor, theta, cir)

shinyServer(function(input, output, session) {

  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
  
    # draw the histogram with the specified number of bins
##    p <- ggplot(subset(test, x < input$slide), aes(ycoor,zcoor))
##    p + geom_jitter(size=5) + coord_fixed(ratio = 1) + stat_ellipse(type="euclid", level=1.01)
  
    
    ## this is extra junk but it will gradually draw a circle as it adds points  
    # p <- ggplot(subset(test, x < input$slide), aes(ycoor,zcoor))
    # p + geom_point(size=4) + coord_fixed(ratio = 1) + geom_path(aes(xx, yy))
    
    p <- ggplot(test, aes(ycoor,zcoor))
    p + geom_point(data=subset(test, x < input$slide), size=4) + coord_fixed(ratio = 1) + geom_path(aes(xx, yy)) + scale_x_continuous(name="", breaks=NULL) +
      scale_y_continuous(name="", breaks=NULL) + theme(
      axis.text.x = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks = element_blank())
  })
  
  formData <- reactive({
    data <- sapply(fields, function(x) input[[x]])
    data
  })
  
  # When the Submit button is clicked, save the form data
  observeEvent(input$submit, {
    saveData(formData())
  })
   }
)

