library(shiny)

shinyServer(function(input, output) {
  myData <- reactive({
    iris[,c(input$xvar, input$yvar)]
  })
  
  kmean_cluster <- reactive({
    kmeans(myData(), 3)
  })
  
  output$plot1 <- renderPlot({
    plot(myData(), pch=c(21,22,24)[unclass(iris$Species)], bg=c("red","blue","green")[kmean_cluster()$cluster], cex=2)
    points(kmean_cluster()$center, pch=4,cex=4,lwd=4)
    legend("bottomright", legend=levels(iris$Species), pch=c(21,22,24),cex=1)
  })
    
})
