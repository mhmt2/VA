library(shiny)
library(plotly)
library(tidyverse)

ui <- navbarPage(
  "Welcome to TimeVA",
  tabPanel("Data Import", "one"),
  navbarMenu("IDEA", 
             tabPanel("Time-series line graph", "L graph"),
             tabPanel("Horizon graph", "H graph")
  ),
  tabPanel("Time-series Analysis", "TSA"),
  navbarMenu("Time-series forecasting", 
             tabPanel("Exponential Smoothing", "ES"),
             tabPanel("ARIMA", "ARIMA"),
             tabPanel("Automatic", "auto")
  )
)

server <- function(input, output) {}


shinyApp(ui = ui, server = server)
