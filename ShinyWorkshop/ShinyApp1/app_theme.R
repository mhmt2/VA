library(shiny)
library(tidyverse)
library(bslib)

thematic::thematic_shiny() #if want to customise alot, can use library(thematic) but if just want to call one function, can do ::

exam <- read_csv("data/Exam_data.csv")

ui <- fluidPage(
  theme = bs_theme(bootswatch = "cyborg"),
  titlePanel("Pupils Examination Results Dashboard"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "variable", #inputID has to be unique
                  label = "Subject:",
                  choices = c("English" = "ENGLISH",
                              "Maths" = "MATHS",
                              "Science" = "SCIENCE"),
                  selected = "ENGLISH"), #default choice
      sliderInput(inputId = "bins",
                  label = "Number of Bins",
                  min = 5,
                  max = 20,
                  value= 10) #default value
    ),
    mainPanel(
      plotOutput("distPlot"), #unique name. outputID
      DT::dataTableOutput(outputId = "examtable")
    )
  )
) 

server <- function(input, output){
  bs_themer()
  output$distPlot <- renderPlot({
  #  x <- unlist(exam[,input$variable]) # if choices is for multiple columns, define new parameter. want all rows and columns as variable. This is a quick fix
    
    
    ggplot(exam, aes_string(x = input$variable)) + #x axis label will now appear as input$variable
      geom_histogram(bins = input$bins, #name must be exact
                     color="black",
                     fill="light blue")
  })
  
  
  
} #server is a function. want to ask it to do something e.g. do a plot

shinyApp(ui=ui, server=server) #basis of shiny app. reactive

