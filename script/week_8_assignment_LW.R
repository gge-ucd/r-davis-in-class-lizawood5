
library(tidyverse)
library(lubridate)

am_riv <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/2015_NFA_solinst_08_05.csv", skip = 13)

# PART 1

# Paste date and time columns together
am_riv$datetime <- paste(am_riv$Date, " ", am_riv$Time, sep = "")

# Converting to datetime data
am_riv$datetime <- ymd_hms(am_riv$datetime)

# Make new column for week and calculate 
am_riv$wk <- week(am_riv$datetime)

am_riv2 <- am_riv %>% 
  group_by(wk) %>% 
  summarize(mean_wk = mean(Temperature), min_wk = min(Temperature), max_wk = max(Temperature))

# Plotting at point graph
am_riv2 %>% 
  ggplot()+
  geom_point(aes(x=wk, y = mean_wk), color = "blue")+
  geom_point(aes(x=wk, y = min_wk), color = "green")+
  geom_point(aes(x=wk, y = max_wk), color= "orange")+
  xlab("Week")+ ylab("Temp")+
  theme_bw()

# New columns for hour and month
am_riv$hourly <- hour(am_riv$datetime)
am_riv$month <- month(am_riv$datetime)

# Mean hourly level for April-June
am_riv_summer <- am_riv %>% 
  filter(month == 4 | month == 5 | month == 6) %>% 
  group_by(hourly, month, datetime) %>% 
  summarize(mean_level = mean(Level))

# Plot of mean hourly level from April_June
am_riv3%>% 
  ggplot() +
  geom_line(aes(x=datetime, y = mean_level), color = "blue") +
  ylim(1, 2)+
  theme_bw()


# PART 2

# Make a datetime column
mloa_2001$datetime <- paste(mloa_2001$year, "-", mloa_2001$month, "-", mloa_2001$day, " ", mloa_2001$hour24, ":", mloa_2001$min)

# Convert to datetime format
mloa_2001$datetime<- ymd_hm(mloa_2001$datetime) 

# Remove NAs

mloa1 <- mloa_2001 %>% 
  filter(rel_humid != -99, rel_humid != -999) %>% 
  filter(temp_C_2m!= -99, temp_C_2m != -999) %>% 
  filter(windSpeed_m_s!= -99, windSpeed_m_s != -999)

#New function

plot_temp <- function(monthtoimput, dat = mloa1){
  df <- filter(dat, month == monthtoimput)
  plot <- df %>% 
    ggplot()+ geom_line(aes(x=datetime, y = temp_C_2m), color = "blue")+
    theme_bw()
  return(plot)
}

#Plot of just April (4th month) temperatures 
plot_temp(4)
