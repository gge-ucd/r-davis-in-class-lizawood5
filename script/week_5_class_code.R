#managing data with dplyr
library(tidyverse)
install.packages("tidyverse")
?filter
library(stats)

surveys <- read_csv("data/portal_data_joined.csv")
str(surveys)
#this is now called a tbl (tibble) -- columns are characters, not factors -- so it is a fancy data frame accorinding to tidyverse

#dplyer functions -- select, filter, grouby, and summarize

#select is used when we want to select columns in a data frame
#in parenthese, just put data frame, then use commas to separate names of all columns you want)
select(surveys, plot_id, species_id, weight)

#use filter to select rows, according to one column (in this year, all rows from a certai year from the year column)
filter(surveys, year == 1995)

#if you want to do this together, you could do intermediate steps and combine them
surveys2 <- filter(surveys, weight < 5)
surveys_sml <- select(surveys2, species_id, sex, weight)

#but, taking steps like this can be very clunky, so you can combine them with a pipe
#pipe is %>%, and there is a shortcut of command + shift + M  -- it takes the into from the right of the pipe, and moves it to the left of the pipe

surveys %>%
  filter(weight < 5) %>% 
  select(species_id, sex, weight)

#think about a pipe sign as the word "then..."

#challenge: subset surveys to include individuals collected before 1995 and retain only the columns year, sex and weight

surveys %>% filter(year < 1995) %>% select(year, sex, weight)
tail(surveys %>% filter(year < 1995) %>% select(year, sex, weight))

# mutate function in dplyr -- used to create new columns
#want weight from g to kg (mutate the column you want)

surveys <- surveys %>%
  mutate(weight_kg = weight/1000) %>% 
  mutate(weight_kg2 = weight_kg * 2)

#like above, you can stack all of the mutations

#looking at the data, there are a lot of NAs... so what if we want to get rid of them, exclamation ! means not, so this below reads  not is NA

surveys %>%
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight/1000) %>% 
  summary()

#if you wanted to filted out all NAs, use "complete cases"

#challenge:
challenge <- surveys %>% 
  mutate(hindfoot_half = hindfoot_length/2) %>% 
  filter(hindfoot_half < 30) %>% 
  filter(!is.na(hindfoot_half))
challenge <- challenge %>% 
  select(species_id)

#group using grouby for split-apply-combine
#we want mean weight of males, and mean weight of females

surveys %>% 
  group_by(sex) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE))

#so mutate adds new columb to an existing data frame, while summarze spit sout a new data frame

#command view allows you to look at a tibble without making it a dataframe

#missed the tally and whole NA thing

#you can use grouby with multiple columns

surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight)) %>% 
  View()

#or instead

surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight), min_weight = min(weight)) %>% 
  View()

#tally function

surveys %>% 
  group_by(sex) %>% 
  tally() %>% View

#tally is the same as group_by(something) %>% summarize(new_column = n())

#gatehring and spreading -- spreading takes a long format dataframe (a lot of rows and a couple columns) and changes it into a wide format dataframe

#spread takes the data you want to spread, the key column variables (the one you want to make into a bunch of new columns) and the value variable is what you want to populate those columns with

surveys_gw <- surveys %>% filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarize(mean_weight = mean(weight))

surveys_spread <- surveys_gw %>% 
  spread(key = genus, value = mean_weight)

#if you don't want NAs
surveys_gw %>% spread(genus, mean_weight, fill = 0)

#gathering, basically saying use all of the columns, except plot id, to fill in the key variable...
surveys_gather <- surveys_spread %>% 
  gather(key = genus, value = mean_weight, -plot_id) %>% 
  View
#the fill = 0 does not hold when we gather