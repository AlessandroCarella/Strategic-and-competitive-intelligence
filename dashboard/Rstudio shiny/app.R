library(shiny)
install.packages("ggplot2")
library(ggplot2)

# Fixed CSV file with words
words <- read.csv(text = "x.csv", stringsAsFactors = FALSE)

ui <- fluidPage(
  titlePanel("Word Visualization in a Rectangle"),
  mainPanel(
    plotOutput("word_plot")
  )
)

server <- function(input, output) {
  output$word_plot <- renderPlot({
    # Create a rectangle plot
    ggplot() +
      geom_rect(aes(xmin = 0, xmax = 10, ymin = 0, ymax = 10), fill = "lightblue") +
      geom_text(data = words, aes(x = runif(nrow(words), 0, 10), y = runif(nrow(words), 0, 10), label = Word), size = 5) +
      theme_void() +
      theme(plot.background = element_rect(fill = "lightblue"))
  })
}

shinyApp(ui, server)

