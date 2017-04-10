library(shiny)

shinyUI(
  fluidPage(
    titlePanel("Interactive Cluster Analysis using IRIS Data"),
    sidebarLayout(
      sidebarPanel(
        helpText("This application allows the user to interactively try various combinations of predictors to predict the species of a single data point"),
        helpText(""),
        helpText("Pick the X axis variable and Y Axis variable from the dropdown"),
        helpText("The server will run clustering algorithm on the selected dataset"),
        helpText("The shape of the datapoint is the actual species. The color of the datapoint is the cluster to which that point belongs"),
        selectInput("xvar", "Plot variable for X Axis", head(names(iris),4)),
        selectInput("yvar", "Plot variable for Y Axis", head(names(iris),4))
      ),
      mainPanel(        
        plotOutput("plot1")
      )    
    )
  )
)

