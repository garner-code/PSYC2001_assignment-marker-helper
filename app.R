library(shiny)
library(zip)   # for cross-platform zipping
source("assets/dataGen.R")
source("assets/performStats.R")


# Define UI for data download app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("PSYC2001 Assignment Marker Helper 2026"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Enter student number
      numericInput("zID", label = h3("Student number (without z)"), value = 1234567),
      
      #Input: enter number of participants
#      numericInput("N", label = h3("Number of participants"), value = 6),
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      h2("Key Results"),
      br(),
      
      h3("Paired t-test on v1 vs v2"),
      # 
      verbatimTextOutput("paired"),
      br(),
      
      h3("Independent samples t-test (v1 ~ group)"),
      #
      verbatimTextOutput("indy_v1"),
      br(),

      h3("One sample t-test (v1)"),
      verbatimTextOutput("one_samp"),
      br(),

      h3("Correlation v1 vs v2"),
      verbatimTextOutput("corr"),
      br(),
      br(),
      
      h2("Back Up"),
      br(),
      h3("Independent samples t-test (v2 ~ group)"),
      verbatimTextOutput("indy_v2"),
      br(),
      
      h3("One Sample t-test (v2)"),
      verbatimTextOutput("one_samp_v2"),
      br(),
      
      br(),
      br(),
      br()
      
    )
    
  )
)

# Define server logic to display and download selected file ----
server <- function(input, output) {
  
  # generate data
  testResults <- reactive({
    dat <- dataGen(input$zID)
    performStats(dat)
  })
  
  
  # collect test results
  output$paired <- renderPrint(testResults()$paired_t)
  output$indy_v1 <- renderPrint(testResults()$indy_v1)
  output$one_samp <- renderPrint(testResults()$one_samp)
  output$corr <- renderPrint(testResults()$cor)
  output$indy_v2 <- renderPrint(testResults()$indy_v2)
  output$one_samp_v2 <- renderPrint(testResults()$one_samp_v2)
}

# Create Shiny app ----
shinyApp(ui, server)
