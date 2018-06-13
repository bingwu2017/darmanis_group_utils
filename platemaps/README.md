# Using platetools

## platetools Git
find the original github repo for platemaps here: https://github.com/Swarchal/platetools

or access the vignette directly: https://gist.github.com/Swarchal/b938933ae9ded94b3c14d6485b27cf69

## Goal of platetools


platetools can generate platemaps for 96 and 384 plates

## Installation
platetools is an R package  (`install.packages("platetools")`)


## Input data and example data

### Input data
The input data for platetools is a dataframe where at minumum the wells must be defined (example: A1-P24) and the variable to map (example: genes)

### Example data
For our group example you can use stats.csv. This data contains the unique gene counts per cell and total reads per cell as they pertain to single cell library preparation from home-brew Tn5 at two different concentrations (1ng and 2ng) and Nextera.
