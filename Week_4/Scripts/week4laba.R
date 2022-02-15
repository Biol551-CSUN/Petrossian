### Today we are going to plot penguin data ####
### Created by: Cynthia Petrossian #############
### Updated on: 2022-02-15 #####################

### Load Libraries ###
library (palmerpenguins)
library(tidyverse)
library(here)

###Load Data ###
# The data is part of the package and is called penguins

### Part 1 ###
data <- penguins %>% #assign penguins dataframe to "data", load dataframe
  drop_na(sex) %>% #drop NA values in sex column
  group_by(species, island, sex) %>% #group by species, island, and sex
  summarise(mean_body_mass = mean(body_mass_g, na.rm=TRUE), #calculate body mass mean
            variance_body_mass = var(body_mass_g, na.rm=TRUE)) #calculate body mass variance
view(data) #view data

### Part 2 ###
penguins %>% #load penguin dataframe
  filter(sex != "male") %>% #filter against males
  mutate(log_mass = log(body_mass_g)) %>% #calculate log of body mass and add new data column
  select(species, island, sex, log_mass) %>% #select for species, island, sex, and log_mass columns only
  ggplot(aes(x = species, #create plot, set x axis as species
             y = log_mass, #set y axis as log_mass
             color = island))+ #set colors to different islands
  geom_point(position = position_jitterdodge()) + #set geometry as point - jitter
labs(title = "Log of Female Penguin Body Mass vs. Species", #change plot title
     x = "Species", #change x axis title
     y = "Log of Body Mass", #change y axis title
     caption = "Source: Palmer Station LTER / palmerpengins package", #add caption for source
     color = "Island", #change legend title to Island
     shape = "Island") #change legend title to Island

ggsave(here("Week_4", "Outputs", "penguinslogmass.png"), #saving in output folder
       width = 7, height = 5) #changing image size to 7 x 5 inches