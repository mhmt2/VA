library(shiny)


ui <- fluidPage()


server <- function(input, output) {
  output$map
# tmap_options(check.and.fix = TRUE) # to make sure polygons don't give issue
  
  
}


shinyApp(ui = ui, server = server)
