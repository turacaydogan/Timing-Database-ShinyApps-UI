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
library(DT)
library(data.table)

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

FI_files<-list.files(path = paste(getwd(),"/FI_datasets",sep=""), recursive = TRUE, pattern = "\\.csv$", full.names = TRUE)
FI_datasets<-gsub(".*/","",FI_files)
FI_data <- lapply(FI_files, read.csv, stringsAsFactors = FALSE)
FI_data <- lapply(FI_data,'[',,1:10)
for (j in 1:length(FI_datasets)) {FI_data[[j]] = cbind(FI_datasets[j],FI_data[[j]])}

TOJ_files<-list.files(path = paste(getwd(),"/TOJ_datasets",sep=""), recursive = TRUE, pattern = "\\.csv$", full.names = TRUE)
TOJ_datasets<-gsub(".*/","",TOJ_files)
TOJ_data <- lapply(TOJ_files, read.csv, stringsAsFactors = FALSE)
TOJ_data <- lapply(TOJ_data,'[',,1:16)
for (j in 1:length(TOJ_datasets)) {TOJ_data[[j]] = cbind(TOJ_datasets[j],TOJ_data[[j]])}

TE_files<-list.files(path = paste(getwd(),"/TE_datasets",sep=""), recursive = TRUE, pattern = "\\.csv$", full.names = TRUE)
TE_datasets<-gsub(".*/","",TE_files)
TE_data <- lapply(TE_files, read.csv, stringsAsFactors = FALSE)
TE_data <- lapply(TE_data,'[',,1:10)
for (j in 1:length(TE_datasets)) {TE_data[[j]] = cbind(TE_datasets[j],TE_data[[j]])}

TA_files<-list.files(path = paste(getwd(),"/TA_datasets",sep=""), recursive = TRUE, pattern = "\\.csv$", full.names = TRUE)
TA_datasets<-gsub(".*/","",TA_files)
TA_data <- lapply(TA_files, read.csv, stringsAsFactors = FALSE)
TA_data <- lapply(TA_data,'[',,1:10)
for (j in 1:length(TA_datasets)) {TA_data[[j]] = cbind(TA_datasets[j],TA_data[[j]])}

# DRL_files<-list.files(path = paste(getwd(),"/DRL_datasets",sep=""), recursive = TRUE, pattern = "\\.csv$", full.names = TRUE)
# DRL_datasets<-gsub(".*/","",DRL_files)
# DRL_data <- lapply(DRL_files, read.csv, stringsAsFactors = FALSE)
# DRL_data <- lapply(DRL_data,'[',,1:9)
# for (j in 1:length(DRL_datasets)) {DRL_data[[j]] = cbind(DRL_datasets[j],DRL_data[[j]])}

OTHER_files<-list.files(path = paste(getwd(),"/OTHER_datasets",sep=""), recursive = TRUE, pattern = "\\.csv$", full.names = TRUE)
OTHER_datasets<-gsub(".*/","",OTHER_files)
OTHER_data <- lapply(OTHER_files, read.csv, stringsAsFactors = FALSE)
#OTHER_data <- lapply(OTHER_data,'[',,1:10)
for (j in 1:length(OTHER_datasets)) {OTHER_data[[j]] = cbind(OTHER_datasets[j],OTHER_data[[j]])}


