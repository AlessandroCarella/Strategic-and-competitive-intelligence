ui_question1 <- fluidPage(
  titlePanel("Strategic and competitive intelligence project"),
  mainPanel(
    textOutput("textOutput1Question1"),
    textOutput("textOutput2Question1"),
    
    textOutput("textOutput3Question1"),
    DTOutput("table1Question1"),
    textOutput("textOutput4Question1"),
    DTOutput("table2Question1"),
    textOutput("textOutput5Question1"),
    DTOutput("table3Question1"),
    
    textOutput("textOutput6Question1"),
    plotOutput("twitterDatasetCircularTreeMapQuestion1"),
    
    textOutput("textOutput7Question1"),
    plotOutput("treemapTwitterQuestion1"),
    
    textOutput("textOutput8Question1"),
    plotOutput("treemapRedditQuestion1"),
    
    textOutput("textOutput9Question1"),
    plotOutput("pyramidPlot"),
  )
)
