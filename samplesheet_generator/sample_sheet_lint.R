# This script will generate sample sheets for sequencing runs.
# Requires two .csv files: an input file (with the indexes used) and the Master index sheet (constant).
# Michelle Tan, last edit 07/07/2018


library(tidyverse)


### Values will be the same for the entire column of sample sheet
Study_ID <- "SCLung05"
Study_Description <- "SingleCell_RNAseq"
BioSample_ID <- ""
BioSample_Description <- "SingleCell_RNAseq_from_primary_cells"
Sample_ID <- c()
Sample_Owner <- "Ashley"
Organism <- "Human"
Host <- ""
Gender <- ""
Tissue_Source <- ""
FACS_Markers <- ""


#### feed me correct index and input file from local!
index <- read_csv(file = "Non-combinitorial Index (12).csv")
input <- read_csv("input 2.csv")
index_subset <- subset(index, index_plate %in% input$index)


####selecting correct i7 and i5 in accordance to sequencer 
if (input$sequencer[1] == "novaseq" || input$sequencer[1] == "miseq") {
  update_index_subset <- index_subset %>%
  select(Index_ID = index_name, Index = index_i7_revcom, Index2 = index2_i5_revcom, well_id, index_plate)
} else {
  update_index_subset <- index_subset %>%
    select(Index_ID = index_name, Index = index_i7_revcom, Index2 = index2_i5, well_id, index_plate)
}


##### matching LP plate to index 
update_index_subset$LP_plate <- input$LP_plate[match(update_index_subset$index_plate, input$index)]

#### adding column for sample ID by concatenating well_ID and LP plate, edit here to change sample ID if needed 
update_index_subset <- update_index_subset %>%
  add_column(Sample_Name = paste(update_index_subset$well_id, "_", update_index_subset$LP_plate, sep = ""))
  
  
#### adding in all columns needed for sequencing submission, no need to update  
final_update <- update_index_subset %>%
  add_column(Study_ID, Study_Description, BioSample_Description, BioSample_ID, Sample_Owner, Sample_ID = update_index_subset$Sample_Name, Index2_ID = update_index_subset$Index_ID, Organism, Host, Gender, Tissue_Source, FACS_Markers) %>%
  select(Study_ID, Study_Description, BioSample_ID, BioSample_Description, Sample_ID, Sample_Name, Sample_Owner, Index_ID, Index, Index2_ID, Index2, Organism, Host, Gender, Tissue_Source, FACS_Markers)


date2 <- Sys.Date()
write_csv(final_update, paste(date2, "_sample_sheet.csv", sep = ""))