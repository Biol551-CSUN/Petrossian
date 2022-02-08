### I am experimenting with the variations I can add to my penguin plot.
### Created by: Cynthia Petrossian
### Created on: 2022-02-08
##############################################

### load libraries ########
library(tidyverse) #Do this every time
library(palmerpenguins) #penguin data that will be used

### data analysis ###########
glimpse(penguins) #to see penguin dataset

ggplot(data=penguins, #creating plot box
       mapping = aes(x = bill_depth_mm, #adding x axis as bill depth
                     y = bill_length_mm, #adding y axis as bill length
                     color = species, #making the points different colors by species
                     shape = species, #shape is different according to species
                     size = body_mass_g, #the larger the penguin, the bigger the shape
                     alpha = flipper_length_mm)) + #the longer the flippers, the darker the shape
  geom_point()+  #making geometry point
  # facet_grid(species~sex) #adding facet grids, species is rows, sex is columns, ~ means as a function of
  facet_wrap (~ species, ncol=2) #facet separating by species, ~ before for columns, ~ after for rows. ncol=2 means make it two columns
  labs(title = "Bill Depth and Length", #adding title
       subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins", #adding subtitle
       x = "Bill Depth (mm)", y = "Bill Length (mm)", #adding axes titles
       color = "Species", #making species capitalized
       shape = "Species", #making the titles identical
       caption = "Source: Palmer Station LTER / palmerpengins package")+ #adds source
  scale_color_viridis_d() #makes colorblind friendly
