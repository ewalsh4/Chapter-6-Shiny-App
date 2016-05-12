
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)



shinyUI(  fluidPage(
  DT::dataTableOutput("responses", width = 300), tags$hr(),
  tags$head(tags$style(HTML('.irs-from, .irs-to, .irs-min, .irs-max, .irs-single {
                            visibility: hidden !important;
                            }'))),
  
  # Application title
  titlePanel("Chapter 6 Test"),

  
  fluidRow(
    column(4,
      wellPanel(
      sliderInput("slide", 
                  "Select the Value from Slider", 
                  ticks = F,
                  min = 1, 
                  max = 500, 
                  value = 0)
      ),
      actionButton("submit","submit")
    ),


    # Show a plot of the generated distribution
    column(8,
      plotOutput("distPlot")
    )
  )
))
