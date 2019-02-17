library(tidyverse)
gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")

# ----------------------------------
# 1A. Modify the following code to make a figure that shows how life expectancy has changed over time:

# Base code
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) + 
  geom_point()

# Modifications

# A way to look at it with whole range of countries
ggplot(gapminder, aes(x = year, y = lifeExp)) + 
  geom_point()     

# By continent
gapminder %>% 
  ggplot(aes(x = year, y = lifeExp, color = continent)) +
  geom_point ()

# A way to look at is as total average number, without attention to countries -- this gives you the clearest trend.
year_avg_lifeExp <- gapminder %>% 
  group_by(year) %>% 
  arrange(.by_group = TRUE) %>% 
  mutate(avg_lifeExp = mean(lifeExp)) %>% 
  select(year, lifeExp, avg_lifeExp)

ggplot(year_avg_lifeExp, aes(x = year, y = avg_lifeExp)) + 
  geom_point()

# Or, did you want to keep gdpPercap in there? If so, maybe like this... which is a little tough to get a read on

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, color = year)) + 
  geom_point() 

# Or like this... which is also tough

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) + 
  geom_point() +
  facet_wrap(~year)
#----------------------------------------
# 1B. Exploring this code...

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

# What do do I think scale_x_log10 is doing? When I removed it from the above code, you could see that is transformed the x-axis by a log scale to show the data more clearly

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

# What does geom_smooth do? When I removed it the trend line and its errors disappear. Thus, geom_smooth seems to provide a trend line

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  theme_bw()

# -----------------------------------
# 1C. Modify the above code to size the points in proportion to the population of the county. I included "pop" as a size aesthetic. I wish I knew how to make the key a litle more appealing, though

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent, size = pop)) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()
