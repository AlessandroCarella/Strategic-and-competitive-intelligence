library(shiny)
library(DT)

# Define UI
ui <- fluidPage(
  titlePanel("View CSV Files Head"),
  sidebarLayout(
    sidebarPanel(
      selectInput("file", "Choose a CSV file:",
                  choices = c("File 1" = "data/question1StartUps.csv",
                              "File 2" = "data/question1Software_Professional_Salaries.csv",
                              "File 3" = "data/question1data_science_job.csv")),
      actionButton("view_head", "View Head")
    ),
    mainPanel(
      DTOutput("head_table")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  data <- reactive({
    read.csv(input$file)
  })
  
  observeEvent(input$view_head, {
    output$head_table <- renderDT({
      datatable(head(data()))
    })
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
