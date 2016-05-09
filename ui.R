library(shiny)

shinyUI(fluidPage(
  includeCSS("www/stylinSoTight.css"),
  
  # Application title
  titlePanel("Learn about fractions!"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("num", "Numerator:", ticks = F,
                  min = 0, max = 15, value = 4),
      sliderInput("den", "Denominator:",
                  min = 1, max = 15, value = 5),
      sliderInput("mult", "Multiplication factor", min = 1, max = 5, value = 1),
      actionButton("diffCols", "Change color scheme")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Equivalent fractions",
                 htmlOutput("eFracTxt"),
                 plotOutput("eFrac", width = "600px", height = "500px")),
        tabPanel("Improper fractions",
                 htmlOutput("iFracTxt"),
                 plotOutput("iFrac", width = "600px", height = "500px")),
        id = "fracType"
      )
    )
  )
))
