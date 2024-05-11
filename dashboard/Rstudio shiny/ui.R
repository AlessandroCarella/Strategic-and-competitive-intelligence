library(shiny)
library(shinydashboard)
library(dplyr)
library(treemap)
library(ggplot2)  # Add this line to load ggplot2
library(DT)

ui <- fluidPage(
  tags$head(
    #css side panel buttons class declaration 
    tags$style(HTML("
      .square-btn {
        width: 450px; /* Adjust the width to make it square */
        height: 100px; /* Adjust the height to make it square */
        border-radius: 0; /* Remove border radius to make it square */
        font-size: 14px; /* Adjust font size as needed */
        padding: 10px; /* Add padding to ensure text fits properly */
        white-space: nowrap; /* Prevent text wrapping */
        overflow: hidden; /* Hide any overflow */
        text-overflow: nowrap; /* Display ellipsis (...) for overflow */
      }
    "))
  ),
  
  titlePanel("Strategic and competitive intelligence project"),
  
  sidebarLayout(
    sidebarPanel(
      actionButton ("question1", HTML("The first question we wanted to answer was<br>What organizations are mentioned most often in the genAI for coding<br>public discourse?"), class = "square-btn"),
      actionButton ("question2", HTML("AAAAAAA"), class = "square-btn"),
      actionButton ("question3", HTML("What innovative approaches or methodologies are emerging in the field of coding?"), class = "square-btn")
    ),
    mainPanel(
      uiOutput("mainPanelContent")
    )
  )
)

