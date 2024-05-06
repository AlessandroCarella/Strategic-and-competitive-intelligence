library(shiny)
library(shinydashboard)
library(dplyr)
library(treemap)
library(ggplot2)  # Add this line to load ggplot2
library(DT)

# Define UI
# Define UI
ui <- fluidPage(
  
  titlePanel("Strategic and competitive intelligence project"),
  
  sidebarLayout(
    sidebarPanel(
      textOutput("textOutput1Question1")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Treemap Twitter", plotOutput("treemapTwitter")),
        tabPanel("Treemap Reddit", plotOutput("treemapReddit")),
        tabPanel("Pyramid plot ordered Twitter", plotOutput("pyramidPlotOrderedTwitter")),
        tabPanel("Pyramid plot ordered Reddit", plotOutput("pyramidPlotOrderedReddit"))
      )
    )
  )
)