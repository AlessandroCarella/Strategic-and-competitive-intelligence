library(shiny)

# Define UI
source("ui.R", local = TRUE, force=TRUE)
source("server.R",local=TRUE, force= TRUE)

# Run the application
shinyApp( ui=ui,server=server)
