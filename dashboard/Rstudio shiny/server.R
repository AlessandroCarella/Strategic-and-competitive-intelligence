library(shiny)
library(treemap)
library(DT)
library(ggplot2)
library(shinydashboard)
library(dplyr)

server <- function(input, output) {
  output$textOutput1Question1 <- renderText({
    "The first question we wanted to answer was\n
    What organizations are mentioned most often in the genAI for coding public discourse?"
  })
  
  
  datasetTwitter <- reactive({
    read.csv("data/question1TwitterData.csv")
  })
  output$treemapTwitter <- renderPlot({
    treemap(datasetTwitter(), index=c("company"), vSize="count")
  })
  datasetReddit <- reactive({
    read.csv("data/question1RedditData.csv")
  })
  output$treemapReddit <- renderPlot({
    treemap(datasetReddit(), index=c("company"), vSize="count")
  })
  
  
  dataRedditTwitterMergeOrderedTwitterQuestion1 <- reactive({
    read.csv("data/question1reddit_twitter_counts_normalized_cut20_ordered_twitter.csv")
  })
  output$pyramidPlotOrderedTwitter <- renderPlot({
    req(dataRedditTwitterMergeOrderedTwitterQuestion1())  # Assuming this function exists
    ggplot(dataRedditTwitterMergeOrderedTwitterQuestion1(), aes(x = company, y = redditCount, fill = company)) +
      geom_bar(stat = "identity", position = "dodge") +
      geom_bar(aes(y = -twitterCount), stat = "identity", position = "dodge") +
      coord_flip() +
      labs(title = "Reddit and Twitter Counts by Company (most frequent ordered by twitter)",
           x = "Company", y = "Count") +
      theme_minimal()
  })
  dataRedditTwitterMergeOrderedRedditQuestion1 <- reactive({
    read.csv("data/question1reddit_twitter_counts_normalized_cut20_ordered_reddit.csv")
  })
  output$pyramidPlotOrderedReddit <- renderPlot({
    req(dataRedditTwitterMergeOrderedRedditQuestion1())  # Assuming this function exists
    ggplot(dataRedditTwitterMergeOrderedRedditQuestion1(), aes(x = company, y = redditCount, fill = company)) +
      geom_bar(stat = "identity", position = "dodge") +
      geom_bar(aes(y = -twitterCount), stat = "identity", position = "dodge") +
      coord_flip() +
      labs(title = "Reddit and Twitter Counts by Company (most frequent ordered by reddit)",
           x = "Company", y = "Count") +
      theme_minimal()
  })
}