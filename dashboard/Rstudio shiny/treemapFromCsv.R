library(shiny)
library(treemap)

# Define UI
ui <- fluidPage(
  titlePanel("Treemap Generator"),
  mainPanel(
    plotOutput("treemap1"),
    plotOutput("treemap2") # New plotOutput for the second treemap
  )
)

# Define server logic
server <- function(input, output, session) {
  # Read first CSV file
  data1 <- reactive({
    read.csv("data/question1RedditData.csv")
  })
  
  # Read second CSV file
  data2 <- reactive({
    read.csv("data/question1TwitterData") # Adjust the file path as needed
  })
  
  # Update column choices for the first treemap
  observe({
    if (!is.null(data1())) {
      updateSelectInput(session, "company", choices = names(data1()), selected = names(data1())[1])
      updateSelectInput(session, "count", choices = names(data1()), selected = names(data1())[2])
    }
  })
  
  # Update column choices for the second treemap
  observe({
    if (!is.null(data2())) {
      updateSelectInput(session, "company2", choices = names(data2()), selected = names(data2())[1])
      updateSelectInput(session, "count2", choices = names(data2()), selected = names(data2())[2])
    }
  })
  
  # Render first treemap
  output$treemap1 <- renderPlot({
    req(data1())
    tm <- treemap(data1(), index = "company", vSize = "count")
    print(tm)
  })
  
  # Render second treemap
  output$treemap2 <- renderPlot({
    req(data2())
    tm <- treemap(data2(), index = "company2", vSize = "count2")
    print(tm)
  })
}

shinyApp(ui = ui, server = server)

