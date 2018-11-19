
library(tidyverse)
library(stringr)
library(ggplot2)
library(kableExtra)
library(lubridate)
library(knitr)
library(readr)
library(dplyr)
library(haven)
library(base)

# Define UI for application.

app_data <- read_rds("ps_7.rds")

ui <- fluidPage(
  
  # Creating a Title
  titlePanel("California Midterm 2018 Election Context"),
  
  # Formatting the layout of the page 
  sidebarLayout(
    sidebarPanel(
      h4("Plot Parameters"),
      selectInput("y", "Y-axis:",
                  choices = c("trump16", "clinton16", "romney12", "obama12", "demhouse16", "rephouse16", 
                              "white_pct", "black_pct", "hispanic_pct", "nonwhite_pct", "foreignborn_pct",
                              "median_hh_inc", "lesshs_pct","lesscollege_pct"),
                  selected = "trump16"),
      selectInput("x", "Color By:",
                  c("county"),
                  selected = "real_rep_adv"),
      hr(),
      helpText("Data from Upshot NYT")
    ),
    
    
    mainPanel(
      plotOutput("barplot")
    )
  )
)


server <- function(input, output) {
  
  output$barplot <- renderPlot({
    
    
    ##Read in the results data from UPSHOT
    california %>% 
      ggplot(aes_string(x = input$x, y = input$y, fill = input$y)) +
      geom_bar(position = "dodge") +
      theme_linedraw(base_size = 13) +
      ggtitle(paste(input$x, "and", input$y, "Demographics of the Sample")) + 
      labs(x = input$x, y = "Count")
    
    
  })
}


# Run the application below. 

shinyApp(ui = ui, server = server)

