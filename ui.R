


library(shiny)
# WORKING DIRECTIORY SHOULD BE SET TO THE SOURCE FILE

# TOP MENU>>SESSION>>SET WORKING DIRECTORY>>CHOOSE DIRECTORY

# setwd("G:directory/to/this/file")
TR_files<-list.files(path = paste(getwd(),"/TR_datasets",sep=""), recursive = TRUE, pattern = "\\.csv$", full.names = TRUE)
TB_files<-list.files(path = paste(getwd(),"/TB_datasets",sep=""), recursive = TRUE, pattern = "\\.csv$", full.names = TRUE)
PI_files<-list.files(path = paste(getwd(),"/PI_datasets",sep=""), recursive = TRUE, pattern = "\\.csv$", full.names = TRUE)
TR_datasets<-gsub(".*/","",TR_files)
TB_datasets<-gsub(".*/","",TB_files)
PI_datasets<-gsub(".*/","",PI_files)



# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Timing Database"),

    sidebarLayout(
    sidebarPanel(
    selectInput('var', 'Select procedure', choices = c('Temporal Reproduction'=1,'Temporal Bisection'=2,'Peak Procedure'=3)),
    conditionalPanel(condition = 'input.var==1',
                     checkboxGroupInput('dataset', 'Select Datasets', choices = c(TR_datasets))),
                    #  TR_data <- lapply(TR_files, read.csv, stringsAsFactors = FALSE)),
    conditionalPanel(condition = 'input.var==2',
                     checkboxGroupInput('dataset', 'Select Datasets', choices = c(TB_datasets))),
                   #  TB_data <- lapply(TB_files, read.csv, stringsAsFactors = FALSE)),
    conditionalPanel(condition = 'input.var==3',
                     checkboxGroupInput('dataset', 'Select Datasets', choices = c(PI_datasets))),
                    # PI_data <- lapply(PI_files, read.csv, stringsAsFactors = FALSE)),
      
        ),

        # Show a plot of the generated distribution
        mainPanel(
            textOutput('datasets')
        )
    )
))
