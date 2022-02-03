### This is my first script. I am learning how to import data
### Created by: Cynthia Petrossian
### Created on: 2022-02-03
##############################################

### load libraries ########
library(tidyverse)
library(here)

### Read in data #####
WeightData <- read_csv(here("Week_2","Data","weightdata.csv")) #weight data

# Data analysis ####
head(WeightData) # look at top 6 lines
tail(WeightData) # look at bottom 6 lines
view(WeightData) # view the dataset

