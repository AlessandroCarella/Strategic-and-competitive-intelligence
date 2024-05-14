library(shiny)
library(shinydashboard)
library(plotly)
library(shinyWidgets)
dashboardPage(
  header = dashboardHeader(title = "techAnalytics"),
  sidebar = dashboardSidebar(
    sidebarMenu(
      # Home menu item
      menuItem("Home",
                   tabName = "home",
                   icon = icon("home")),
      
      
      #Question 1 menu item
      menuItem(
        "Question 1",
        icon = shiny::icon("building"),
        tabName = "q1",
        menuSubItem("Insights", tabName = "q1Insights", icon = icon("line-chart")),
        menuSubItem("Data", tabName = "q1Data", icon = icon("table"))
      ),
      
      #Question 2 menu item
      menuItem(
        "Question 2",
        icon = shiny::icon("comments"),
        tabName = "q2",
        menuSubItem("Insights", tabName = "q2Insights", icon = icon("line-chart")),
        menuSubItem("Data", tabName = "q2Data", icon = icon("table"))
      ),
      
      # Question 3 menu item
      menuItem(
        "Question 3",
        icon = shiny::icon("microchip"),
        tabName = "q3",
        menuSubItem("Insights", tabName = "q3Insights", icon = icon("line-chart")),
        menuSubItem("Data", tabName = "q3Data", icon = icon("table"))
      ),

            # Question 4 menu item
      menuItem(
        "Question 4",
        icon = icon("cogs"),
        tabName = "q4",
        menuSubItem("Insights", tabName = "q4Insights", icon = icon("line-chart")),
        menuSubItem("Data", tabName = "q4Data", icon = icon("table"))
      ),
      
      #ADD OTHER QUESTIONS HERE
      br()
    )
  ),
  body = dashboardBody(
    # Dashboard favicon and title
    tags$head(
      tags$link(rel = "icon", type = "image/png", href = "logo.png"),
      tags$link(rel="stylesheet", href="https://fonts.googleapis.com/css2?family=Satisfy&display=swap", type = "text/css"),
      tags$link(rel = "stylesheet", href="https://fonts.googleapis.com/css2?family=Ubuntu&display=swap", type = "text/css"),
      tags$title("Frog You"),
      tags$style(
        HTML("
        body, h4 {
          font-family: 'Ubuntu', sans-serif;
        }
      ")
      )
    ),
    
    # Dashboard tab items
    tabItems(
      # Home tab item
      tabItem(
        tabName = "home",
        style = "text-align: center;", 
        fluidRow(
          box(
            title = HTML("<b style='font-family: Satisfy;font-size: 50px;font-color:black;'>techAnalytics</b>"), 
            status = "primary",
            width = 8,
            img(
              src = "logo.png",
              height = 200,
              width = 175
            ),
            h2("Frog You"),
            h4("Strategic & Competitive Intelligence Project"),
            br(),
            h4(
              "techAnalytics is a ",
              a(href = 'http://shiny.rstudio.com', 'Shiny'),
              "dashboard built to give insights onto trends related to technology."
            ),
            h4(
              "For this project, we compiled a  list of 6 questions which aim to delve into today's age opinions & trends on coding."
            ),
            h4("To get started, select a question in the sidepanel."),
            br(),
            h4(
              HTML('&copy'),
              '2024 By Frog You'
            )
          ),
          
          # Projects, companies, and facilities value boxes
          uiOutput("questionBox"),
          uiOutput("datasetBox")
        )
      ),
      
      #--------------------------------------------------------------------------------------------------
      
      #Q1 Insights tab item
      # Q1 Insights tab item
      tabItem( 
        tabName = "q1Insights",
        fluidRow(
          box(
            title = "What organizations are mentioned most often in the genAI for coding public discourse?",
            status = "primary",
            width = 12,
            collapsible = TRUE,
            tags$head(
              tags$style(HTML("
      /* Custom CSS for datatable */
      
      /* Custom CSS for datatable */
      .dataTables_wrapper {
        font-size: 14px; /* Adjust font size */
        font-family: Ariel, sans-serif; /* Adjust font family */
      }
      .dataTable th {
        background-color: #3498db; /* Blueish theme */
        color: white; /* Text color */
        font-weight: bold; /* Bold text */
      }
      .dataTable td, .dataTable th {
        border: 2px solid #ddd; /* Add border to table cells */
        padding: 8px; /* Add padding to table cells */
      }
      .dataTables_wrapper .dataTables_paginate {
        margin-top: 20px; /* Adjust pagination margin */
      }
      .dataTable tr:nth-child(odd) {
        background-color: #f2f2f2; /* Light gray background for odd rows */
      }
        /* CSS for custom button styles */
        .custom-btn {
          background-color: #4CAF50; /* Green */
          border: none;
          color: white;
          padding: 15px 32px;
          text-align: center;
          text-decoration: none;
          display: inline-block;
          font-size: 16px;
          margin: 4px 2px;
          cursor: pointer;
          border-radius: 10px;
        }
        .custom-btn:hover {
          background-color: #45a049; /* Darker Green */
        }
      "))),
            
            fluidRow(
              column(width = 3,
                     actionButton("move_to_treemap", "Tree Map", class="custom-btn")
              ),
              column(width = 3,
                     actionButton("move_to_pyramid", "Pyramid Plot", class="custom-btn")
              )
            ),
            br(),
            plotly::plotlyOutput("q1dynamicplot"),
            
            dropdownButton(
              # Panel title
              h4("List of Datasets"),
              
            
              selectInput(
                "question1Dataset",
                h5("Select Dataset:"),
                c("Twitter", "Reddit")
              ),
              circle = TRUE,
              status = "success",
              icon = shiny::icon("database"),
              width = "300px",
              tooltip = tooltipOptions(title = "Click to see possible datasets"),
              up = TRUE
            )
          )
        )
      ),
        
      # Q1 data tab item
      tabItem(
        tabName = "q1Data",
        fluidRow(
        box(
          title= "What organizations are mentioned most often in the genAI for coding public discourse?",
          status = "primary",
          width = 12,
          collapsible = T,
          uiOutput("selectedDataset"),
          
          # Question 3 table
          DT::dataTableOutput("q1Table"),
          
          dropdownButton(
            # Panel title
            h4("List of Datasets"),
            
            
            selectInput(
              "question1DatasetTable",
              h5("Select Dataset:"),
              c("Twitter", "Reddit")
            ),
            circle = TRUE,
            status = "success",
            icon = icon("database"),
            width = "300px",
            tooltip = tooltipOptions(title = "Click to see possible datasets"),
            up = TRUE
          )
        )
        )
      ),
      
      #--------------------------------------------------------------------------------------------------
      
      #Q2 Insights tab item
      tabItem(
        tabName = "q2Insights",
        fluidRow(
          box(
            title = "How are discussions about coding influenced by trends in remote work, digital nomadism, and gig economy employment, from the point of views of coding professionals?",
            status = "primary",
            width = 12,
            collapsible = TRUE,
            tags$head(
              tags$style(HTML("
      /* Custom CSS for datatable */
      
      /* Custom CSS for datatable */
      .dataTables_wrapper {
        font-size: 14px; /* Adjust font size */
        font-family: Ariel, sans-serif; /* Adjust font family */
      }
      .dataTable th {
        background-color: #3498db; /* Blueish theme */
        color: white; /* Text color */
        font-weight: bold; /* Bold text */
      }
      .dataTable td, .dataTable th {
        border: 2px solid #ddd; /* Add border to table cells */
        padding: 8px; /* Add padding to table cells */
      }
      .dataTables_wrapper .dataTables_paginate {
        margin-top: 20px; /* Adjust pagination margin */
      }
      .dataTable tr:nth-child(odd) {
        background-color: #f2f2f2; /* Light gray background for odd rows */
      }
        /* CSS for custom button styles */
        .custom-btn {
          background-color: #4CAF50; /* Green */
          border: none;
          color: white;
          padding: 15px 32px;
          text-align: center;
          text-decoration: none;
          display: inline-block;
          font-size: 16px;
          margin: 4px 2px;
          cursor: pointer;
          border-radius: 10px;
        }
        .custom-btn:hover {
          background-color: #45a049; /* Darker Green */
        }
      "))),
            
            fluidRow(
              column(width = 3,
                     actionButton("move_to_barplot_q2", "Bar Plot", class="custom-btn")
              ),
              column(width = 3,
                     actionButton("move_to_treemap_q2", "Tree Plot", class="custom-btn")
              )
            ),
            br(),
            plotlyOutput("q2dynamicplot"),
            
            dropdownButton(
              # Panel title
              h4("List of Datasets"),
              
              
              selectInput(
                "question2Dataset",
                h5("Select Dataset:"),
                c( "Dev.To","Twitter")
              ),
              circle = TRUE,
              status = "success",
              icon = shiny::icon("database"),
              width = "300px",
              tooltip = tooltipOptions(title = "Click to see possible datasets"),
              up = TRUE
            )
          )
        )
      ),
      
      # Q2 data tab item
      tabItem(
        tabName = "q2Data",
        fluidRow(
          box(
            title= "How are discussions about coding influenced by trends in remote work, digital nomadism, and gig economy employment, from the point of views of coding professionals?",
            status = "primary",
            width = 12,
            collapsible = T,
            uiOutput("selectedDatasetq2"),
            
            # Question 2 table
            DT::dataTableOutput("q2Table"),
            
            dropdownButton(
              # Panel title
              h4("List of Datasets"),
              
              
              selectInput(
                "question2DatasetTable",
                h5("Select Dataset:"),
                c("Dev.To", "Twitter")
              ),
              circle = TRUE,
              status = "success",
              icon = shiny::icon("database"),
              width = "300px",
              tooltip = tooltipOptions(title = "Click to see possible datasets"),
              up = TRUE
            )
          )
        )
      ),

      #--------------------------------------------------------------------------------------------------
      
      # Q3 Insights tab item
      tabItem(
        tabName = "q3Insights",
        fluidRow(
          box(
            title = "What innovative approaches or methodologies are emerging in the field of coding?",
            status = "primary",
            width = 12,
            collapsible = TRUE,
            tags$head(
              tags$style(HTML("
      /* Custom CSS for datatable */
      
      /* Custom CSS for datatable */
      .dataTables_wrapper {
        font-size: 14px; /* Adjust font size */
        font-family: Ariel, sans-serif; /* Adjust font family */
      }
      .dataTable th {
        background-color: #3498db; /* Blueish theme */
        color: white; /* Text color */
        font-weight: bold; /* Bold text */
      }
      .dataTable td, .dataTable th {
        border: 2px solid #ddd; /* Add border to table cells */
        padding: 8px; /* Add padding to table cells */
      }
      .dataTables_wrapper .dataTables_paginate {
        margin-top: 20px; /* Adjust pagination margin */
      }
      .dataTable tr:nth-child(odd) {
        background-color: #f2f2f2; /* Light gray background for odd rows */
      }
        /* CSS for custom button styles */
        .custom-btn {
          background-color: #4CAF50; /* Green */
          border: none;
          color: white;
          padding: 15px 32px;
          text-align: center;
          text-decoration: none;
          display: inline-block;
          font-size: 16px;
          margin: 4px 2px;
          cursor: pointer;
          border-radius: 10px;
        }
        .custom-btn:hover {
          background-color: #45a049; /* Darker Green */
        }
      "))),
            
            fluidRow(
              column(width = 3,
                     actionButton("move_to_barplot", "Bar Plot", class="custom-btn")
              ),
              column(width = 3,
                     actionButton("move_to_treemap", "Tree Map", class="custom-btn")
              ),
              column(width = 3,
                     actionButton("move_to_piechart", "Pie Chart", class="custom-btn")
              )
            ),
            br(),
            plotly::plotlyOutput("q3dynamicplot"),
            
            dropdownButton(
              # Panel title
              h4("List of Datasets"),
              
            
              selectInput(
                "question3Dataset",
                h5("Select Dataset:"),
                c("Twitter", "Reddit", "Dev.To")
              ),
              circle = TRUE,
              status = "success",
              icon = shiny::icon("database"),
              width = "300px",
              tooltip = tooltipOptions(title = "Click to see possible datasets"),
              up = TRUE
            )
          )
        )
      ),
      
      # Q3 data tab item
      tabItem(
        tabName = "q3Data",
        fluidRow(
        box(
          title= "What innovative approaches or methodologies are emerging in the field of coding?",
          status = "primary",
          width = 12,
          collapsible = T,
          uiOutput("selectedDataset"),
          
          # Question 3 table
          DT::dataTableOutput("q3Table"),
          
          dropdownButton(
            # Panel title
            h4("List of Datasets"),
            
            
            selectInput(
              "question3DatasetTable",
              h5("Select Dataset:"),
              c("Twitter", "Reddit", "Dev.To")
            ),
            circle = TRUE,
            status = "success",
            icon = icon("database"),
            width = "300px",
            tooltip = tooltipOptions(title = "Click to see possible datasets"),
            up = TRUE
          )
        )
        )
      ),

      #--------------------------------------------------------------------------------------------------

      # Q4 Insights tab item
      tabItem(
        tabName = "q4Insights",
        fluidRow(
          box(
            title = "Which programming languages were used before and after ChatGPT?",
            status = "primary",
            width = 12,
            collapsible = TRUE,
            tags$head(
              tags$style(HTML("
      /* Custom CSS for datatable */
      
      /* Custom CSS for datatable */
      .dataTables_wrapper {
        font-size: 14px; /* Adjust font size */
        font-family: Ariel, sans-serif; /* Adjust font family */
      }
      .dataTable th {
        background-color: #3498db; /* Blueish theme */
        color: white; /* Text color */
        font-weight: bold; /* Bold text */
      }
      .dataTable td, .dataTable th {
        border: 2px solid #ddd; /* Add border to table cells */
        padding: 8px; /* Add padding to table cells */
      }
      .dataTables_wrapper .dataTables_paginate {
        margin-top: 20px; /* Adjust pagination margin */
      }
      .dataTable tr:nth-child(odd) {
        background-color: #f2f2f2; /* Light gray background for odd rows */
      }
        /* CSS for custom button styles */
        .custom-btn {
          background-color: #4CAF50; /* Green */
          border: none;
          color: white;
          padding: 15px 32px;
          text-align: center;
          text-decoration: none;
          display: inline-block;
          font-size: 16px;
          margin: 4px 2px;
          cursor: pointer;
          border-radius: 10px;
        }
        .custom-btn:hover {
          background-color: #45a049; /* Darker Green */
        }
      "))),
            
            fluidRow(
              column(width = 3,
                     actionButton("move_to_barplot_q4", "Bar Plot", class="custom-btn")
              ),
              column(width = 3,
                     actionButton("move_to_treemap_q4", "Tree Map", class="custom-btn")
              ),
              column(width = 3,
                     actionButton("move_to_piechart_q4", "Pie Chart", class="custom-btn")
              )
            ),
            br(),
            plotly::plotlyOutput("q4dynamicplot"),

              selectInput(
                "question4Dataset",
                h5("Select Dataset:"),
                c("Devto", "StackOverflow")
              ),

              uiOutput("question4YearSelect")

          )
        )
      ),

      # Q4 data tab item
      tabItem(
        tabName = "q4Data",
        fluidRow(
        box(
          title= "Which programming languages were used before and after ChatGPT?",
          status = "primary",
          width = 12,
          collapsible = T,
          uiOutput("selectedDatasetq4"),
          
          # Question 4 table
          DT::dataTableOutput("q4Table"),
          
          dropdownButton(
            # Panel title
            h4("List of Datasets"),
            
            
            selectInput(
              "question4DatasetTable",
              h5("Select Dataset:"),
              c("Devto2022", "Devto2023", "StackOverflow2022", "StackOverflow2023")
            ),
            circle = TRUE,
            status = "success",
            icon = icon("database"),
            width = "300px",
            tooltip = tooltipOptions(title = "Click to see possible datasets"),
            up = TRUE
          )
        )
        )
      )

    )
  ), 
  skin = 'green'
)
