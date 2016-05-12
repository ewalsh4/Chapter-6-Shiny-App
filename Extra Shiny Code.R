

## junk code 
library(shiny)
##runExample()
##runExample("05_sliders")


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


p <- ggplot(subset(test), aes(ycoor,zcoor))
p + geom_point(size=4) + coord_fixed(ratio = 1) + geom_path(aes(xx, yy))







