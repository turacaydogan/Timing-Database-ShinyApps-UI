#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(readr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$procedure<- renderUI(input$var)
  output$datasets<- renderText({paste("You have selected", input$dataset)})
  output$table<-renderDataTable(input$dataset)

})
