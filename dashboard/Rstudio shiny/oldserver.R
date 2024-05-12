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

  # Load data for Question 3
  
  question3datasetTwitter <- reactive({
    req(file.exists("data/question3discoveryTwitterFiltered.csv"))
    read.csv("data/question3discoveryTwitterFiltered.csv")
  })
  
  question3datasetDevTo <- reactive({
    req(file.exists("data/question3discoveryDevToFiltered.csv"))
    read.csv("data/question3discoveryDevToFiltered.csv")
  })
  
  question3datasetReddit <- reactive({
    req(file.exists("data/question3discoveryRedditFiltered.csv"))
    read.csv("data/question3discoveryRedditFiltered.csv")
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
  
  # Render plot for Question 3
  output$question3BarPlot <- renderPlot({
    req(input$question3Dataset)  # Ensure dataset is selected
    
    dataset <- switch(input$question3Dataset,
                      "Twitter" = question3datasetTwitter(),
                      "DevTo" = question3datasetDevTo(),
                      "Reddit" = question3datasetReddit())
    
    ggplot(dataset, aes(x = name, y = mention, fill = input$question3Dataset)) +
      geom_bar(stat = "identity") +
      labs(x = "Technology", y = "Number of Mentions") +
      scale_fill_manual(values = c("Twitter" = "red", "DevTo" = "blue", "Reddit" = "green")) + # Specify colors
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
  
  observeEvent(input$question3, {
    output$mainPanelContent <- renderUI({
      tagList(
        selectInput("question3Dataset", "Select Dataset", choices = c("Twitter", "DevTo", "Reddit")),
        plotOutput("question3BarPlot")
      )
    })
  })

}
