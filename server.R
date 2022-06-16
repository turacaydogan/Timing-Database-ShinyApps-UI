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

shinyServer(function(input, output,session) {
  
  output$procedure = renderUI(input$var)
  observeEvent(input$reset_input,{
    updateCheckboxGroupInput(session,"TRdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"TBdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"PIdatasetInput", selected = F, inline = T)
    output$mytable = DT::renderDataTable({})
  })
  
  observeEvent(input$TRdatasetInput,{
    updateCheckboxGroupInput(session,"TBdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"PIdatasetInput", selected = F, inline = T)
    TRindex = match(TR_datasets, input$TRdatasetInput)
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
    updateCheckboxGroupInput(session,"TRdatasetInput", selected = F, inline = T)
    updateCheckboxGroupInput(session,"PIdatasetInput", selected = F, inline = T)
    TBindex = match(TB_datasets, input$TBdatasetInput)
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
    updateCheckboxGroupInput(session,"TBdatasetInput", selected = F)
    updateCheckboxGroupInput(session,"TRdatasetInput", selected = F)
    PIindex = match(PI_datasets, input$PIdatasetInput)
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
  #finaldataset=rbind(TR_bind,TB_bind,PI_bind)
 
  
  #output$datasets<- renderText({paste("You have selected", input$dataset)})
  #output$mytable = DT::renderDataTable({rbindlist(TR_data[input$TRdatasetInput])})
  output$summary <- renderText({
    return(paste(TRindex,TBindex))
  })
  
  
})
