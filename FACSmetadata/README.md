# FACSmetadata

## Plot FACSmetadata with sequencing data
plotSortingMetadata.Rmd is written in R. It takes the FACS metadata and use ggplot to visulize them. The metadata can also be merged with sequencing data by cell names (containing plate and index information) to visulize gene expression or seurat cluster identity on the same plot with FACS measurements. The input includes FACS metadata exported from SONY in csv format and a seurat object. An example output can be found in plotSortingMetadata.html
