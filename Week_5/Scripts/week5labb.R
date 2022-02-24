### Today we will be using the lubridate package ####
### Created by: Cynthia Petrossian ####
### Created on: 2022-02-24 ####

### Load Libraries ####
library(tidyverse)
library(here)
library(lubridate)

### Read In Data ####
CondData <- read_csv(here("Week_5", "Data", "CondData.csv")) #read in Cond data
DepthData <- read_csv(here("Week_5", "Data", "DepthData.csv")) #read in Depth data

view(CondData)
view(DepthData)

###Data Analysis ####
CondData <- CondData %>%
  mutate(datetime = mdy_hms(depth)) %>% #add new datetime column with dates converted correctly
  drop_na() %>% #drop NAs
  mutate(datetime = round_date(datetime, "10 seconds")) #add new column with times rounded to nearest 10 second
view(CondData)

DepthData <- DepthData %>%
  mutate(datetime = ymd_hms(date)) %>% #add new datetime column with dates converted correctly
  drop_na() #drop NAs
view(DepthData)

CondDepthData <- inner_join(CondData, DepthData, by = "datetime") %>% #join datasets to exclude missing info
  mutate(hours = hour(datetime)) %>% #extract hours into new column
  mutate(minutes = minute(datetime)) %>% #extract minutes into new column
  unite(col = "Hours_Mins", #unite hours and minutes column into new combined column names "Hours_Mins"
        c(hours, minutes), #select hours and minutes columns
        sep = ":", #separate by :
        remove = TRUE) %>% #remove hours and minutes columns
  select(datetime, Depth, TempInSitu, SalinityInSitu_1pCal, Hours_Mins) #select these columns
view(CondDepthData)

Summary <- CondDepthData %>%  #create Summary object
  group_by(Hours_Mins) %>% #group by minute
  summarise_at(c("datetime", "Depth", "TempInSitu", "SalinityInSitu_1pCal"), mean) #summarise at these columns and calculate the mean
view(Summary)

Summary %>% 
  ggplot(aes(x = SalinityInSitu_1pCal, #set x axis as Depth
             y = Depth, #set y axis as Salinity
             color = datetime))+ #set color by datetime
  geom_point()+ #set geom to point
  labs(title = "Depth vs. Salinity In Situ by Time", #change title
       x = "Salinity In Situ 1 p Cal", #change x axis title
       color = "Time") #change legend title

ggsave(here("Week_5", "Outputs", "week5labb.png"), #saving plot as png
       width = 7, height = 5) #changing dimensions to 7 x 5 inches
