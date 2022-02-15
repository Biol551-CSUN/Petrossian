### Today we are going to plot penguin data ####
### Created by: Cynthia Petrossian #############
### Updated on: 2022-02-15 #####################

### Load Libraries ###
library (palmerpenguins)
library(tidyverse)
library(here)

###Load Data ###
# The data is part of the package and is called penguins
glimpse(penguins)
head(penguins)
filter(.data = penguins, 
       sex == "female") #filtering for only female penguins, = is an assignment (data is penguins), == is a question (is sex exactly equal to female), returns a true or false

filter(.data = penguins, 
       year == 2008) #filtering for penguins measured in 2008

filter(.data = penguins, 
       body_mass_g > 5000) #filtering for penguins with a body mass greater than 5000g

filter(.data = penguins, 
       sex == "female", 
       body_mass_g > 5000) #combining the filters

filter(.data = penguins, 
       year == 2008 | year == 2009) #filtering for 2008 or 2009

filter(.data = penguins, 
       island !="Dream") #filtering against the island Dream

filter(.data = penguins, 
       species %in% c("Adelie","Gentoo")) #filtering for both Adelie and Gentoo species using the vector 

filter(.data = penguins, 
       body_mass_g < 5000, 
       body_mass_g >3000) #filtering for below 5000 g but above 3000 g

data2 <- mutate(.data = penguins,
                body_mass_kg = body_mass_g/1000, #adding a new column for body mass in kg
                bill_length_depth = bill_length_mm/bill_depth_mm) #adding a new column for ratio of length to depth
view(data2)

data2 <- mutate(.data = penguins,
                after_2008 = ifelse(year>2008, "After 2008", "Before 2008")) #ifelse is for 2 outcomes
view(data2)

data2 <- mutate(.data = penguins,
                flipper_plus_mass = flipper_length_mm + body_mass_g) #adding a new column with flipper length and body mass added together
view(data2)

data2 <- mutate(.data = penguins,
                size = ifelse(body_mass_g>4000, "Big", "Small")) #adding a new column labeling size as big or small depending on if mass less than or greater than 4000
view(data2)

penguins %>% #use penguins dataframe, Ctrl + Shft + M for %>% hotkey, which is the pipe (then do this)
  filter(sex == "female") %>% #filter for females
  mutate(log_mass = log(body_mass_g)) %>% #clauclate biomass
  select(Species = species, island, sex, log_mass) #select is for columns, filter is for rows. You can also use select() to rename columns, like with species to Species

penguins %>% 
  summarise(mean_flipper = mean(flipper_length_mm, na.rm=TRUE), #computer a table of summarized data - calculate mean flipper length and exlcude any NAs,
            min_flipper = min(flipper_length_mm, na.rm=TRUE)) 

penguins %>% 
  group_by(island, sex) %>% #group summary by island and sex
  summarise(mean_bill_length = mean(bill_length_mm, na.rm=TRUE),
            max_bill_length = max(bill_length_mm, na.rm=TRUE))

penguins %>% 
  drop_na(sex) %>% #drop NAs
  group_by(island, sex) %>% 
  summarise(mean_bill_length = mean(bill_length_mm, na.rm=TRUE))

penguins %>% 
  drop_na(sex) %>% 
  ggplot(aes(x = sex,
             y = flipper_length_mm)) +
  geom_boxplot() #make boxplot
