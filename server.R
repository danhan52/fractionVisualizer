
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output, session) {
  
  colSch <- reactiveValues(pc = "rainbow")

  output$fraction <- renderPlot({
    plot.new()
    plot.window(xlim = c(0, 0.5), ylim = c(0, 1), xaxs = "i", yaxs = "i")
    top <- input$num * input$mult
    bot <- input$den * input$mult
    if (colSch$pc == "rainbow") {
      mycols <- rainbow(input$den, start = 0, end = 0.8)
    } else if (colSch$pc == "everyOther") {
      mycols <- rep(c("green", "red"), floor(input$den/2))
      if (input$den %% 2 != 0) {
        mycols <- c(mycols, "green")
      }
    }
    pcols <- rep(mycols[1:input$num], each = input$mult)
    
    if (top <= bot) {
      rect(0, seq(0, 1-1/bot, length.out = bot), 0.5,
           seq(1/bot, 1, length.out = bot),
           col = c(pcols, rep("white", bot - top)))
    }
  })
  
  output$numba <- renderText({
    if (input$mult == 1) {
      paste0(input$num, "/", input$den)
    } else {
      top <- input$num * input$mult
      bot <- input$den * input$mult
      paste0(top, "/", bot, " = ", input$num, "/", input$den)
    }
  })
  
  observe({
    updateSliderInput(session, "num", max = input$den, step = 1)
  })
  
  observeEvent(input$diffCols, {
    if (colSch$pc == "rainbow") {
      colSch$pc <- "everyOther"
    } else if (colSch$pc == "everyOther") {
      colSch$pc <- "rainbow"
    } 
  })

})
