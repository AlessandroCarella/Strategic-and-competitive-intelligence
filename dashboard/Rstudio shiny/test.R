library(shiny)
library(shinydashboard)
library(dplyr)
library(treemap)
library(ggplot2)  
library(DT)

# Define UI
ui <- fluidPage(
  
  titlePanel("Strategic and competitive intelligence project"),
  
  sidebarLayout(
    sidebarPanel(
      actionButton("button1", "Button 1"),
      actionButton("button2", "Button 2"),
      actionButton("button3", "Button 3")
    ),
    mainPanel(
      uiOutput("mainPanelContent")
    )
  )
)

server <- function(input, output) {
  
  # Button 1 Content
  output$textOutput1Question1 <- renderText({
    "The first question we wanted to answer was\n
    What organizations are mentioned most often in the genAI for coding public discourse?"
  })
  
  # Button 1 Click Event
  observeEvent(input$button1, {
    output$mainPanelContent <- renderUI({
      textOutput("textOutput1Question1")
    })
  })
  
  # Button 2 Content
  output$textOutput2Question2 <- renderText({
    "The second question we wanted to answer was\n
    What are the key topics discussed in the AI for genomics community?"
  })
  
  # Button 2 Click Event
  observeEvent(input$button2, {
    output$mainPanelContent <- renderUI({
      textOutput("textOutput2Question2")
    })
  })
  
  # Button 3 Content
  output$textOutput3Question3 <- renderText({
    "The third question we wanted to answer was\n
    How does sentiment towards AI in healthcare vary across different demographics?"
  })
  
  # Button 3 Click Event
  observeEvent(input$button3, {
    output$mainPanelContent <- renderUI({
      textOutput("textOutput3Question3")
    })
  })
}

shinyApp(ui = ui, server = server)
