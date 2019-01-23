#to get your data...
read.csv("data/tidy.csv")

#vector time -- to create a vector, us c function, which connects a series of values
weight_g <- c(50, 60, 31, 89)
weight_g

#now characters
animals <- c("mouse", "rat", "dog", "cat")
animals

#vector exploration tools
length(weight_g)
length(animals)
#everything in one vector needs to be same data type

class(weight_g)
class(animals)

#str is a go-to for looking at an object
str(x)
str(weight_g)

#modifying in place -- basically adding to the vector
weight_g <- c(weight_g, 105)
weight_g

weight_g <- c(25, weight_g)
weight_g

#4 types of atomic vectors -- numeric or double, character, logical, integer (have to be whole round numbers, whereas 20.2 is a double), complex
# typeof is like class, but deeper

typeof(weight_g)

#columns and vectors should be thought of in the same way

#challenge
num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")

#heirarchy of power in vector strings: character, numeric/double, integer, logical --> this is called coercion
combined_logical <- c(num_logical, char_logical)
class(combined_logical)

#subsetting vectors
animals[1]
animals[2:3]
animals[c(3, 1, 3)]

#conditional subsetting
weight_g
weight_g[c(T, F, T, F, T, F)]
#using T and F to skip certain variables

#conditional subsetting to get answers about whether or not they are in a range
weight_g > 50
weight_g[weight_g > 50]

# I don't quite understand this
#multiple conditions -- give me the vectors that meet all of these conditions
weight_g[weight_g < 30 | weight_g > 50]

weight_g[weight_g >=30 & weight_g == 90]

#searching for characters
animals[animals == "cat" | animals == "rat"]
#if we have a bunch and this is annoying, we can use the in function
animals %in% c("rat", "antelope", "jackalope", "hippogriff")
#but this output is confusing, because rat is the second animal so rat is true... so you need to put it in the context of your data by subsetting
animals[animals %in% c("rat", "antelope", "jackalope", "hippogriff")]

#challenge -- it is alphabetic

"four" > "five"
"five" > "four"
"six" > "five"
"eight" > "five"
"z" > "y"

#missing data
heights <- c(2, 4, 4, NA, 6)
str(heights)
mean(weight_g)
mean(heights)

mean(x = heights, na.rm = TRUE)

is.na(heights)
na.omit(heights)
#this did not work, but see other R notes to see what I can find out.
!is.na(heights)
