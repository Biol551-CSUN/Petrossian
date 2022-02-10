### Today we are going to plot penguin data #######
### Created by: Cynthia Petrossian ################
### Created on: 2022-02-10 ########################

### Load Libraries ##########
library (palmerpenguins)
library(tidyverse)
library(here)
library(beyonce)
library(ggthemes)

### Load Data ####
# The data is part of the package and is called penguins
# How else besides gimpse can we inspect the data?
glimpse(penguins)

### Data Analysis ####
plot1 <- ggplot(data=penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species)) +
  geom_point()+
  geom_smooth(method = "lm")+ 
  labs(x = "Bill Depth(mm)",
       y = "Bill Length (mm)")+
 # scale_color_viridis_d()
  scale_color_manual(values = beyonce_palette(18))+
  #scale_x_continuous(breaks = c(14,17,21),
                     ##labels = c("low", "medium", "high"))
  #coord_flip() flips x and y axes
  #coord_fixed() fix axes to 1:1 ratio
  #coord_polar("x")
theme_bw()+
theme(axis.title = element_text(size = 14,
                                color = "blue"),
      panel.background = element_rect(fill = "linen"))
ggsave(here("Week_3", "Outputs", "penguin.png"),
       width = 7, height = 5)
