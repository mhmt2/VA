library(shiny)
library(tidyverse)
library(tools)
library(plotly)

exam <- read_csv("data/Exam_data.csv")
#print(exam) to check data on server side 

ui <- fluidPage(
  titlePanel("Subject Correlation Analysis"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "yvariable", #ID should be unique
                  label = "y Variable:",
                  choices = c("English" = "ENGLISH",
                              "Maths" = "MATHS",
                              "Science" = "SCIENCE"),
                  selected = "MATHS"), #default option
      
      selectInput(inputId = "xvariable",
                  label = "x Variable:",
                  choices = c("English" = "ENGLISH",
                              "Maths" = "MATHS",
                              "Science" = "SCIENCE"),
                  selected = "SCIENCE"),
      
      #textInput(
      #  inputId = "plot_title",
      #  label = "Plot title",
      #  placeholder = "Enter text to be used as plot title"),
      #actionButton("goButton", "Go!")
      
    ),
    mainPanel(
      plotlyOutput("scatterPlot") #unique name
    )
  )
)

server <- function(input, output){
  output$scatterPlot <- renderPlotly({
    #input$goButton
    
    p <- ggplot(data=exam,
                aes_string(x = input$xvariable,
                           y = input$yvariable)) +
      
      geom_point(color="grey 10", 
                 size=1) 
    ggplotly(p)
    
      #labs(title = isolate({
       # toTitleCase(input$plot_title)
      #}))
    
  })
}

shinyApp(ui = ui, server = server)
