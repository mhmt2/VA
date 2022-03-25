library(shiny)
library(plotly)
library(tidyverse)

exam <- read_csv("data/Exam_data.csv")

ui <- fluidPage(
  titlePanel("Dual Plots Drill-down Bar Chart"),
  mainPanel(
    fluidRow(
      column(6, #must add up to 12
             plotlyOutput(
               outputId="race", 
               width="300px",
               height="300px")),  
      column(6,
             plotlyOutput(
               outputId="gender", 
               width="300px",
               height="300px"))
    )
  )
)


server <- function(input, output) {
  output$race <- renderPlotly({
    p <- exam %>%
      plot_ly(x = ~RACE)
    
    })
    
    output$gender <- renderPlotly({
      d <- event_data("plotly_click") #event data doesnt understand ggplotly. only plot_ly
      if (is.null(d)) return(NULL) #if dont click anything it will not going to do anything
    
      p <- exam %>%
        filter(RACE %in% d$x) %>%
        ggplot(aes(x=GENDER)) +
        geom_bar() 
      ggplotly(p) %>%
        layout(xaxis = list(title = d$x))
    })
    
    output$info <- renderPrint({
      event_data("plotly_click")
    })    
    
}


shinyApp(ui = ui, server = server)
