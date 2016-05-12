
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)
library(plyr)

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

shinyServer(function(input, output) {

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

})
