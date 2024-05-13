library(shiny)
library(plotly)
library(wordcloud2)
library(ggrepel)
library(ggplot2)
library(ggwordcloud)
library(treemap)
# Define a server for the app
shiny::shinyServer(function(input, output, session) {
  
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
  
  #Load data for Question 2
  question2datasetDevTo <- reactive({
    req(file.exists("data/question2discoveryDevToFiltered.csv"))
    read.csv("data/question2discoveryDevToFiltered.csv")
  })
  
  # Load data for Question 3
  
  question3datasetTwitter <- reactive({
    req(file.exists("data/question3discoveryTwitterFiltered.csv"))
    read.csv("data/question3discoveryTwitterFiltered.csv")
  })
  question3datasetTwitterFull <- reactive({
    req(file.exists("data/question3discoveryTwitterFull.csv"))
    read.csv("data/question3discoveryTwitterFull.csv")
  })
  
  question3datasetDevTo <- reactive({
    req(file.exists("data/question3discoveryDevToFiltered.csv"))
    read.csv("data/question3discoveryDevToFiltered.csv")
  })
  
  question3datasetReddit <- reactive({
    req(file.exists("data/question3discoveryRedditFiltered.csv"))
    read.csv("data/question3discoveryRedditFiltered.csv")
  })

  # Load data for Question 4
  
  question4datasetDevto2022 <- reactive({
    req(file.exists("data/question4_devto_2022.csv"))
    read.csv("data/question4_devto_2022.csv")
  })
  question4datasetDevto2023 <- reactive({
    req(file.exists("data/question4_devto_2023.csv"))
    read.csv("data/question4_devto_2023.csv")
  })
  
  question4datasetStackOverflow2022 <- reactive({
    req(file.exists("data/question4stackoverflow_2022.csv"))
    read.csv("data/question4stackoverflow_2022.csv")
  })
  
  question4datasetStackOverflow2023 <- reactive({
    req(file.exists("data/question4stackoverflow_2023.csv"))
    read.csv("data/question4stackoverflow_2023.csv")
  })
  


  
  # Create the questions box
  output$questionBox <- shiny::renderUI({
    shinydashboard::valueBox(
      6,
      "Questions",
      icon = shiny::icon("question-circle"),
      color = "green"
    )
  })

  # Create the datasets box
  output$datasetBox <- shiny::renderUI({
    shinydashboard::valueBox(5,
                             "Datasets",
                             icon = shiny::icon("database"),
                             color = "aqua")
  })

  
  
  #QUESTION 1
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
  output$mainPanelContent <- renderUI({
    mainPanelContentQuestion1()
  })
  
  #QUESTION 2
  
  # Show Q2 data table
  output$q2Table <- DT::renderDataTable({
    
    # Load the dataset based on user selection or default to Twitter if none selected
    dataset <- switch(ifelse(is.null(input$question2DatasetTable) || input$question2DatasetTable == "", "Dev.To", input$question2DatasetTable),
                      #"Twitter" = question2datasetTwitterFull(),
                      "Dev.To" = question2datasetDevTo())
    
    
    DT::datatable(
      dataset,
      rownames = FALSE,
      colnames = c('Opinion/Sentiments','Number of Mentions'),
      extensions = c('Responsive', 'Buttons'),
      options = list(
        searchHighlight = TRUE,
        dom = 'Bfrtip',
        buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
        title= paste(input$question2DatasetTable, " Dataset")
      )
    )
  }, server = FALSE)
  
  output$selectedDatasetq2 <- renderUI({
    selected_dataset <- input$question2DatasetTable
    h2(paste(selected_dataset, " Dataset"))
  })
  
  plot_data_q2 <- reactiveValues(plot_type = "barplot")
  plot_visibility_q2 <- reactiveValues(treemap = FALSE, barplot=TRUE)
  
  
  output$q2dynamicplot <- renderPlotly({
    if (is.null(plot_data_q2$plot_type)) {
      return(NULL)  # No plot selected yet
    }
    # Load the dataset based on user selection or default to Twitter if none selected
    dataset <- switch(ifelse(is.null(input$question2Dataset) || input$question2Dataset == "", "Dev.To", input$question2Dataset),
                      #"Twitter" = question2datasetTwitter(),
                      "Dev.To" = question2datasetDevTo())
    
    if (plot_data_q2$plot_type == "treemap") {
      if (plot_visibility_q2$treemap) {
        treemap_data <- dataset
        print(treemap_data)
        p <- plot_ly(
          data = treemap_data,
          ids = ~name,
          labels = ~name,
          parents = ~"",
          values = ~mention,
          type = "treemap",
          hoverinfo = "label+value+percent root",
          treemapcolorway = c("white"),
          marker = list(
            colorscale = list(
              c(0, 0.5, 1),
              c("lightblue", "blue", "darkblue")
            )
          )
        )
        p
      }
    } else if (plot_data_q2$plot_type == "barplot") {
      if (plot_visibility_q2$barplot) {
        # Define color mapping
        colors <- setNames(c("lightblue", "darkblue"), c("Twitter", "Dev.To"))
        
        # Initial plot setup with bar type
        p <- plot_ly(data = dataset, x = ~name, y = ~mention, type = 'bar', color = ~input$question2Dataset, colors = colors) %>%
          layout(xaxis = list(title = "Opinon/Sentiment"),
                 yaxis = list(title = "Number of Mentions"),
                 title = "Predominant Opinions/Sentiments on Q2",
                 barmode = 'group')
        
        
        return(p)
        }}
  })
  
  observeEvent(input$move_to_treemap_q2, {
    plot_data_q2$plot_type <- "treemap"
    plot_visibility_q2$treemap <- TRUE
    plot_visibility_q2$barplot <- FALSE
  })
  
  observeEvent(input$move_to_barplot_q2, {
    plot_data_q2$plot_type <- "barplot"
    plot_visibility_q2$wordcloud <- FALSE
    plot_visibility_q2$barplot <- TRUE
  })
  
  
  # QUESTION3
  
  # Show Q3 data table
  output$q3Table <- DT::renderDataTable({
    
    # Load the dataset based on user selection or default to Twitter if none selected
    dataset <- switch(ifelse(is.null(input$question3DatasetTable) || input$question3DatasetTable == "", "Twitter", input$question3DatasetTable),
                      "Twitter" = question3datasetTwitterFull(),
                      "Dev.To" = question3datasetDevTo(),
                      "Reddit" = question3datasetReddit())
    
    
    DT::datatable(
     dataset,
      rownames = FALSE,
      colnames = c('Technology','Number of Mentions'),
      extensions = c('Responsive', 'Buttons'),
      options = list(
        searchHighlight = TRUE,
        dom = 'Bfrtip',
        buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
        title= paste(input$question3DatasetTable, " Dataset")
      )
    )
  }, server = FALSE)

  output$selectedDataset <- renderUI({
    selected_dataset <- input$question3DatasetTable
    h2(paste(selected_dataset, " Dataset"))
  })
  
  
  plot_data <- reactiveValues(plot_type = "barplot")
  plot_visibility <- reactiveValues(barplot = TRUE, treemap = FALSE, piechart=FALSE)
  
  
  output$q3dynamicplot <- renderPlotly({
    if (is.null(plot_data$plot_type)) {
      return(NULL)  # No plot selected yet
    }
    # Load the dataset based on user selection or default to Twitter if none selected
    dataset <- switch(ifelse(is.null(input$question3Dataset) || input$question3Dataset == "", "Twitter", input$question3Dataset),
                      "Twitter" = question3datasetTwitter(),
                      "Dev.To" = question3datasetDevTo(),
                      "Reddit" = question3datasetReddit())
    
    if (plot_data$plot_type == "barplot") {
      if (plot_visibility$barplot) {
        
        # Define color mapping
        colors <- setNames(c("lightblue", "blue", "darkblue"), c("Twitter", "Dev.To", "Reddit"))
        
        # Initial plot setup with bar type
        p <- plot_ly(data = dataset, x = ~name, y = ~mention, type = 'bar', color = ~input$question3Dataset, colors = colors) %>%
          layout(xaxis = list(title = "Technology"),
                 yaxis = list(title = "Number of Mentions"),
                 title = "Predominant Technologies on Q3",
                 barmode = 'group')
        
        
        return(p)}
    } else if (plot_data$plot_type == "treemap") {
      if (plot_visibility$treemap) {
        treemap_data <- dataset
        print(treemap_data)
        p <- plot_ly(
          data = treemap_data,
          ids = ~name,
          labels = ~name,
          parents = ~"",
          values = ~mention,
          type = "treemap",
          hoverinfo = "label+value+percent root",
          treemapcolorway = c("white"),
          marker = list(
            colorscale = list(
              c(0, 0.5, 1),
              c("lightblue", "blue", "darkblue")
            )
          )
        )
        p}}
    else if (plot_data$plot_type == "piechart") {
      # Generate some sample data for the pie chart
      
      plot_ly(dataset, labels = ~name, values = ~mention, type = "pie")
    }
  })
  
  observeEvent(input$move_to_barplot, {
    plot_data$plot_type <- "barplot"
    plot_visibility$barplot <- TRUE
    plot_visibility$treemap <- FALSE  # Hide treemap when bar plot is shown
    plot_visibility$piechart <- FALSE  # Hide treemap when bar plot is shown
  })
  
  # Toggle visibility of the treemap
  observeEvent(input$move_to_treemap, {
    plot_data$plot_type <- "treemap"
    plot_visibility$treemap <- TRUE
    plot_visibility$barplot <- FALSE  # Hide bar plot when treemap is shown
    plot_visibility$piechart <- FALSE  # Hide treemap when bar plot is shown
  })
  
  # Toggle visibility of the treemap
  observeEvent(input$move_to_piechart, {
    plot_data$plot_type <- "piechart"
    plot_visibility$treemap <- FALSE
    plot_visibility$barplot <- FALSE  # Hide bar plot when treemap is shown
    plot_visibility$piechart <- TRUE  # Hide treemap when bar plot is shown
  })

  # QUESTION4
  
  # Show Q4 data table
  output$q4Table <- DT::renderDataTable({
    
    # Load the dataset based on user selection or default to Devto if none selected
    dataset <- switch(ifelse(is.null(input$question3DatasetTable) || input$question3DatasetTable == "", "Twitter", input$question3DatasetTable),
                      "Devto2022" = question4datasetTwitterFull(),
                      "Dev.To" = question3datasetDevTo(),
                      "Reddit" = question3datasetReddit())
    
    
    DT::datatable(
     dataset,
      rownames = FALSE,
      colnames = c('Technology','Number of Mentions'),
      extensions = c('Responsive', 'Buttons'),
      options = list(
        searchHighlight = TRUE,
        dom = 'Bfrtip',
        buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
        title= paste(input$question3DatasetTable, " Dataset")
      )
    )
  }, server = FALSE)

  output$selectedDataset <- renderUI({
    selected_dataset <- input$question3DatasetTable
    h2(paste(selected_dataset, " Dataset"))
  })
  
  
  plot_data <- reactiveValues(plot_type = "barplot")
  plot_visibility <- reactiveValues(barplot = TRUE, treemap = FALSE, piechart=FALSE)
  
  
  output$q3dynamicplot <- renderPlotly({
    if (is.null(plot_data$plot_type)) {
      return(NULL)  # No plot selected yet
    }
    # Load the dataset based on user selection or default to Twitter if none selected
    dataset <- switch(ifelse(is.null(input$question4Dataset) || input$question4Dataset == "", "Devto2022", input$question4Dataset),
                      "Devto2022" = question4datasetDevto2022(),
                      "Devto2023" = question4datasetDevto2023(),
                      "StackOverflow2022" = question4datasetStackOverflow2022(),
                      "StackOverflow2023" = question4datasetStackOverflow2023())
    
    if (plot_data$plot_type == "barplot") {
      if (plot_visibility$barplot) {
        
        # Define color mapping
        colors <- setNames(c("lightblue", "blue", "darkblue","#7474f0" ), c("Devto2022", "Devto2023", "StackOverflow2022", "StackOverflow2023"))
        
        # Initial plot setup with bar type
        p <- plot_ly(data = dataset, x = ~name, y = ~mention, type = 'bar', color = ~input$question4Dataset, colors = colors) %>%
          layout(xaxis = list(title = "Technology"),
                 yaxis = list(title = "Number of Mentions"),
                 title = "Predominant Technologies on Q3",
                 barmode = 'group')
        
        
        return(p)}
    } else if (plot_data$plot_type == "treemap") {
      if (plot_visibility$treemap) {
        treemap_data <- dataset
        print(treemap_data)
        p <- plot_ly(
          data = treemap_data,
          ids = ~name,
          labels = ~name,
          parents = ~"",
          values = ~mention,
          type = "treemap",
          hoverinfo = "label+value+percent root",
          treemapcolorway = c("white"),
          marker = list(
            colorscale = list(
              c(0, 0.5, 1),
              c("lightblue", "blue", "darkblue")
            )
          )
        )
        p}}
    else if (plot_data$plot_type == "piechart") {
      # Generate some sample data for the pie chart
      
      plot_ly(dataset, labels = ~name, values = ~mention, type = "pie")
    }
  })
  
  observeEvent(input$move_to_barplot, {
    plot_data$plot_type <- "barplot"
    plot_visibility$barplot <- TRUE
    plot_visibility$treemap <- FALSE  # Hide treemap when bar plot is shown
    plot_visibility$piechart <- FALSE  # Hide treemap when bar plot is shown
  })
  
  # Toggle visibility of the treemap
  observeEvent(input$move_to_treemap, {
    plot_data$plot_type <- "treemap"
    plot_visibility$treemap <- TRUE
    plot_visibility$barplot <- FALSE  # Hide bar plot when treemap is shown
    plot_visibility$piechart <- FALSE  # Hide treemap when bar plot is shown
  })
  
  # Toggle visibility of the treemap
  observeEvent(input$move_to_piechart, {
    plot_data$plot_type <- "piechart"
    plot_visibility$treemap <- FALSE
    plot_visibility$barplot <- FALSE  # Hide bar plot when treemap is shown
    plot_visibility$piechart <- TRUE  # Hide treemap when bar plot is shown
  })



})
