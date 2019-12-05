### assignmentBN.R

# master script for the assignment
# Denise
# Shima
# Maurice
#

# executes basics
#
# install.packages("readr")
library(readr)
# install.packages("dplyr")
library(dplyr) # run module
library(dagitty)
library(bnlearn)

# before running anything, set a working dir
# setwd("<your dir>")
source("initPackages.R")
source("importData.R")

source("preProcessData.R")

source("variableTesting.R")
source("dagModel.R") 
