library(shiny)
library(treemap)

# Define UI
ui <- fluidPage(
  titlePanel("Treemap Generator"),
  mainPanel(
    plotOutput("treemapReddit"),
    plotOutput("treemapTwitter")
  )
)

# Define server logic
server <- function(input, output, session) {
  # Read CSV file
  dataReddit <- reactive({
    read.csv("data/question1RedditData.csv")
  })
  dataTwitter <- reactive({
    read.csv("data/question1TwitterData.csv")
  })
  
  # Update column choices
  observe({
    if (!is.null(dataReddit())) {
      updateSelectInput(session, "companyReddit", choices = names(dataReddit()), selected = names(dataReddit())[1])
      updateSelectInput(session, "countReddit", choices = names(dataReddit()), selected = names(dataReddit())[2])
    }
    if (!is.null(dataTwitter())) {
      updateSelectInput(session, "companyTwitter", choices = names(dataTwitter()), selected = names(dataTwitter())[1])
      updateSelectInput(session, "countTwitter", choices = names(dataTwitter()), selected = names(dataTwitter())[2])
    }
  })
  
  # Render treemap
  output$treemapReddit <- renderPlot({
    req(dataReddit())
    tm <- treemap(dataReddit(), index = "company", vSize = "count")
    print(tm)
  })
  output$treemapTwitter <- renderPlot({
    req(dataTwitter())
    tm <- treemap(dataTwitter(), index = "company", vSize = "count")
    print(tm)
  })
}

shinyApp(ui = ui, server = server)

