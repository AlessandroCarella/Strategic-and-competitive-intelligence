library(shiny)
library(treemap)
library(DT)
library(ggplot2)
library(shinydashboard)
library(dplyr)

server <- function(input, output) {
  # Load data for Question 1
  datasetTwitter <- reactive({
    req(file.exists("data/question1TwitterData.csv"))
    read.csv("data/question1TwitterData.csv")
  })
  
  datasetReddit <- reactive({
    req(file.exists("data/question1RedditData.csv"))
    read.csv("data/question1RedditData.csv")
  })
  
  dataRedditTwitterMergeOrderedTwitterQuestion1 <- reactive({
    req(file.exists("data/question1reddit_twitter_counts_normalized_cut20_ordered_twitter.csv"))
    read.csv("data/question1reddit_twitter_counts_normalized_cut20_ordered_twitter.csv")
  })
  
  dataRedditTwitterMergeOrderedRedditQuestion1 <- reactive({
    req(file.exists("data/question1reddit_twitter_counts_normalized_cut20_ordered_reddit.csv"))
    read.csv("data/question1reddit_twitter_counts_normalized_cut20_ordered_reddit.csv")
  })

  
  # Render plots
  output$treemapTwitter <- renderPlot({
    treemap(datasetTwitter(), index=c("company"), vSize="count")
  })
  
  output$treemapReddit <- renderPlot({
    treemap(datasetReddit(), index=c("company"), vSize="count")
  })
  
  output$pyramidPlotOrderedTwitter <- renderPlot({
    ggplot(dataRedditTwitterMergeOrderedTwitterQuestion1(), aes(x = company, y = redditCount, fill = company)) +
      geom_bar(stat = "identity", position = "dodge") +
      geom_bar(aes(y = -twitterCount), stat = "identity", position = "dodge") +
      coord_flip() +
      labs(title = "Reddit and Twitter Counts by Company (most frequent ordered by twitter)",
           x = "Company", y = "Count") +
      theme_minimal()
  })
  
  output$pyramidPlotOrderedReddit <- renderPlot({
    ggplot(dataRedditTwitterMergeOrderedRedditQuestion1(), aes(x = company, y = redditCount, fill = company)) +
      geom_bar(stat = "identity", position = "dodge") +
      geom_bar(aes(y = -twitterCount), stat = "identity", position = "dodge") +
      coord_flip() +
      labs(title = "Reddit and Twitter Counts by Company (most frequent ordered by reddit)",
           x = "Company", y = "Count") +
      theme_minimal()
  })
  
  
  # UI for main panel content
  mainPanelContentQuestion1 <- reactive({
    tagList(
      tabsetPanel(
        tabPanel("Treemap Twitter", plotOutput("treemapTwitter")),
        tabPanel("Treemap Reddit", plotOutput("treemapReddit")),
        tabPanel("Pyramid plot ordered Twitter", plotOutput("pyramidPlotOrderedTwitter")),
        tabPanel("Pyramid plot ordered Reddit", plotOutput("pyramidPlotOrderedReddit"))
      )
    )
  })
  
  observeEvent(input$question1, {
    output$mainPanelContent <- renderUI({
      mainPanelContentQuestion1()
    })
  })
  
  observeEvent(input$question2, {
    output$mainPanelContent <- renderUI({
      #TODO
    })
  })
  
}
