library(shiny)
library(treemap)
library(DT)
library(ggplot2)

server_question1 <- function(input, output, session) {
    # Read CSV file
    dataDf1Question1 <- reactive({
      read.csv("data/question1StartUps.csv")
    })
    dataDf2Question1 <- reactive({
      read.csv("data/question1Software_Professional_Salaries.csv")
    })
    dataDf3Question1 <- reactive({
      read.csv("data/question1data_science_job.csv")
    })
    
    dataDf4Question1 <- reactive({
      read.csv("data/question1wordsInTheTwitterDataset.csv")
    })
    
    dataRedditQuestion1 <- reactive({
      read.csv("data/question1RedditData.csv")
    })
    dataTwitterQuestion1 <- reactive({
      read.csv("data/question1TwitterData.csv")
    })
    
    dataRedditTwitterMergeQuestion1 <- reactive({
      read.csv("data/question1reddit_twitter_counts_normalized_cut20.csv")
    })
    
    output$textOutput1Question1 <- renderText({
      "The first question we wanted to answer was\n
    What organizations are mentioned most often in the genAI for coding public discourse?\n
    In the beginning we looked for a list of companies to search in the retrieved data from twitter and reddit\n"
    })
    output$textOutput2Question1 <- renderText({
      "To do that we went on keaggle and used the query \"ai company\" and we downloaded 3 dataset that had the company name as one of the column"
    })
    
    output$textOutput3Question1 <- renderText({
      "The first dataset is retrievable https://www.kaggle.com/datasets/khaiid/startups-by-valuation"
    })
    output$table1Question1 <- renderDT({
      datatable(head(dataDf1Question1()))
    })
    output$textOutput4Question1 <- renderText({
      "The second dataset is retrievable https://www.kaggle.com/datasets/iamsouravbanerjee/software-professional-salaries-2022"
    })
    output$table2Question1 <- renderDT({
      datatable(head(dataDf2Question1()))
    })
    output$textOutput5Question1 <- renderText({
      "The third and last dataset is retrievable https://www.kaggle.com/datasets/joyshil0599/data-science-jobs-comprehensive-dataset"
    })
    output$table3Question1 <- renderDT({
      datatable(head(dataDf3Question1()))
    })
    
    output$textOutput6Question1 <- renderText({
      "After we started processing the data on the twitter dataset \n
    The first step we took for that was to filter the dataset by a list of coding related words we created\n
    The filter on the dataset was applied by keeping the rows of the dataset where one of the values in the subjects or objects or topic column had one of the coding words in it\n
    After that the next step we took was to transform the original_text column of the filtered dataset into a dictionary word:numberOfOccurrences that we can see in the following treemap (just the first 500)"
    })
    output$twitterDatasetCircularTreeMapQuestion1 <- renderPlot({
      req(dataDf4Question1())
      tm <- treemap(dataDf4Question1()[1:500, ], index = "word", vSize = "occurrences", title="Tweets words")
      print(tm)
    })
    
    output$textOutput7Question1 <- renderText({
      "After that we iterated through the list of companies we had and checked if they were in the dictionary of words from the coding tweets to create a new dictionary with company:numberOfOccurrences\n
    The results are visible in the following treemap"
    })
    output$treemapTwitterQuestion1 <- renderPlot({
      req(dataTwitterQuestion1())
      tm <- treemap(dataTwitterQuestion1(), index = "company", vSize = "count", title="Twitter data")
      print(tm)
    })
    
    output$textOutput8Question1 <- renderText({
      "Since we wanted to have multiple data sources we decided to download data from reddit\n
    to do that we used the reddit api and we queried the following subreddits:\n
    r/programming, r/AskProgramming, r/learnprogramming, r/ProgrammerHumor, r/ProgrammingBuddies\n
    with the following queries:\n
    generative ai, gen ai, generative models, machine-generated\n
    from the obtained posts we had the following attributes:\n
    \ttitle\n
    \ttext\n
    \tcomments\n
    We concatenated all the data and created the dictionary word:occurrences as we did for the tweets\n
    After that, as for the tweets, we iterated through the list of companies and created the dictionary company:numberOfOccurrences\n
    The results are visible in the following treemap\n"
    })
    output$treemapRedditQuestion1 <- renderPlot({
      req(dataRedditQuestion1())
      tm <- treemap(dataRedditQuestion1(), index = "company", vSize = "count", title="Reddit data")
      print(tm)
    })
    
    output$textOutput9Question1 <- renderText({
      "The following is a pyramid plot to compare the occurences of the companies that appear in both datasets\n
    The data is normalized since we have way bigger numbers in the twitter dataset\n
    Also only the first 20 samples with most values are showed to have a clear output\n
    The values are ordered by the more frequent to the less frequent in the twitter dataset\n"
    })
    
    output$pyramidPlot <- renderPlot({
      req(dataRedditTwitterMergeQuestion1())
      ggplot(dataRedditTwitterMergeQuestion1(), aes(x = company, y = redditCount, fill = company)) +
        geom_bar(stat = "identity", position = "dodge") +
        geom_bar(aes(y = -twitterCount), stat = "identity", position = "dodge") +
        coord_flip() +
        labs(title = "Reddit and Twitter Counts by Company",
             x = "Company", y = "Count") +
        theme_minimal()
    })
  }