############################################
#### Week 4 Lab 2 - Today we are going to practice tidy with biogeochemistry data from Hawaii #
#### Created by: Cynthia Petrossian ############################################
#### Created on: 2022-02-17 ###################################################

### Load Libraries ####
library(tidyverse) #Load tidyverse
library(here) #Load here

### Load Data ####
ChemData <- read_csv(here("Week_4", "Data", "chemicaldata_maunalua.csv")) #Load dataset

### Data Analysis ####
ChemData_clean <- ChemData %>%
  filter(complete.cases(.)) %>% #filter out everything that isn't a complete row
  separate(col = Tide_time, #choose the Tide_time column
           into = c("Tide", "Time"), #separate the column into two different columns, Tide and Time
           sep = "_", #separate by _
           remove = FALSE) %>% #keep the original Tide_time column
  filter(Time == "Day") %>% 
  rename("Temperature" = Temp_in)

ChemData_long <- ChemData_clean %>% 
  pivot_longer(cols = Temperature:Phosphate, #the columns you want to pivot. this says select the temperature in to phosphate columns
               names_to = "Variables", #the names of the new column with all the variables
               values_to = "Values") %>% #names of the new column with all the values
  group_by(Variables, Season, Zone) %>% #group by Variables, Season, and Zone
  summarise(mean_vals = mean(Values, na.rm = TRUE), #calculate mean
            var_vals = var(Values, na.rm = TRUE)) %>% #calculate variance
  write_csv(here("Week_4", "Outputs", "week4labb.csv")) #export as .csv file

ChemData_long %>% 
  ggplot(aes(x = Season, #setting x axis as Season
             y = mean_vals, #setting y axis as mean values
             color = Season))+ #color according to Season
  geom_point()+ #setting geometry as point
  facet_wrap(~Variables, scales = "free")+ #facet wrap by variables, change scales to free
  guides(color = FALSE)+ #remove legend
  labs(title = "Seasons vs. Mean Values During Daytime", #change title
       subtitle = "Plot of Seasons vs. Means Values for Phosphate, Salinity, and Temperature", #change subtitle
       y = "Mean Values", #change y axis title
       caption = "Source: Silbiger et al. 2020") #add source caption

ggsave(here("Week_4", "Outputs", "week4labb.png"), #saving plot as png
       width = 7, height = 5) #changing dimensions to 7 x 5 inches
