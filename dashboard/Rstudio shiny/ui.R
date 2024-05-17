library(shiny)
library(shinydashboard)
library(plotly)
library(shinyWidgets)
dashboardPage(
  header = dashboardHeader(title = "techAnalytics"),
  sidebar = dashboardSidebar(
    width = 250, 
    sidebarMenu(
      # Home menu item
      menuItem("Home",
                   tabName = "home",
                   icon = icon("home")),
      
      
      #Question 1 menu item
      menuItem(
        "Organizations",
        icon = shiny::icon("building"),
        tabName = "q1",
        menuSubItem("Insights", tabName = "q1Insights", icon = icon("line-chart")),
        menuSubItem("Data", tabName = "q1Data", icon = icon("table"))
      ),
      
      #Question 2 menu item
      menuItem(
        "Digital Nomadism",
        icon = shiny::icon("comments"),
        tabName = "q2",
        menuSubItem("Insights", tabName = "q2Insights", icon = icon("line-chart")),
        menuSubItem("Data", tabName = "q2Data", icon = icon("table"))
      ),
      
      # Question 3 menu item
      menuItem(
        "Innovations",
        icon = shiny::icon("microchip"),
        tabName = "q3",
        menuSubItem("Insights", tabName = "q3Insights", icon = icon("line-chart")),
        menuSubItem("Data", tabName = "q3Data", icon = icon("table"))
      ),

            # Question 4 menu item
      menuItem(
        "Languages",
        icon = icon("cogs"),
        tabName = "q4",
        menuSubItem("Insights", tabName = "q4Insights", icon = icon("line-chart")),
        menuSubItem("Data", tabName = "q4Data", icon = icon("table"))
      ),
      # Question 5 menu item
      menuItem(
        "Tools",
        icon = icon("cogs"),
        tabName = "q5",
        menuSubItem("Insights", tabName = "q5Insights", icon = icon("line-chart"))

      ),

      # Question 6 menu item
      menuItem(
        "Ethics",
        icon = icon("cogs"),
        tabName = "q6",
        menuSubItem("Insights", tabName = "q6Insights", icon = icon("line-chart"))
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
            br(),
            h4(
              HTML('&copy'),
              '2024 By Frog You'
            )
          ),
          
       
          # Projects, companies, and facilities value boxes
          uiOutput("instructionsBox"),
          uiOutput("questionBox"),
          uiOutput("datasetBox"),
          
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
            
            # fluidRow(
            #   column(width = 3,
            #          actionButton("move_to_treemap", "Tree Map", class="custom-btn")
            #   ),
            #   column(width = 3,
            #          actionButton("move_to_pyramid", "Pyramid Plot", class="custom-btn")
            #   )
            # ),
            # br(),
            plotlyOutput("q1dynamicplot"),
            fluidRow(
              
            column(width=1,dropdownButton(
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
            )),
            column(width = 1,dropdownButton(
              label = h4("Instructions"),
              icon = icon("info-circle"),
              menu = p("Hover over each bar  to see the number of mentions of each instance.
                         Click on the camera button on the upper right side to save the plot as a PNG file."),
              circle = TRUE,
              status = "info-circle",
              width = "300px",
              tooltip = tooltipOptions(title = "Click for instructions"),
              up =TRUE
            )))
          )
        ,
        box(
          title= "Key Findings",
          status = "success",
          width = 12,
          collapsible = T,
          h4("The takeaway from this data is that the organizations that are mentioned most often in the genAI for coding public discourse are mostly very big tech companies.
There are some minor differences between the data extracted from twitter and reddit but not really meaningful ones since the most cited are always the same.
In the list we found there are some interesting names that stand out when considering the names that one would assume to be more related to the generative ai 
public discussions (such as NVIDIA) and one can observe them in the treemap above.")
          
      ))),
        
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
          
          # Question 1 table
          DT::dataTableOutput("q1Table"),
          
          fluidRow(
            column(width = 1, dropdownButton(
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
          )),
          column(width = 1,dropdownButton(
            label = h4("Instructions"),
            icon = icon("info-circle"),
            menu = p("Click on any of the buttons to export dataset in the desired format. 
                       Use pagination to go to the next set of records.
                       Use search bar to search by keywords."),
            circle = TRUE,
            status = "info-circle",
            width = "300px",
            tooltip = tooltipOptions(title = "Click for instructions"),
            up =TRUE
          ))
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
            
            # fluidRow(
            #   column(width = 3,
            #          actionButton("move_to_barplot_q2", "Bar Plot", class="custom-btn")
            #   ),
            #   column(width = 3,
            #          actionButton("move_to_treemap_q2", "Tree Plot", class="custom-btn")
            #   )
            # ),
            # br(),
            plotlyOutput("q2dynamicplot"),
            
            fluidRow(
              column(width = 1,
            dropdownButton(
              # Panel title
              h4("List of Datasets"),
              
              
              selectInput(
                "question2Dataset",
                h5("Select Dataset:"),
                c( "Dev.To","Twitter sentiment", "Twitter topics")
              ),
              circle = TRUE,
              status = "success",
              icon = shiny::icon("database"),
              width = "300px",
              tooltip = tooltipOptions(title = "Click to see possible datasets"),
              up = TRUE
            )),
            column(width = 1,dropdownButton(
              label = h4("Instructions"),
              icon = icon("info-circle"),
              menu = p("Hover over each square to see the percentages of each instance."),
              circle = TRUE,
              status = "info-circle",
              width = "300px",
              tooltip = tooltipOptions(title = "Click for instructions"),
              up =TRUE
            ))
            
          )),
          
          box( 
            title= "Key Findings",
            status = "success",
            width = 12,
            collapsible = T,
            h4("TODO")
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
            fluidRow(
            column(width = 1,
            dropdownButton(
              # Panel title
              h4("List of Datasets"),
              
              
              selectInput(
                "question2DatasetTable",
                h5("Select Dataset:"),
                c("Dev.To", "Twitter sentiment", "Twitter topics")
              ),
              circle = TRUE,
              status = "success",
              icon = shiny::icon("database"),
              width = "300px",
              tooltip = tooltipOptions(title = "Click to see possible datasets"),
              up = TRUE
            )),
            column(width = 1,dropdownButton(
              label = h4("Instructions"),
              icon = icon("info-circle"),
              menu = p("Click on any of the buttons to export dataset in the desired format. 
                       Use pagination to go to the next set of records.
                       Use search bar to search by keywords."),
              circle = TRUE,
              status = "info-circle",
              width = "300px",
              tooltip = tooltipOptions(title = "Click for instructions"),
              up =TRUE
            ))
            
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
            
            br(),
            plotly::plotlyOutput("q3dynamicplot"),
            
            fluidRow(
              column(width = 1,
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
                       icon = icon("database"),
                       width = "300px",
                       tooltip = tooltipOptions(title = "Click to see possible datasets"),
                       up = TRUE
                     )
              ),
              column(width = 1,dropdownButton(
                label = h4("Instructions"),
                icon = icon("info-circle"),
                menu = p("Hover over each slice of the pie to see the percentages of each instance.
                         Click on the camera button on the upper right side to save the plot as a PNG file."),
                circle = TRUE,
                status = "info-circle",
                width = "300px",
                tooltip = tooltipOptions(title = "Click for instructions"),
                up =TRUE
              ))
              
              
            )
          ),
          box(
            title= "Key Findings",
            status = "success",
            width = 12,
            collapsible = T,
            h4("TODO")
        )
      )),
      
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
          
          fluidRow(
            column(width = 1,
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
            ),
            column(width = 1,dropdownButton(
              label = h4("Instructions"),
              icon = icon("info-circle"),
              menu = p("Click on any of the buttons to export dataset in the desired format. 
                       Use pagination to go to the next set of records.
                       Use search bar to search by keywords."),
              circle = TRUE,
              status = "info-circle",
              width = "300px",
              tooltip = tooltipOptions(title = "Click for instructions"),
              up =TRUE
            ))
           
            
          )
          
        )
      )),

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
            
            ##fluidRow(
             ## column(width = 3,
             ##        actionButton("move_to_barplot_q4", "Bar Plot", class="custom-btn")
             ## ),
              ##
              ##       actionButton("move_to_treemap_q4", "Tree Map", class="custom-btn", disabled = TRUE)
              ##),
              ##column(width = 3,
              ##       actionButton("move_to_piechart_q4", "Pie Chart", class="custom-btn", disabled = TRUE)
              ##)
            ##),
            br(),
            plotly::plotlyOutput("q4dynamicplot"),

              selectInput(
                "question4Dataset",
                h5("Select Dataset:"),
                c("Devto", "StackOverflow")
              ),

              uiOutput("question4YearSelect")

          ),
          
           box(
            title= "Key Findings",
            status = "success",
            width = 12,
            collapsible = T,
            h4("This analysis gathers data from Dev.to and StackOverflow. These are the two main user generated content websites where programming languages users share opinions. The above Data represents mentions that programming languages received in 2022 and 2023, before and after the release of ChatGPT. These mentions are generative AI agnostic."),
            h4("The analysis hilights small changes in the mention of programming languages before and after the release of ChatGPT. According to the data, the pace of innovation in Generative AI technology is higher than the pace of change in the adoption of programming languages. "),
            h4("Limitations: ChatGpt was release in November 2022, hence this analysis only takes into considerations two years, 2022 and 2023. It would be interesting for future studies to look at a wider window of time")
            )
        )
      ),

      # Q4 data tab item
      tabItem(
        tabName = "q4Data",
        fluidRow(
        box(
          title= "Programming languages adoption before and after the release of ChatGPT",
          status = "primary",
          width = 12,
          collapsible = T,
          uiOutput("selectedDatasetq4"),
          
          # Question 4 table
          DT::dataTableOutput("q4Table"),
          
          fluidRow(
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
      ),

      #--------------------------------------------------------------------------------------------------

      # Q5 Insights tab item
      tabItem(
        tabName = "q5Insights",
        fluidRow(
          box(
            title = "How do online conversations about competitive intelligence tools and software solutions compare in terms of user satisfaction, functionality, and ease of integration?",
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
            
            br(),

           box(
            title= "Key Findings",
            status = "success",
            width = 12,
            h5("Based on online conversations and reviews, users are most satisfied with Similarweb and Semrush when it comes to competitive intelligence tools and software solutions. This aligns with the findings of Lopes et al. (2023), who conducted a bibliometric analysis to assess competitive intelligence and business intelligence concepts.
                In terms of functionality, Similarweb is often praised for its market research capabilities, Sprout Social for its social listening features, Ahrefs for its SEO tools, and Semrush is frequently mentioned as a comprehensive all-in-one solution. This is consistent with the systematic literature review by Hatzijordanou et al. (2019) on competitor analysis, which identifies and compares major market measurements that help distinguish the services and goods of the competitors.
             As for ease of integration, the general consensus is that these tools should ideally be able to integrate with existing systems like Salesforce and provide workbench capabilities for consolidated analysis. However, the best tool ultimately depends on specific requirements and budget. It’s always recommended to read user reviews before making a decision
              ")
            ),
           box(
            title= "Sources",
            status = "success",
            width = 12,
            collapsible = T,
            h6("Lopes, B. de S., Amorim, V., Au-Yong-Oliveira, M., & Lima Rua, O. (2023). Competitive and Business Intelligence: A Bibliometric Analysis. In Quality Innovation and Sustainability (pp. 187–197). https://link.springer.com/chapter/10.1007/978-3-031-12914-8_15."),
            h6("Hatzijordanou, N., Bohn, N., & Terzidis, O. (2019). A systematic literature review on competitor analysis: status quo and start-up specifics. Management Review Quarterly, 69, 415–4582 https://link.springer.com/article/10.1007/s11301-019-00158-5."),
            h6("G2. (2024). Best Competitive Intelligence Tools in 2024. Retrieved from https://www.g2.com/categories/competitive-intelligence"),
            h6("G2. (2024). Best Enterprise Competitive Intelligence Tools in 2024. Retrieved from https://www.g2.com/categories/competitive-intelligence/enterprise"),
            h6("G2. (2024). Best Competitive Intelligence Tools for Small Business. Retrieved from https://www.g2.com/categories/competitive-intelligence/small-business"),
            h6("G2. (2024). Best Competitive Intelligence Tools for Medium-Sized Businesses. Retrieved from https://www.g2.com/categories/competitive-intelligence/mid-market"),
            h6("Zapier. (2024). The 9 best competitor analysis tools in 2024. Retrieved from https://zapier.com/blog/competitor-analysis-tools/"),
            h6("Evalueserve. (n.d.). Competitive Intelligence Solutions: 5 Ways to Ease Your Job. Retrieved from https://www.evalueserve.com/blog/competitive-intelligence-solutions-easier-job/"),
            h6("Content Boomerang. (n.d.). Competitive Intelligence Tools: Key Solutions for Strategic Business. Retrieved from https://contentboomerang.com/blog/competitive-intelligence-tools/"),
            h6("Semrush. (n.d.). The 14 Best Competitive Intelligence Tools for Market Research. Retrieved from https://www.semrush.com/blog/best-competitive-intelligence-tools/"),
            ),


          ),
        )
      ),

      #--------------------------------------------------------------------------------------------------

      # Q6 Insights tab item
      tabItem(
        tabName = "q6Insights",
        fluidRow(
          box(
            title = "What are the ethical implications of using genAI-driven competitive intelligence tools to gather and analyze data from competitor websites and social media profiles?",
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
            
            br(),

           box(
            title= "Process and Key Findings",
            status = "success",
            width = 12,
            h5("1- Quantitative attempt: we frist tried to answer this question using the same strategy of the previous answers. Definition of key words, filtering of relevant tweets, aggregation of data. In this case we tried filtering tweets by ethical key words and names of competitive intelligence tools. After that, we wanted to obtain the median value on the variable sentiment, in order to do a sentiment analysis regarding the perception of ethic in these tools.
              "),
            h5("2- Missing data: tools of competitive intelligence are mostly suing simple machine learning algorithms. Of the 22 tools we found all of them were not exploiting the potential of generative AI."),
            h5("3- Role of NLU: researches are being conducted in the arising field of tools for strategic and competitive intelligence using generative AI, but mostly are focused on the use these prwrful models as NLU, in order to process huge quantities of text data with greater understanding[1]."),
            h5("4-Ethical implications: ethical implications in this field regard therfore mostly on the issues arising by conducting webscraping practices, such as illegal access and use of data, breach of contract, copyright, trespass to chattels, and trade secrets[2]"),

            ),
           box(
            title= "Sources",
            status = "success",
            width = 12,
            collapsible = T,
            h6("De Los Reyes, Daniel & Trajano, Douglas & Manssour, Isabel & Vieira, Renata & Bordini, Rafael. (2021). Entity Relation Extraction from News Articles in Portuguese for Competitive Intelligence Based on BERT. 10.1007/978-3-030-91699-2_31."),
            h6("Krotov, V., Johnson, L., & Silva, L. (2020). Tutorial: Legality and Ethics of Web Scraping. Communications of the Association for Information Systems, 47, pp-pp. https://doi.org/10.17705/1CAIS.04724"),
            ),


          ),
        )
      )




    )
  ), 
  skin = 'green'
)
