library(shiny)
library(plotly)
library(wordcloud2)
library(ggrepel)
library(ggplot2)
library(ggwordcloud)
library(treemap)
library(dplyr)

# Define a server for the app
shiny::shinyServer(function(input, output, session) {
  
  #LOAD DATA
  # Load data for Question 1
  question1datasetTwitter <- reactive({
    req(file.exists("data/question1TwitterData.csv"))
    read.csv("data/question1TwitterData.csv")
  })
  
  question1datasetReddit <- reactive({
    req(file.exists("data/question1RedditData.csv"))
    read.csv("data/question1RedditData.csv")
  })
  
  question1dataRedditTwitterMerge <- reactive({
    req(file.exists("data/question1reddit_twitter_counts_normalized.csv"))
    read.csv("data/question1reddit_twitter_counts_normalized.csv")
  })
  
  #--------------------------------------------------------------------------------------------------

  #Load data for Question 2
  question2datasetDevTo <- reactive({
    req(file.exists("data/question2discoveryDevToFiltered.csv"))
    read.csv("data/question2discoveryDevToFiltered.csv")
  })

  question2ObjectsTwitter <- reactive({
    req(file.exists("data/question2ObjectsTwitter.csv"))
    read.csv("data/question2ObjectsTwitter.csv")
  })
  question2PredicatesTwitter <- reactive({
    req(file.exists("data/question2PredicatesTwitter.csv"))
    read.csv("data/question2PredicatesTwitter.csv")
  })
  question2SentimentTwitter <- reactive({
    req(file.exists("data/question2SentimentTwitter.csv"))
    read.csv("data/question2SentimentTwitter.csv")
  })
  question2SubjectsTwitter <- reactive({
    req(file.exists("data/question2SubjectsTwitter.csv"))
    read.csv("data/question2SubjectsTwitter.csv")
  })
  question2TopicsTwitter <- reactive({
    req(file.exists("data/question2TopicsTwitter.csv"))
    read.csv("data/question2TopicsTwitter.csv")
  })

  #--------------------------------------------------------------------------------------------------
  
  # Load data for Question 3
  
  question3datasetTwitter <- reactive({ # nolint
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

  #--------------------------------------------------------------------------------------------------

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
    req(file.exists("data/question4_stackoverflow_2022.csv"))
    read.csv("data/question4_stackoverflow_2022.csv")
  })
  
  question4datasetStackOverflow2023 <- reactive({
    req(file.exists("data/question4_stackoverflow_2023.csv"))
    read.csv("data/question4_stackoverflow_2023.csv")
  })

  question4datasetDevtoMerged <- reactive({
    req(file.exists("data/question4_devto_2022_23.csv"))
    read.csv("data/question4_devto_2022_23.csv")
  })
  
  question4datasetStackOverflowMerged <- reactive({
    req(file.exists("data/question4_stackoverflow_2022_23.csv"))
    read.csv("data/question4_stackoverflow_2022_23.csv")
  })

  #--------------------------------------------------------------------------------------------------
  #--------------------------------------------------------------------------------------------------
  
  output$question1Answer <- renderText({
    "The takeaway from this data is that the organizations that are mentioned most often in the genAI for coding public discourse are mostly very big tech companies.
There are some minor differences between the data extracted from twitter and reddit but not really meaningful ones since the most cited are always the same.
In the list we found there are some interesting names that stand out when considering the names that one would assume to be more related to the generative ai 
public discussions (such as NVIDIA) and one can observe them in the treemap above."
  })
  output$question2Answer <- renderText({
    "TODO, SEARCH \"output$question2Answer\" IN THE SERVER FILE"
  })
  output$question3Answer <- renderText({
    "TODO, SEARCH \"output$question3Answer\" IN THE SERVER FILE"
  })
  output$question4Answer <- renderText({
    "TODO, SEARCH \"output$question4Answer\" IN THE SERVER FILE"
  })
  #ADD OTHER ANSWERS HERER


  #--------------------------------------------------------------------------------------------------
  #--------------------------------------------------------------------------------------------------
  
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
    shinydashboard::valueBox(6,
                             "Datasets",
                             icon = shiny::icon("database"),
                             color = "light-blue")
  })
  #Valid colors are: red, yellow, aqua, blue, light-blue, green, navy, teal, olive, lime, orange, fuchsia, purple, maroon, black.
  # Create the insstructions box
  output$instructionsBox <- shiny::renderUI({
    shinydashboard::box(
      title = tagList(shiny::icon("info-circle"), "Instructions"),
      status = "info",
      solidHeader = TRUE,
      width = 12,
      HTML("
        <p>To navigate the dashboard, please follow these instructions:</p>
        <ol>
          <li>Click on the side pannel to choose the topic you want to learn more about.</li>
          <li>For each topic, select the dataset you are interested in by clicking on the \"Database icon\".</li>
          <li>For each topic, select the plot type you are interesting on viewing by clicking on the buttons with names of the plots situated in the topic page.</li>
          <li>For each plot, hover over one of the plot items to see the percentage that they represent and other details.</li>
        </ol>
        <p>If you have any questions, please refer to the help section on each topic or contact us.</p>
      ")
    )
  })

  #--------------------------------------------------------------------------------------------------
  #--------------------------------------------------------------------------------------------------
  
  #QUESTION 1
  output$pyramidPlotOrderedTwitter <- renderPlot({
      data <- dataRedditTwitterMergeOrderedTwitterQuestion1()

    # Arrange the data frame by Twitter count
    data <- arrange(data, desc(twitterCount))

    ggplot(data, aes(x = reorder(company, -twitterCount), y = redditCount, fill = company)) +
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

  #--------------------------------------------------------------------------------------------------
  # Show Q1 data table
  output$q1Table <- DT::renderDataTable({
    
    # Load the dataset based on user selection or default to Twitter if none selected
    dataset <- switch(ifelse(is.null(input$question1DatasetTable) || input$question1DatasetTable == "", "Twitter", input$question1DatasetTable),
                      "Twitter" = question1datasetTwitter(),
                      "Reddit" = question1datasetReddit())
    
    DT::datatable(
     dataset,
      rownames = FALSE,
      colnames = c('Company','Number of Mentions'),
      extensions = c('Responsive', 'Buttons'),
      options = list(
        searchHighlight = TRUE,
        dom = 'Bfrtip',
        buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
        title= paste(input$question1DatasetTable, " Dataset")
      )
    )
  }, server = FALSE)

  output$selectedDataset <- renderUI({
    selected_dataset <- input$question1DatasetTable
    h2(paste(selected_dataset, " Dataset"))
  })
  
  plot_data <- reactiveValues(plot_type = "treemap")
  plot_visibility <- reactiveValues(pyramid = FALSE, treemap = TRUE)
  
  output$q1dynamicplot <- renderPlotly({
    if (is.null(plot_data$plot_type)) {
      return(NULL)  # No plot selected yet
    }
    # Load the dataset based on user selection or default to Twitter if none selected
    dataset <- switch(ifelse(is.null(input$question1Dataset) || input$question1Dataset == "", "Twitter", input$question1Dataset),
                      "Twitter" = question1datasetTwitter(),
                      "Reddit" = question1datasetReddit())

    # Load the dataset based on user selection or default to Twitter if none selected
    datasetPyramid <- question1dataRedditTwitterMerge()
    
    if (plot_data$plot_type == "pyramid") {
      if (plot_visibility$pyramid) {
  data <- datasetPyramid
  
  # Calculate total frequency
  data <- data %>%
    mutate(totalCount = abs(redditCount) + abs(twitterCount))
  
  # Reorder data by total frequency
  data <- data[order(data$totalCount, decreasing = TRUE), ]
  
  data %>%
    mutate(redditCount = -redditCount) %>%
    mutate(abs_reddit = abs(redditCount)) %>%
    plot_ly(x = ~redditCount, y = ~company, color = I("red")) %>% 
    add_bars(orientation = 'h', hoverinfo = 'text', text = ~abs_reddit, name = "Reddit") %>%
    add_trace(x = ~twitterCount, y = ~company, color = I("blue"), type = 'bar', orientation = 'h', hoverinfo = 'text', name = "Twitter") %>%
    layout(bargap = 0.1, barmode = 'overlay',
           xaxis = list(title = "Count", tickmode = 'array', tickvals = c(-300, -200, -100, 0, 100, 200, 300),
                        ticktext = c('300', '200', '100', '0', '100', '200', '300')))
      }

    } else if (plot_data$plot_type == "treemap") {
      if (plot_visibility$treemap) {
        treemap_data <- dataset
        print("ciao\n\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao\nciao")
        p <- plot_ly(
          data = treemap_data,
          ids = ~company,
          labels = ~company,
          parents = ~"",
          values = ~count,
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
    }
  })
  
  observeEvent(input$move_to_pyramid, {
    plot_data$plot_type <- "pyramid"
    plot_visibility$pyramid <- TRUE
    plot_visibility$treemap <- FALSE  # Hide treemap when bar plot is shown
  })
  
  # Toggle visibility of the treemap
  observeEvent(input$move_to_treemap, {
    plot_data$plot_type <- "treemap"
    plot_visibility$treemap <- TRUE
    plot_visibility$pyramid <- FALSE  # Hide bar plot when treemap is shown
  })


  #--------------------------------------------------------------------------------------------------
  
  #QUESTION 2
  # Show Q2 data table
  output$q2Table <- DT::renderDataTable({
    
    # Load the dataset based on user selection or default to Twitter if none selected
    dataset <- switch(ifelse(is.null(input$question2DatasetTable) || input$question2DatasetTable == "", "Dev.To", input$question2DatasetTable),
                      "Twitter sentiment" = question2SentimentTwitter(), 
                      "Twitter topics" = question2TopicsTwitter(),
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
  },  server = FALSE)
  
  output$selectedDatasetq2 <- renderUI({
    selected_dataset <- input$question2DatasetTable
    h2(paste(selected_dataset, " Dataset"))
  })
  
  plot_data_q2 <- reactiveValues(plot_type = "treemap")
  plot_visibility_q2 <- reactiveValues(treemap = TRUE, barplot=FALSE)
  
  
  output$q2dynamicplot <- renderPlotly({
    if (is.null(plot_data_q2$plot_type)) {
      return(NULL)  # No plot selected yet
    }
    
    # Load the dataset based on user selection or default to Twitter if none selected
    dataset <- switch(ifelse(is.null(input$question2Dataset) || input$question2Dataset == "", "Dev.To", input$question2Dataset),
                      "Twitter sentiment" = question2SentimentTwitter(), 
                      "Twitter topics" = question2TopicsTwitter(),
                      "Dev.To" = question2datasetDevTo())
    # Load the dataset based on user selection or default to Twitter if none selected
    name_column <- switch(ifelse(is.null(input$question2Dataset) || input$question2Dataset == "", "Dev.To", input$question2Dataset),
                      "Twitter sentiment" = "sentiment", 
                      "Twitter topics" = "topic",
                      "Dev.To" = "name")
    # Load the dataset based on user selection or default to Twitter if none selected
    mention_column <- switch(ifelse(is.null(input$question2Dataset) || input$question2Dataset == "", "Dev.To", input$question2Dataset),
                      "Twitter sentiment" = "count", 
                      "Twitter topics" = "count",
                      "Dev.To" = "mention")
    
    if (plot_data_q2$plot_type == "treemap") {
      if (plot_visibility_q2$treemap) {       
        treemap_data <- dataset
        p <- plot_ly(
          data = treemap_data,
          ids = ~get(name_column),
          labels = ~get(name_column),
          parents = ~"",
          values = ~get(mention_column),
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
        colors <- setNames(c("lightblue", "blue", "darkblue"), 
                   c("Twitter sentiment", "Twitter topics", "Dev.To"))

        # Initial plot setup with bar type
        p <- plot_ly(data = dataset, x = ~get(name_column), y = ~get(mention_column), type = 'bar', color = ~input$question2Dataset, colors = colors) %>%
          layout(xaxis = list(title = "Opinon/Sentiment"),
                yaxis = list(title = "Number of Mentions"),
                title = "Predominant Opinions, Sentiments and others on Q2",
                barmode = 'group')
        
        return(p)
      }
    }
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
  
  
  #--------------------------------------------------------------------------------------------------
  
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
  
  
  output$q3dynamicplot <- renderPlotly({
    # Load the dataset based on user selection or default to Twitter if none selected
    dataset <- switch(ifelse(is.null(input$question3Dataset) || input$question3Dataset == "", "Twitter", input$question3Dataset),
                      "Twitter" = question3datasetTwitter(),
                      "Dev.To" = question3datasetDevTo(),
                      "Reddit" = question3datasetReddit())
    
  
        
        # Define color mapping
        colors <- setNames(c("lightblue", "blue", "darkblue"), c("Twitter", "Dev.To", "Reddit"))
        
        ordered_dataset <- dataset %>%
          arrange(desc(mention))
        ordered_dataset$name <- factor(ordered_dataset$name, levels = ordered_dataset$name)
        
        # Initial plot setup with bar type
        p <- plot_ly(data = ordered_dataset, x = ~name, y = ~mention, type = 'bar', color =  ~input$question3Dataset, colors = colors) %>%
          layout(xaxis = list(title = "Technology"),
                 yaxis = list(title = "Number of Mentions"),
                 title = "Predominant Technologies on Q3",
                 barmode = 'group')
        
        
        return(p)
  
  })
  

  #--------------------------------------------------------------------------------------------------
  
  # QUESTION4
  
  # Show Q4 data table
  output$q4Table <- DT::renderDataTable({
    
    # Load the dataset based on user selection or default to Devto if none selected
    dataset <- switch(ifelse(is.null(input$question4DatasetTable) || input$question4DatasetTable == "", "Devto2022", input$question4DatasetTable),
                      "Devto2022" = question4datasetDevto2022(),
                      "Devto2023" = question4datasetDevto2023(),
                      "StackOverflow2022" = question4datasetStackOverflow2022(),
                      "StackOverflow2023" = question4datasetStackOverflow2023())
    
    
    DT::datatable(
     dataset,
      rownames = FALSE,
      colnames = c('Technology','Number of Mentions'),
      extensions = c('Responsive', 'Buttons'),
      options = list(
        searchHighlight = TRUE,
        dom = 'Bfrtip',
        buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
        title= paste(input$question4DatasetTable, " Dataset")
      )
    )
  }, server = FALSE)

  output$selectedDatasetq4 <- renderUI({
    selected_dataset <- input$question4DatasetTable
    h2(paste(selected_dataset, " Dataset"))
  })
  
  plot_data_q4 <- reactiveValues(plot_type = "barplot")
  plot_visibility_q4 <- reactiveValues(barplot = TRUE, treemap = FALSE, piechart=FALSE)
  
  output$q4dynamicplot <- renderPlotly({
    if (is.null(plot_data$plot_type)) {
      return(NULL)  # No plot selected yet
    }
    dataset <- switch(ifelse(is.null(input$question4Dataset) || input$question4Dataset == "", "Devto", input$question4Dataset),
              "Devto" = question4datasetDevtoMerged(),
              "StackOverflow" = question4datasetStackOverflowMerged()
    )
    
    if (plot_data_q4$plot_type == "barplot") {
      if (plot_visibility_q4$barplot) {
      ordered_dataset_q4 <- dataset %>%
      arrange(desc(mention2023))
      ordered_dataset_q4$name <- factor(ordered_dataset_q4$name, levels = ordered_dataset_q4$name)
        output$question4YearSelect <- NULL
        # Initial plot setup with bar type
        p <- plot_ly(data = ordered_dataset_q4, x = ~name, y = ~mention2022, name = "2022", type = 'bar') %>%
         add_trace(x = ~name, y = ~mention2023, name = "2023") %>%
          layout(xaxis = list(title = "Technology"),
                 yaxis = list(title = "Number of Mentions"),
                 title = "Predominant Technologies on Q4",
                 barmode = 'group')
        return(p)}
    } else if (plot_data_q4$plot_type == "treemap") {
      if (plot_visibility_q4$treemap) {
        treemap_data <- dataset
        year <- ifelse(is.null(input$question4YearSelectInput), 2022, input$question4YearSelectInput)
        output$question4YearSelect <- renderUI(
          selectInput(
            inputId = 'question4YearSelectInput',
            label = "Year",
            selected = year,
            multiple = FALSE,
            choices = c(2022, 2023)
          )
        )
        if (year == 2022) {
        p <- plot_ly(
          data = treemap_data,
          ids = ~name,
          labels = ~name,
          parents = ~"",
          values = ~mention2022,
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
        } else {
        p <- plot_ly(
          data = treemap_data,
          ids = ~name,
          labels = ~name,
          parents = ~"",
          values = ~mention2023,
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
        }
        p}}
    else if (plot_data_q4$plot_type == "piechart") {
      # Generate some sample data for the pie chart
        year <- ifelse(is.null(input$question4YearSelectInput), 2022, input$question4YearSelectInput)
        output$question4YearSelect <- renderUI(
          selectInput(
            inputId = 'question4YearSelectInput',
            label = "Year",
            selected = year,
            multiple = FALSE,
            choices = c(2022, 2023)          )
        )
        if(year == 2022) {
          plot_ly(dataset, labels = ~name, values = ~mention2022, type = "pie")
        } else {
          plot_ly(dataset, labels = ~name, values = ~mention2023, type = "pie")
        }
    }
  })
  
  observeEvent(input$move_to_barplot_q4, {
    plot_data_q4$plot_type <- "barplot"
    plot_visibility_q4$barplot <- TRUE
    plot_visibility_q4$treemap <- FALSE  # Hide treemap when bar plot is shown
    plot_visibility_q4$piechart <- FALSE  # Hide treemap when bar plot is shown
  })
  
  # Toggle visibility of the treemap
  observeEvent(input$move_to_treemap_q4, {
    plot_data_q4$plot_type <- "treemap"
    plot_visibility_q4$treemap <- TRUE
    plot_visibility_q4$barplot <- FALSE  # Hide bar plot when treemap is shown
    plot_visibility_q4$piechart <- FALSE  # Hide treemap when bar plot is shown
  })
  
  # Toggle visibility of the treemap
  observeEvent(input$move_to_piechart_q4, {
    plot_data_q4$plot_type <- "piechart"
    plot_visibility_q4$treemap <- FALSE
    plot_visibility_q4$barplot <- FALSE  # Hide bar plot when treemap is shown
    plot_visibility_q4$piechart <- TRUE  # Hide treemap when bar plot is shown
  })
})
