library(shiny)
library(dplyr)
library(treemap)
library(ggplot2)  # Add this line to load ggplot2

# Define UI
# Define UI
ui <- fluidPage(
  
  titlePanel("Treemap Viewer"),
  
  sidebarLayout(
    sidebarPanel(
      # Sidebar content, if any
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Treemap 1", plotOutput("treemap1")),
        tabPanel("Treemap 2", plotOutput("treemap2")),
        tabPanel("Pyramid 1", plotOutput("pyramidPlot")),
        tabPanel("Pyramid 2", plotOutput("pyramidPlot2"))
      )
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Read CSV files
  dataset1 <- reactive({
    read.csv("data/question1RedditData.csv")
  })
  
  dataset2 <- reactive({
    read.csv("data/question1TwitterData.csv")
  })
  
  
    dataRedditTwitterMergeQuestion1 <- reactive({
      read.csv("data/question1reddit_twitter_counts_normalized_cut20.csv")
    })
  
  # Render treemaps
  output$treemap1 <- renderPlot({
    treemap(dataset1(), index=c("company"), vSize="count")
  })
  
  output$treemap2 <- renderPlot({
    treemap(dataset2(), index=c("company"), vSize="count")
  })
  
  
  output$pyramidPlot <- renderPlot({
    req(dataRedditTwitterMergeQuestion1())  # Assuming this function exists
    ggplot(dataRedditTwitterMergeQuestion1(), aes(x = company, y = redditCount, fill = company)) +
      geom_bar(stat = "identity", position = "dodge") +
      geom_bar(aes(y = -twitterCount), stat = "identity", position = "dodge") +
      coord_flip() +
      labs(title = "Reddit and Twitter Counts by Company",
           x = "Company", y = "Count") +
      theme_minimal()
  })
  output$pyramidPlot2 <- renderPlot({
    req(dataRedditTwitterMergeQuestion1())  # Assuming this function exists
    ggplot(dataRedditTwitterMergeQuestion1(), aes(x = company, y = redditCount, fill = company)) +
      geom_bar(stat = "identity", position = "dodge") +
      geom_bar(aes(y = -twitterCount), stat = "identity", position = "dodge") +
      coord_flip() +
      labs(title = "Reddit and Twitter Counts by Company",
           x = "Company", y = "Count") +
      theme_minimal()
  })
}

# Run the application
shinyApp(ui = ui, server = server)
