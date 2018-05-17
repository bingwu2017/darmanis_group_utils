# This script will generate sample sheet for sequencing runs.
# Requires two .csv files: an input file (with the indexes used) and the Master index sheet.
# Michelle Tan, last edit 04/23/2018


library(tidyverse)


### Values will be the same for the entire column
Study_ID <- "SCLUNG_NEXT6"
Study_Description <- "sclung_sclungnext6"
BioSample_ID<-''
BioSample_Description <- "scrnaseq_lungadeno_pt_samples"
Sample_ID <- c()
Sample_Owner <- "Ashley"
Organism <- "Human"
Host <- ''
Gender <-''
Tissue_Source <- ''
FACS_Markers <- ''

index<- read_csv(file = "Non-combinitorial Index (12).csv")
input <- read_csv("~/code/darmanis_group_utils/samplesheet_generator/input.csv") ###change
unique_index <- unique(input$index)
new_index <- subset(index, index_plate %in% unique_index) 



if (input$sequencer[1] == "novaseq" || input$sequencer[1] == "miseq" || input$sequencer[1] == "nextseq" ){
  update_index <-new_index %>%
    select(Index_ID = index_name,Index= index_i7_revcom,Index2=index2_i5_revcom,well_id,index_plate)
  
} else {
  update_index <- new_index %>%
    select(Index_ID=index_name,Index=index_i7_revcom,Index2= index2_i5,well_id,index_plate)
}

update_index$LP_plate <- input$LP_plate[match(update_index$index_plate,input$index)]

update_update <- update_index %>%
  add_column(Sample_ID = paste(update_index$well_id,'_',update_index$LP_plate, sep = "")) %>%
  add_column(Study_ID, Study_Description,BioSample_Description,BioSample_ID,Sample_Owner,Sample_Name = update_update$Sample_ID,Index2_ID= update_update$Index_ID,Organism,Host,Gender, Tissue_Source, FACS_Markers) %>%
  select(Study_ID,Study_Description,BioSample_ID,BioSample_Description,Sample_ID, Sample_Name, Sample_Owner, Index_ID, Index, Index2_ID, Index2,Organism, Host, Gender, Tissue_Source, FACS_Markers)

  date2<- Sys.Date()
  write_csv(update_update, paste(date2,"_sample_sheet.csv",sep='' ))

            