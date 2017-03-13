library(shiny)
library(dplyr)

shinyUI(pageWithSidebar(
  headerPanel("Filtering with an uploaded file"),
  
  sidebarPanel(
    helpText("Upload a file to use as a filter."),
    tags$hr(),
    fileInput('file1', 'Choose CSV File from local drive, adjusting parameters if necessary',
              accept=c('text/csv', 'text/comma-separated-values,text/plain')),
    checkboxInput('header', 'Header', TRUE),
    radioButtons('sep', 'Separator',
                 c(Comma=',',
                   Semicolon=';',
                   Tab='\t'),
                 'Comma'),
    radioButtons('quote', 'Quote',
                 c(None='',
                   'Double Quote'='"',
                   'Single Quote'="'"),
                 'Double Quote'),
    tags$head(tags$style(type="text/css",
                         "label.radio { display: inline-block; margin:0 10 0 0;  }",
                         ".radio input[type=\"radio\"] { float: none; }"))
    ),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Original Data",
               plotOutput("baseplot"),
               value = 1),
      tabPanel("Uploaded Data",
               plotOutput("csvfiltered"),
               value = 2),
      tabPanel("Highlighted Data",
               plotOutput("highlight"),
               value = 3),
      id="tabs1")
  )
  )) 