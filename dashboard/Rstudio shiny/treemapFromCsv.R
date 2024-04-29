library(shiny)
library(treemap)

# Define UI
ui <- fluidPage(
  titlePanel("Treemap Generator"),
  mainPanel(
    plotOutput("treemapReddit")
  )
)

# Define server logic
server <- function(input, output, session) {
  # Read CSV file
  dataReddit <- reactive({
    read.csv("data/question1RedditData.csv")
  })
  
  # Update column choices
  observe({
    if (!is.null(dataReddit())) {
      updateSelectInput(session, "companyReddit", choices = names(dataReddit()), selected = names(dataReddit())[1])
      updateSelectInput(session, "countReddit", choices = names(dataReddit()), selected = names(dataReddit())[2])
    }
  })
  
  # Render treemap
  output$treemapReddit <- renderPlot({
    req(dataReddit())
    tm <- treemap(dataReddit(), index = "company", vSize = "count")
    print(tm)
  })
}

shinyApp(ui = ui, server = server)

