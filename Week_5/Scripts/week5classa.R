### Today we are going to practice joins with data from Becker and Silbiger (2020) ####
### Created by: Cynthia Petrossian ####
### Created on: 2022-02-22 ####

### Load Libraries ####
library(tidyverse)
library(here)

### Load Data ####
# Environmental data from each site
EnviroData <- read_csv(here("Week_5", "Data", "site.characteristics.data.csv"))

#Thermal performance data
TPCData <- read_csv(here("Week_5", "Data", "Topt_data.csv"))

EnviroData_wide <- EnviroData %>% 
  pivot_wider (names_from = parameter.measured, #pivot the data wider
               values_from = values) %>% 
  arrange(site.letter) #arrange the dataframe by site (rows)

FullData_left <- left_join(TPCData, EnviroData_wide) %>% 
  relocate(where(is.numeric), .after = where(is.character)) #relocate all the columns so numeric data goes after character data
view(FullData_left)

summary <- FullData_left %>% #create summary
  group_by(site.letter) %>% #group by site
  summarise_if(is.numeric, list(mean = mean, var = var), na.rm = TRUE) #summarize if numeric, list mean and var

#Make 1 tibble
T1<- tibble(Site.ID = c("A", "B", "C", "C"),
             Temperature = c(14.1, 16.7, 15.3, 12.8))
T2 <- tibble(Site.ID = c("A", "B", "D", "E"),
                         pH = c(7.3, 7.8, 8.1, 7.9))
T2
left_join(T1,T2)
right_join(T1,T2)
inner_join(T1,T2)
full_join(T1,T2)
semi_join(T1,T2)
anti_join(T1,T2)