shinyServer(function(input, output,session) {
  # reactive_var = reactive({c(input$reset_input,input$TRdatasetInput,input$TBdatasetInput,input$PIdatasetInput,input$TOJdatasetInput,input$TEdatasetInput,input$TAdatasetInput,input$DRLdatasetInput,input$OTHERdatasetInput)})
  output$procedure = renderUI(input$var)
  observeEvent(input$reset_input,{
    # updateCheckboxGroupInput(session,inputID = c(input$TRdatasetInput,input$TBdatasetInput,input$PIdatasetInput,input$FIdatasetInput,input$TOJdatasetInput,input$TEdatasetInput,input$TAdatasetInput,input$DRLdatasetInput,input$OTHERdatasetInput), selected = F, inline = T)
    updateCheckboxGroupInput(session,"TRdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TBdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"PIdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"FIdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TOJdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TEdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TAdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"DRLdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"OTHERdatasetInput", selected = F, inline = T)
    output$mytable = DT::renderDataTable({})
  })
  # observeEvent(input$var,x)
  observeEvent(input$TRdatasetInput,{
    # updateCheckboxGroupInput(session,inputId = c("TBdatasetInput","PIdatasetInput","FIdatasetInput","TOJdatasetInput","TEdatasetInput","TAdatasetInput","DRLdatasetInput","OTHERdatasetInput"), selected = F, inline = T)
    updateCheckboxGroupInput(session,"TBdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"PIdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"FIdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TOJdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TEdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TAdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"DRLdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"OTHERdatasetInput", selected = F, inline = T)
    TRindex = match(input$TRdatasetInput,TR_datasets)
    TR_bind=rbindlist(TR_data[TRindex],fill=TRUE)
    output$mytable = DT::renderDataTable({
      TR_bind
    })
    output$downloadData <- downloadHandler(
      filename = function() { 
        paste("TR_dataset-", Sys.Date(), ".csv", sep="")
      },
      content = function(file) {
        write.csv(TR_bind, file)
      })
  })
  observeEvent(input$TBdatasetInput,{
    # updateCheckboxGroupInput(session,inputId = c("TRdatasetInput","PIdatasetInput","FIdatasetInput","TOJdatasetInput","TEdatasetInput","TAdatasetInput","DRLdatasetInput","OTHERdatasetInput"), selected = F, inline = T)
    updateCheckboxGroupInput(session,"TRdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"PIdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"FIdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TOJdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TEdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TAdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"DRLdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"OTHERdatasetInput", selected = F, inline = T)
    TBindex = match(input$TBdatasetInput,TB_datasets)
    TB_bind = rbindlist(TB_data[TBindex],fill=TRUE)
    output$mytable = DT::renderDataTable({
      TB_bind
    })
    output$downloadData <- downloadHandler(
      filename = function() { 
        paste("TB_dataset-", Sys.Date(), ".csv", sep="")
      },
      content = function(file) {
        write.csv(TB_bind, file)
      })
  })
  observeEvent(input$PIdatasetInput,{
    # updateCheckboxGroupInput(session,inputId = c("TRdatasetInput","TBdatasetInput","FIdatasetInput","TOJdatasetInput","TEdatasetInput","TAdatasetInput","DRLdatasetInput","OTHERdatasetInput"), selected = F, inline = T)
    updateCheckboxGroupInput(session,"TRdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TBdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"FIdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TOJdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TEdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TAdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"DRLdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"OTHERdatasetInput", selected = F, inline = T)
    PIindex = match(input$PIdatasetInput,PI_datasets)
    PI_bind = rbindlist(PI_data[PIindex],fill=TRUE)
    output$mytable = DT::renderDataTable({
      PI_bind
    })
    output$downloadData <- downloadHandler(
      filename = function() { 
        paste("PI_dataset-", Sys.Date(), ".csv", sep="")
      },
      content = function(file) {
        write.csv(PI_bind, file)
      })
  })
  observeEvent(input$FIdatasetInput,{
    # updateCheckboxGroupInput(session,inputId = c("TRdatasetInput","TBdatasetInput","PIdatasetInput","TOJdatasetInput","TEdatasetInput","TAdatasetInput","DRLdatasetInput","OTHERdatasetInput"), selected = F, inline = T)
    updateCheckboxGroupInput(session,"TRdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TBdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"PIdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TOJdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TEdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TAdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"DRLdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"OTHERdatasetInput", selected = F, inline = T)
    FIindex = match(input$FIdatasetInput,FI_datasets)
    FI_bind = rbindlist(FI_data[FIindex],fill=TRUE)
    output$mytable = DT::renderDataTable({
      FI_bind
    })
    output$downloadData <- downloadHandler(
      filename = function() {
        paste("FI_dataset-", Sys.Date(), ".csv", sep="")
      },
      content = function(file) {
        write.csv(PI_bind, file)
      })
  })
  observeEvent(input$TOJdatasetInput,{
    # updateCheckboxGroupInput(session,inputId = c("TRdatasetInput","TBdatasetInput","PIdatasetInput","FIdatasetInput","TEdatasetInput","TAdatasetInput","DRLdatasetInput","OTHERdatasetInput"), selected = F, inline = T)
    updateCheckboxGroupInput(session,"TRdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TBdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"PIdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"FIdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TEdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TAdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"DRLdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"OTHERdatasetInput", selected = F, inline = T)
    TOJindex = match(input$TOJdatasetInput,TOJ_datasets)
    TOJ_bind = rbindlist(TOJ_data[TOJindex],fill=TRUE)
    output$mytable = DT::renderDataTable({
      TOJ_bind
    })
    output$downloadData <- downloadHandler(
      filename = function() { 
        paste("TOJ_dataset-", Sys.Date(), ".csv", sep="")
      },
      content = function(file) {
        write.csv(TOJ_bind, file)
      })
  })
  observeEvent(input$TEdatasetInput,{
    # updateCheckboxGroupInput(session,inputId = c("TRdatasetInput","TBdatasetInput","PIdatasetInput","FIdatasetInput","TOJdatasetInput","TAdatasetInput","DRLdatasetInput","OTHERdatasetInput"), selected = F, inline = T)
    updateCheckboxGroupInput(session,"TRdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TBdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"PIdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"FIdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TOJdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TAdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"DRLdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"OTHERdatasetInput", selected = F, inline = T)
    TEindex = match(input$TEdatasetInput,TE_datasets)
    TE_bind = rbindlist(TE_data[TEindex],fill=TRUE)
    output$mytable = DT::renderDataTable({
      TE_bind
    })
    output$downloadData <- downloadHandler(
      filename = function() { 
        paste("TE_dataset-", Sys.Date(), ".csv", sep="")
      },
      content = function(file) {
        write.csv(TE_bind, file)
      })
  })
  observeEvent(input$TAdatasetInput,{
    # updateCheckboxGroupInput(session,inputId = c("TRdatasetInput","TBdatasetInput","PIdatasetInput","FIdatasetInput","TOJdatasetInput","TEdatasetInput","DRLdatasetInput","OTHERdatasetInput"), selected = F, inline = T)
    updateCheckboxGroupInput(session,"TRdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TBdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"PIdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"FIdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TOJdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TEdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"DRLdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"OTHERdatasetInput", selected = F, inline = T)
    TAindex = match(input$TAdatasetInput,TA_datasets)
    TA_bind = rbindlist(TA_data[TAindex],fill=TRUE)
    output$mytable = DT::renderDataTable({
      TA_bind
    })
    output$downloadData <- downloadHandler(
      filename = function() { 
        paste("TA_dataset-", Sys.Date(), ".csv", sep="")
      },
      content = function(file) {
        write.csv(TA_bind, file)
      })
  })
  # observeEvent(input$DRLdatasetInput,{
  #   # updateCheckboxGroupInput(session,inputId = c("TRdatasetInput","TBdatasetInput","PIdatasetInput","FIdatasetInput","TOJdatasetInput","TEdatasetInput","TAdatasetInput","OTHERdatasetInput"), selected = F, inline = T)
  #   updateCheckboxGroupInput(session,"TRdatasetInput", selected = F, inline = T)
  #   updateCheckboxGroupInput(session,"TBdatasetInput", selected = F, inline = T)
  #   updateCheckboxGroupInput(session,"PIdatasetInput", selected = F, inline = T)
  #   updateCheckboxGroupInput(session,"FIdatasetInput", selected = F, inline = T)
  #   updateCheckboxGroupInput(session,"TOJdatasetInput", selected = F, inline = T)
  #   updateCheckboxGroupInput(session,"TEdatasetInput", selected = F, inline = T)
  #   updateCheckboxGroupInput(session,"TAdatasetInput", selected = F, inline = T)
  #   updateCheckboxGroupInput(session,"OTHERdatasetInput", selected = F, inline = T)
  #   DRLindex = match(input$DRLdatasetInput,DRL_datasets)
  #   DRL_bind = rbindlist(DRL_data[DRLindex],fill=TRUE)
  #   output$mytable =DT::renderDataTable({
  #     DRL_bind
  #   })
  #   output$downloadData <- downloadHandler(
  #     filename = function() { 
  #       paste("DRL_dataset-", Sys.Date(), ".csv", sep="")
  #     },
  #     content = function(file) {
  #       write.csv(DRL_bind, file)
  #     })
  # })
  observeEvent(input$OTHERdatasetInput,{
    # updateCheckboxGroupInput(session,inputId = c("TRdatasetInput","TBdatasetInput","PIdatasetInput","FIdatasetInput","TOJdatasetInput","TEdatasetInput","TAdatasetInput","DRLdatasetInput"), selected = F, inline = T)
    updateCheckboxGroupInput(session,"TRdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TBdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"PIdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"FIdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TOJdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TEdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TAdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"DRLdatasetInput", selected = F, inline = T)
    OTHERindex = match(input$OTHERdatasetInput,OTHER_datasets)
    OTHER_bind = rbindlist(OTHER_data[OTHERindex],fill=TRUE)
    output$mytable = DT::renderDataTable({
      OTHER_bind
    })
    output$downloadData <- downloadHandler(
      filename = function() { 
        paste("OTHER_dataset-", Sys.Date(), ".csv", sep="")
      },
      content = function(file) {
        write.csv(OTHER_bind, file)
      })
  
  })
  # output$summary <- renderText({
  #   return(paste(TRindex,TBindex))
  })
  
  
# })
