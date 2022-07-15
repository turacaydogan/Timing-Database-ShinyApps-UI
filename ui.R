
library(shiny)
library(DT)

TR_files<-list.files(path = paste(getwd(),"/TR_datasets",sep=""), recursive = TRUE, pattern = "\\.csv$", full.names = TRUE)
TR_datasets<-gsub(".*/","",TR_files)
# TR_data <- lapply(TR_files, read.csv, stringsAsFactors = FALSE)
# TR_data <- lapply(TR_data,'[',,1:10)
# for (j in 1:length(TR_datasets)) {TR_data[[j]] = cbind(TR_datasets[j],TR_data[[j]])}

TB_files<-list.files(path = paste(getwd(),"/TB_Datasets",sep=""), recursive = TRUE, pattern = "\\.csv$", full.names = TRUE)
TB_datasets<-gsub(".*/","",TB_files)
# TB_data <- lapply(TB_files, read.csv, stringsAsFactors = FALSE)
# TB_data <- lapply(TB_data,'[',,1:11)
# for (j in 1:length(TB_datasets)) {TB_data[[j]] = cbind(TB_datasets[j],TB_data[[j]])}

PI_files<-list.files(path = paste(getwd(),"/PI_Datasets",sep=""), recursive = TRUE, pattern = "\\.csv$", full.names = TRUE)
PI_datasets<-gsub(".*/","",PI_files)
# PI_data <- lapply(PI_files, read.csv, stringsAsFactors = FALSE)
# PI_data <- lapply(PI_data,'[',,1:10)
# for (j in 1:length(PI_datasets)) {PI_data[[j]] = cbind(PI_datasets[j],PI_data[[j]])}

FI_files<-list.files(path = paste(getwd(),"/FI_datasets",sep=""), recursive = TRUE, pattern = "\\.csv$", full.names = TRUE)
FI_datasets<-gsub(".*/","",FI_files)
# FI_data <- lapply(FI_files, read.csv, stringsAsFactors = FALSE)
# FI_data <- lapply(FI_data,'[',,1:11)
# for (j in 1:length(FI_datasets)) {FI_data[[j]] = cbind(FI_datasets[j],FI_data[[j]])}

TOJ_files<-list.files(path = paste(getwd(),"/TOJ_datasets",sep=""), recursive = TRUE, pattern = "\\.csv$", full.names = TRUE)
TOJ_datasets<-gsub(".*/","",TOJ_files)
# TOJ_data <- lapply(TOJ_files, read.csv, stringsAsFactors = FALSE)
# TOJ_data <- lapply(TOJ_data,'[',,1:16)
# for (j in 1:length(TOJ_datasets)) {TOJ_data[[j]] = cbind(TOJ_datasets[j],TOJ_data[[j]])}

TE_files<-list.files(path = paste(getwd(),"/TE_datasets",sep=""), recursive = TRUE, pattern = "\\.csv$", full.names = TRUE)
TE_datasets<-gsub(".*/","",TE_files)
# TE_data <- lapply(TE_files, read.csv, stringsAsFactors = FALSE)
# TE_data <- lapply(TE_data,'[',,1:10)
# for (j in 1:length(TE_datasets)) {TE_data[[j]] = cbind(TE_datasets[j],TE_data[[j]])}

TA_files<-list.files(path = paste(getwd(),"/TA_datasets",sep=""), recursive = TRUE, pattern = "\\.csv$", full.names = TRUE)
TA_datasets<-gsub(".*/","",TA_files)
# TA_data <- lapply(TA_files, read.csv, stringsAsFactors = FALSE)
# TA_data <- lapply(TA_data,'[',,1:10)
# for (j in 1:length(TA_datasets)) {TA_data[[j]] = cbind(TA_datasets[j],TA_data[[j]])}

DRL_files<-list.files(path = paste(getwd(),"/DRL_datasets",sep=""), recursive = TRUE, pattern = "\\.csv$", full.names = TRUE)
DRL_datasets<-gsub(".*/","",DRL_files)
# DRL_data <- lapply(DRL_files, read.csv, stringsAsFactors = FALSE)
# DRL_data <- lapply(DRL_data,'[',,1:9)
# for (j in 1:length(DRL_datasets)) {DRL_data[[j]] = cbind(DRL_datasets[j],DRL_data[[j]])}

OTHER_files<-list.files(path = paste(getwd(),"/OTHER_datasets",sep=""), recursive = TRUE, pattern = "\\.csv$", full.names = TRUE)
OTHER_datasets<-gsub(".*/","",OTHER_files)
# OTHER_data <- lapply(OTHER_files, read.csv, stringsAsFactors = FALSE)
# #OTHER_data <- lapply(OTHER_data,'[',,1:10)
# for (j in 1:length(OTHER_datasets)) {OTHER_data[[j]] = cbind(OTHER_datasets[j],OTHER_data[[j]])}

shinyUI(fluidPage(

    # Application title
    titlePanel("Timing Database"),

    sidebarLayout(
    sidebarPanel(
    selectInput('var', 'Select procedure', choices = c('Temporal Reproduction'=1,'Temporal Bisection'=2,'Peak Procedure'=3, 'Fixed Interval'=4, 'Temporal Order Judgment'=5, 'Temporal Estimation'=6, 'Tapping'=7, 'DRL'=8, 'Other'=9)),
    conditionalPanel(condition = 'input.var==1',
                     checkboxGroupInput('TRdatasetInput', 'Select Datasets', choices = c(TR_datasets))),
                    
    conditionalPanel(condition = 'input.var==2',
                     checkboxGroupInput('TBdatasetInput', 'Select Datasets', choices = c(TB_datasets))),
                   
    conditionalPanel(condition = 'input.var==3',
                     checkboxGroupInput('PIdatasetInput', 'Select Datasets', choices = c(PI_datasets))),
    
    conditionalPanel(condition = 'input.var==4',
                     checkboxGroupInput('FIdatasetInput', 'Select Datasets', choices = c(FI_datasets))),
    
    conditionalPanel(condition = 'input.var==5',
                     checkboxGroupInput('TOJdatasetInput', 'Select Datasets', choices = c(TOJ_datasets))),
    
    conditionalPanel(condition = 'input.var==6',
                     checkboxGroupInput('TEdatasetInput', 'Select Datasets', choices = c(TE_datasets))),
    
    conditionalPanel(condition = 'input.var==7',
                     checkboxGroupInput('TAdatasetInput', 'Select Datasets', choices = c(TA_datasets))),
    
    conditionalPanel(condition = 'input.var==8',
                     checkboxGroupInput('DRLdatasetInput', 'Select Datasets', choices = c(DRL_datasets))),
    
    conditionalPanel(condition = 'input.var==9',
                     radioButtons('OTHERdatasetInput', 'Select Datasets',  choices = c("None selected", OTHER_datasets))),

    actionButton("reset_input", "Reset Choice"), 
    downloadButton('downloadData', 'Download csv')
    #actionButton("choose_all", "Choose All") 
        ),

    mainPanel(
      DT::dataTableOutput("mytable")
          
        )
    )
))

