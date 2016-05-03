
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output, session) {
  
  colSch <- reactiveValues(pc = "rainbow")

  output$eFrac <- renderPlot({
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
    if (input$num > 0) {
      pcols1 <- mycols[1:input$num]
      pcols2 <- rep(pcols1, each = input$mult)
    } else {
      pcols1 <- NULL
      pcols2 <- NULL
    }
    
    
    plot.new()
    plot.window(xlim = c(0, 1.5), ylim = c(0, 1.5), xaxs = "i", yaxs = "i")
    if (top <= bot) {
      rect(0, seq(0, 1-1/input$den, length.out = input$den), 0.7,
           seq(1/input$den, 1, length.out = input$den),
           col = c(pcols1, rep("white", input$den - input$num)))
#       if (input$mult == 1) {
#         text(0.35, 1.25, paste0(input$num, "/", input$den), cex = 4)
#       } else if (input$mult > 1) {
        rect(0.8, seq(0, 1-1/bot, length.out = bot), 1.5,
             seq(1/bot, 1, length.out = bot),
             col = c(pcols2, rep("white", bot - top)))
        text(0.75, 1.25, paste0(input$num, "/", input$den, " = ", top, "/", bot),
             cex = 4)
      # }
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
