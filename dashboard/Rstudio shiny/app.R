library(shiny)

# Define UI
source("ui_question1.R")
source("server_question1.R")

# Run the application
shinyApp(ui = ui_question1, server = server_question1)
