surveys <- read.csv("data/portal_data_joined.csv")
surveys
surveys_subset <- surveys[1:400, c(1,5,6,7,8)]
surveys_subset
surveys_long_feet <- surveys[surveys$hindfoot_length > 32,]
summary(surveys_long_feet$hindfoot_length)
hist(x = surveys_long_feet$hindfoot_length)
surveys_long_feet$hindfoot_length <- as.character(surveys_long_feet$hindfoot_length)
hist(x = surveys_long_feet$hindfoot_length)
