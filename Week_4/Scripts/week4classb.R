############################################
#### Today we are going to practice tidy with biogeochemistry data from Hawaii #
#### Created by: Cynthia Petrossian ############################################
#### Created on: 2022-02-17 ###################################################

### Load Libraries ####
library(tidyverse)
library(here)

### Load Data ####
ChemData <- read_csv(here("Week_4", "Data", "chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)

### Data Analysis ####
ChemData_clean <- ChemData %>% 
  filter(complete.cases(.)) %>% #filters out everything that isn't a complete row
  separate(col = Tide_time, #choose the time tide column
           into = c("Tide", "Time"), #separate it into two columns Time and Time
           sep = "_", #separate by _
           remove = FALSE) %>% #keep the original tide_time column
  unite(col = "Site_Zone", #the name of hte NEW column
        c(Site,Zone), #the columns to unite
        sep = ".", #separate by .
        remove = FALSE) #keep the original

ChemData_long <- ChemData_clean %>% 
  pivot_longer(cols = Temp_in:percent_sgd, #the columns you want to pivot. this says select the temperature in to percent SGD columns
               names_to = "Variables", #the names of the new column with all the variables
               values_to = "Values") #names of the new column with all the values

ChemData_long %>% 
  group_by(Variables, Site, Zone, Tide) %>% #group by everything we want
  summarise(Param_means = mean(Values, na.rm = TRUE), #calculate mean
            Param_vars = var(Values, na.rm = TRUE),#calculate variance
            Param_sd = sd(Values, na.rm = TRUE)) #calculate standard deviation

ChemData_long %>% 
  ggplot(aes(x = Site,
             y = Values)) +
  geom_boxplot() +
  facet_wrap(~Variables, scales = "free") #frees up x and y axis so they don't have to be the same. free_y will free up only y and free_x will free up only x

###Start from the beginning for csv file export####

ChemData_wide <- ChemData_long %>% 
  pivot_wider(names_from = Variables, #column with names for the new columns
              values_from = Values) #column with the values

ChemData_clean <- ChemData %>% 
  filter(complete.cases(.)) %>%  #filters out everything that is not a complete row
  separate(col = Tide_time, #choose the tide time column
           into = c("Tide","Time"), #separate it into two columns Tide and Time
           sep = "_", #separate by _
           remove = FALSE) %>% 
  pivot_longer(cols = Temp_in:percent_sgd, #the columns you want to pivot
               names_to = "Variables", #The name of the new column with all the Variables
               values_to = "Values") %>% #The name of the new column with all the values
  group_by(Variables, Site, Time) %>% 
  summarise(mean_vals = mean(Values, na.rm = TRUE)) %>% 
  pivot_wider(names_from = Variables,
              values_from = mean_vals) %>% 
  write_csv(here("Week_4", "Outputs", "summary.csv")) #export as a csv to folder
