
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)

shinyUI(  fluidPage(
  tags$head(tags$style(HTML('.irs-from, .irs-to, .irs-min, .irs-max, .irs-single {
                            visibility: hidden !important;
                            }'))),
  
  # Application title
  titlePanel("Chapter 6 Test"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("slide", 
                  "Select the Value from Slider", 
                  ticks = F,
                  min = 1, 
                  max = 500, 
                  value = 0)
    ),
    junk

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))
