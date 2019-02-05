#Week 4 Notes

download.file(url = "https://ndownloader.figshare.com/files/2292169", destfile = "data/portal_data_joined.csv")

surveys <- read.csv(file = "data/portal_data_joined.csv")
surveys

head(surveys)

# let's look at structure of the data

str(surveys)
dim(surveys)
nrow(surveys)
ncol(surveys)
names(surveys)

#really useful, according to Michael -- can show you NAs and missing data
summary(surveys)

#to look at a chunk of the data... subset dataframes
#to find something in a certain data frame
animal_vec <- c("mouse", "rat", "cat")
animal_vec[2]

#data frames are 2D

#get the first row and first column [row,column]
surveys[1,1]
#verify
head(surveys)
surveys[2,1]
surveys[1,6]

#what if we want everything in one row? leave one of the dimensions blank -- gives it as a vector
surveys[,1]
head(surveys[1])
#^ this gave us the first column -- it looks like a dataframe, not a vector
#so, using a single number without comma separation gives you a dataframe, not a vector

#what if I want a range of things, like the first three entries in the row
surveys[1:3,6]
#so this is the same way of doing this -- but it gives you discrete amounts from the vector, as opposed to the vector
animal_vec[c(1,3)]
#so, sqaure brackets gives us a cell or vector from a row,column crosshair, whereas parenthese gives us the specific cells from a vector

#so, pull out a whole single observation -- whole 5th row
surveys[5,]
#this gives us a data frame
surveys[5]

#can use the negative sign to exclude indices (so everything without the first column)
surveys[1:5,-1]
#but this does not work, for wanting it to not have the first ten
surveys[-10:34786,]
#so try this instead, and it likes this. So you have told it the vector to not include, and it gives you a dataframe of the first 9 rows
surveys[-c(10:34786),]

#can you be more selective in your rows?
surveys[c(10, 15, 20, 10),]
#yes! But by putting the 10th row twice it will do it, but it will rename it at 10.1


#more ways to subset
surveys["plot_id"] #single column as datafram
surveys[,"plot_id"] #single column as vector
surveys[["plot_id"]] #also single column as vector -- helpful for us to understand "lists"
#^^this of a dataframe as a train with car, each car is a column. a single square bracket, it will give you the traincar. the double backets get what is inside the car (chickens), which is the vector... so double brackets gives you a single column as a vector

surveys$year #dollar sign also gives us single column as a vector

surveys_200 <- surveys[200,]
surveys_200
nrow(surveys_200)
nrow(surveys)
surveys_last <- surveys[34786,]
34768/2
surveys_middle <- surveys[(34768/2),]
#OR
surveys_middle <- surveys[nrow(surveys)/2,]
surveys_middle

surveys[-c(7:34786),]
#OR
surveys[-c(7:nrow(surveys)),]

#factors -- factors are stored as integers with labels assigned to them
surveys$sex
#there are levels assosciated with it, and those are the values that can be contained in the factor

#creating our own factor
sex <- factor(c("male", "female", "female", "male"))
sex
#levels are ranked alphabetically
class(sex)
typeof(sex)

levels(sex) #gives us a vector
levels(surveys$genus)

concentration <- factor(c("high", "medium", "high", "low"))
levels(concentration)

#what if you want the levels to be in a different order?
concentration <- factor(concentration, levels = c("low", "medium", "high"))
concentration                        

#lets try adding to a factor
concentration <- c(concentration, "very high")
concentration

#coerce to characters if you add a value that doesn't match a current level

#let's just make them chatacters
as.character(sex)

#factors with numeric levels
year_factor <- factor(c(1990, 1923, 1965, 2018))
year_factor
as.numeric(year_factor)
#^so above, you can see how R is storing it as an integer

as.character(year_factor)
#^this gave you back the levels

#so then, you can inception it... why would you do that?
#this will actually give us a numberic vector
as.numeric(as.character(year_factor))

#why all of the factors anyways?
#in read.csv, it is default as strings as factors...
#so, you can do this...

surveys_no_factors <- read.csv(file = "data/portal_data_joined.csv", stringsAsFactors = FALSE)
str(surveys_no_factors)

#recommnded way, as opposed to the inception version
as.numeric(levels(year_factor))[year_factor]

#renaming factors
sex <- surveys$sex
levels(sex)
levels(sex)[1] <- "undetermined"
levels(sex)

#working with dates
library(lubridate)
my_date <- ymd("2015-01-01")
my_date
str(my_date)
my_date <- ymd(paste("2015", "05", "17", sep = "-"))
my_date

#pasting together dates
paste(surveys$year, surveys$month, surveys$day, sep = "-")
surveys$date <- ymd(paste(surveys$year, surveys$month, surveys$day, sep = "-"))
surveys$date

#want to do this where you can exclude some of the NAs
surveys$date[is.na(surveys$date)]
