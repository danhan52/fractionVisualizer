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
    plot.window(xlim = c(0, 1.5), ylim = c(0, 1), xaxs = "i", yaxs = "i")
    if (top <= bot) {
      rect(0, seq(0, 1-1/input$den, length.out = input$den), 0.7,
           seq(1/input$den, 1, length.out = input$den),
           col = c(pcols1, rep("white", input$den - input$num)))
        rect(0.8, seq(0, 1-1/bot, length.out = bot), 1.5,
             seq(1/bot, 1, length.out = bot),
             col = c(pcols2, rep("white", bot - top)))
    }
  })
  
  output$eFracTxt <- renderUI({
    top <- input$num * input$mult
    bot <- input$den * input$mult
    HTML(paste0('<div id="numba">', input$num, "/", input$den, " = ", top, "/",
                bot, '</div>'))
  })
  
  output$iFrac <- renderPlot({
    whole <- input$num %/% input$den
    newnum <- input$num %% input$den
    
    plot.new()
    plot.window(xlim = c(0, 5.5), ylim = c(0, 1), xaxs = "i", yaxs = "i")
    for (i in 1:whole) {
      rect(1.1*(i-1), seq(0, 1-1/input$den, length.out = input$den), 1.1*i-0.1,
           seq(1/input$den, 1, length.out = input$den), col = "green")
    }
    
    i <- i+1
    if (newnum > 0 | input$num == 0) { 
      rect(1.1*(i-1), seq(0, 1-1/input$den, length.out = input$den), 1.1*i-0.1,
           seq(1/input$den, 1, length.out = input$den),
           col = c(rep("red", newnum), rep("white", input$den - newnum)))
    }
  })
  
  output$iFracTxt <- renderUI({
    whole <- input$num %/% input$den
    newnum <- input$num %% input$den
    
    # get the first half of the expression
    leftTxt <- paste0(input$num, "/", input$den, " = ")
    # get the whole part of the mixed number
    if (whole == 0) {
      whole <- NULL
    }
    # get the fraction part of the mixed number
    if (input$num == 0) {
      fracTxt <- paste0(input$num, "/", input$den)
    } else if (newnum == 0) {
      fracTxt <- NULL
    } else if (newnum > 0) {
      fracTxt <- paste0(newnum, "/", input$den)
    }
    HTML(paste('<div id="numba">', leftTxt, '<span id="whole">', whole,
               '</span><span id="fracTxt">', fracTxt, '</span></div>'))
  })
  
  observe({
    if (input$fracType == "Equivalent fractions") {
      updateSliderInput(session, "mult", label = "Multiplication factor")
      updateSliderInput(session, "num", max = input$den, step = 1)
    } else if (input$fracType == "Improper fractions") {
      updateSliderInput(session, "mult", label = "Multiplication factor (doesn't do anything)")
      updateSliderInput(session, "num", max = input$den*5, step = 1)
    }
  })
  
  observeEvent(input$diffCols, {
    if (colSch$pc == "rainbow") {
      colSch$pc <- "everyOther"
    } else if (colSch$pc == "everyOther") {
      colSch$pc <- "rainbow"
    } 
  })

})
