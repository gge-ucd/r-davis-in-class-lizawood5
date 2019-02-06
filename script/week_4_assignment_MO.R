surveys <- read.csv("data/portal_data_joined.csv")

surveys_subset <- surveys[1:400, c(1,5:8)]

#Challenge


surveys_long_feet <- surveys[surveys$hindfoot_length > 32, ]

hist(surveys_long_feet$hindfoot_length)


#hindfoot lengths as character

surveys_long_feet$hindfoot_length <-  as.character(surveys_long_feet$hindfoot_length)

