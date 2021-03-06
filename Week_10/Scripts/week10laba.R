library(tidyverse)
data <- tibble::tribble(
  ~Waypoint,        ~Zone,     ~Lat,      ~Long, ~Site,  ~Season, ~Tide_time,    ~Temp_in,   ~Salinity, ~Phosphate, ~Silicate,  ~NN,   ~pH,         ~TA, ~percent_sgd,
         1L, "Transition", 21.27531, -157.76181,   "W", "SPRING",  "Low_Day", 23.75505834,  27.7402879,       0.54,    157.93, 7.92, 7.909,  2161.48229,  20.40439276,
         2L, "Transition", 21.27523, -157.76265,   "W", "SPRING",  "Low_Day", 23.53255956,  30.6119226,       0.36,     92.59, 3.37, 7.965, 2145.827701,   11.9625323,
         3L, "Transition", 21.27504, -157.76328,   "W", "SPRING",  "Low_Day",          NA, 28.37007862,        0.5,     143.6, 7.29, 8.023,  2272.39081,  18.55297158,
         4L, "Transition", 21.27449, -157.76402,   "W", "SPRING",  "Low_Day", 24.01982367, 32.82124424,       0.25,     42.32, 0.79, 7.995, 2219.583262,  5.467700258,
         5L,    "Diffuse", 21.27503,  -157.7617,   "W", "SPRING",  "Low_Day", 23.26102354, 29.12292683,        0.5,    126.47, 7.45, 8.005, 2151.825559,  16.33979328
  )

view(data)

data1 <- data %>%
  filter(Zone == "Transtion") 
  summarise(Temp_mean_vals = mean(Temp_in))
  
data1



library(tidyverse)
library(palmerpenguins)

penguins %>%
  ggplot(aes(x= bill_depth_mm,
             y = bill_length_mm,
             color = island)) +
  geom_point() +
  geom_smooth(method = lm) +
  labs(title = "Comparing Penguins Length and Depth",
       x = "Depth (mm)",
       y = "Length (mm)")
