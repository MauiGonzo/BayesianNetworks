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
#setwd('D:/Assignments/Bayesian Network/Assignment/Code/BayesianNetworks/')
#getwd()

source("initPackages.R")
source("importData.R")

source("preProcessData.R")

source("variableTesting.R")