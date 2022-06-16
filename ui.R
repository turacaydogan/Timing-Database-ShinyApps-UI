


library(shiny)
library(DT)
library(data.table)
# WORKING DIRECTIORY SHOULD BE SET TO THE SOURCE FILE

# TOP MENU>>SESSION>>SET WORKING DIRECTORY>>CHOOSE DIRECTORY

# setwd("G:directory/to/this/file")
#lapply(TR_data,'[',,1:10)
#rbindlist(TR_data[])

TR_files<-list.files(path = paste(getwd(),"/TR_datasets",sep=""), recursive = TRUE, pattern = "\\.csv$", full.names = TRUE)
TR_datasets<-gsub(".*/","",TR_files)
TR_data <- lapply(TR_files, read.csv, stringsAsFactors = FALSE)
TR_data <- lapply(TR_data,'[',,1:10)
for (j in 1:length(TR_datasets)) {TR_data[[j]] = cbind(TR_datasets[j],TR_data[[j]])}

TB_files<-list.files(path = paste(getwd(),"/TB_Datasets",sep=""), recursive = TRUE, pattern = "\\.csv$", full.names = TRUE)
TB_datasets<-gsub(".*/","",TB_files)
TB_data <- lapply(TB_files, read.csv, stringsAsFactors = FALSE)
TB_data <- lapply(TB_data,'[',,1:11)
for (j in 1:length(TB_datasets)) {TB_data[[j]] = cbind(TB_datasets[j],TB_data[[j]])}

PI_files<-list.files(path = paste(getwd(),"/PI_Datasets",sep=""), recursive = TRUE, pattern = "\\.csv$", full.names = TRUE)
PI_datasets<-gsub(".*/","",PI_files)
PI_data <- lapply(PI_files, read.csv, stringsAsFactors = FALSE)
PI_data <- lapply(PI_data,'[',,1:10)
for (j in 1:length(PI_datasets)) {PI_data[[j]] = cbind(PI_datasets[j],PI_data[[j]])}



# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Timing Database"),

    sidebarLayout(
    sidebarPanel(
    selectInput('var', 'Select procedure', choices = c('Temporal Reproduction'=1,'Temporal Bisection'=2,'Peak Procedure'=3)),
    conditionalPanel(condition = 'input.var==1',
                     checkboxGroupInput('TRdatasetInput', 'Select Datasets', choices = c(TR_datasets))),
                    
    conditionalPanel(condition = 'input.var==2',
                     checkboxGroupInput('TBdatasetInput', 'Select Datasets', choices = c(TB_datasets))),
                   
    conditionalPanel(condition = 'input.var==3',
                     checkboxGroupInput('PIdatasetInput', 'Select Datasets', choices = c(PI_datasets))),
                    
    actionButton("reset_input", "Reset Choice"), 
    downloadButton('downloadData', 'Download csv')
    #actionButton("choose_all", "Choose All") 
        ),

        # Show a plot of the generated distribution
        mainPanel(
    #     textOutput("summary"),
         DT::dataTableOutput("mytable")
          
        )
    )
))

