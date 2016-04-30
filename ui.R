
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
  includeCSS("www/stylinSoTight.css"),
  
  # Application title
  titlePanel("Fraction demonstration"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("num", "Numerator:", ticks = F,
                  min = 1, max = 15, value = 4),
      sliderInput("den", "Denominator:",
                  min = 1, max = 15, value = 5),
      sliderInput("mult", "Multiplication factor", min = 1, max = 5, value = 1),
      actionButton("diffCols", "Change color scheme")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      textOutput("numba"),
      plotOutput("fraction", width = "200px", height = "400px")
    )
  )
))
