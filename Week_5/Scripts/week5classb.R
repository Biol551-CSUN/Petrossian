### Today we will be using the lubridate package ####
### Created by: Cynthia Petrossian ####
### Created on: 2022-02-24 ####

### Load Libraries ####
library(tidyverse)
library(here)
library(lubridate)

### Functions ####
now() #what time is it now
now(tzone = "EST") #what time is it on the east coast
now(tzone = "GMT") #what time is it in GMT
today() #the date today
today(tzone = "GMT") #the date in GMT
am(now()) #is it morning? will give true or false
leap_year(now()) #is it a leap year?
ymd("2021-02-24") #year month day - will output ymd
mdy("02/24/2021") #month day year - will output ymd
mdy("February 24, 2021") #month day year - will output ymd
ymd_hms("2021-02-24 10:22:20 PM")
mdy_hms("02/24/2021 22:22:28")
mdy_hm("February 24, 2021 10:22 PM")

#make a character string
datetimes <- c("02/24/2021 22:22:20",
               "02/25/2021 11:21:10",
               "02/26/2021 8:01:52")

#convert to datetimes
datetimes <- mdy_hms(datetimes)

month(datetimes) #pulls up all months
month(datetimes, label = TRUE) #this prints out month name shortened
month(datetimes, label = TRUE, abbr = FALSE) #prints out the full name of the month
day(datetimes) #extracts date
wday(datetimes, label = TRUE) #extracts day of week
hour(datetimes) #extracts hours
minute(datetimes) #extracts minutes
second(datetimes) #extracts seconds
datetimes + hours(4) #this adds four hours, to add hours the function is hourS, to extract hours it is hour
datetimes + days(4) #adds days
round_date(datetimes, "minute") #round to the nearest minute
round_date(datetimes, "5 mins") #round to the nearest 5 minutes

### Read In Data ####
CondData <- read_csv(here("Week_5", "Data", "CondData.csv")) %>%
  mutate(datetime = mdy_hms(depth)) %>% 
  drop_na()
view(CondData)