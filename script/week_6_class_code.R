library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
library(ggplot2)

#take all NAs out of the weight, hindfood_length, and sex column 

surveys_complete <- surveys %>% 
  filter(!is.na(weight), !is.na(hindfoot_length), !is.na(sex))

species_counts <- surveys_complete %>% 
  group_by(species_id) %>% 
  tally() %>% 
  filter(n >= 50)

surveys_complete <- surveys_complete %>% 
  filter(species_id %in% species_counts$species_id)

species_keep <- c("DM", "DO")
#example of list we could use instead of the row in a dataframe

#Writing your dataframe to .csv

write_csv(surveys_complete, path = "output/surveys_complete.csv")
#----------------
# ggplot(data = DATA, mapping = aes(MAPPINGS)) + 
# geom_function()

ggplot(data = surveys_complete)

# define a mapping

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point()

# saving a plot object
surveys_plot <- ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))

surveys_plot +
  geom_point()

# try making a hexbin plot
surveys_plot +
  geom_hex()

install.packages("hexbin")

# we're going to build plots from the ground up
ggplot(surveys_complete, aes(x = weights, y = hindfoot_length))

# modifying whole geom appearances
surveys_complete %>% 
  ggplot(aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, color = "tomato")

# using data in a geom
surveys_complete %>% 
  ggplot(aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, aes(color = species_id))

# putting color as a global aesthetic
surveys_complete %>% 
  ggplot(aes(x = weight, y = hindfoot_length, color = species_id)) +
  geom_point(alpha = 0.1)

# using a little jitter
surveys_complete %>% 
  ggplot(aes(x = weight, y = hindfoot_length, color = species_id)) +
  geom_jitter(alpha = 0.1)

# moving on to boxplots
surveys_complete %>% 
  ggplot(aes(x = species_id, y = weight)) +
  geom_boxplot()

# adding points to boxplot
surveys_complete %>% 
  ggplot(aes(x = species_id, y = weight)) +
  geom_jitter(alpha = 0.01, color = "tomato") +
  geom_boxplot(alpha = 0)

# plotting time series
yearly_counts <- surveys_complete %>% 
  count(year, species_id)

yearly_counts %>% 
  ggplot(aes(x = year, y = n, group = species_id, color = species_id)) +
  geom_line()

# facetting 
yearly_counts %>% 
  ggplot(aes(x = year, y = n, color = species_id)) +
  geom_line() +
  facet_wrap(~ species_id)

# including sex
yearly_sex_counts <- surveys_complete %>% 
  count(year, species_id, sex)

yearly_sex_counts %>% 
  ggplot(aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(~ species_id) +
  theme_bw() +
  theme(panel.grid = element_blank())

ysx_plot <- yearly_sex_counts %>% 
  ggplot(aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(~ species_id)

ysx_plot + MCMsBasics::minimal_ggplot_theme()

# a little more facetting

yearly_sex_weight <- surveys_complete %>% 
  group_by(year, sex, species_id) %>% 
  summarise(avg_weight = mean(weight))

# facet_grid uses rows ~ columns for facetting. the "." indicates nothing in this dimension
yearly_sex_weight %>% 
  ggplot(aes(x = year, y = avg_weight, color = species_id)) +
  geom_line() +
  facet_grid(. ~ sex)

# adding labels and stuff
yearly_sex_counts %>% 
  ggplot(aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(~ species_id) +
  theme_bw() +
  theme(panel.grid = element_blank()) +
  labs(title = "Observed species through time", x = "Year of observation", y = "Number of species") +
  theme(text = element_text(size = 16)) +
  theme(axis.text.x = element_text(color = "grey20", size = 12, angle = 90, hjust = 0.5, vjust = 0.5))

ggsave("figures/my_test_facet_plot.tiff", height = 8, width = 8)

my_theme <- theme_bw() +
  theme(panel.grid = element_blank())