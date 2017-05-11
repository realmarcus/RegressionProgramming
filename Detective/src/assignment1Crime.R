#libraries
library("dplyr")
library("ggplot2")

# import data
data <- read.csv("../data/mvtWeek1.csv")

# create data frame
df <- tbl_df(data)

# How many rows of data (observations) are in this dataset?
str(df)
# 191641 obs. of  11 variables

# Using the "max" function, what is the maximum value of the variable "ID"?
max(df$ID)

# What is the minimum value of the variable "Beat"?
min(df$Beat)

# How many observations have a LocationDescription value of ALLEY?
summary(df)

# Now, let's convert these characters into a Date object in R. In your R console, type
DateConvert = as.Date(strptime(df$Date, "%m/%d/%y %H:%M"))

# What is the month and year of the median date in our dataset? 
# Enter your answer as "Month Year", without the quotes.
# (Ex: if the answer was 2008-03-28, 
# you would give the answer "March 2008", without the quotes.)
summary(DateConvert)
# -> May 2006

# Now, let's extract the month and the day of the week, 
# and add these variables to our data frame mvt. 
# We can do this with two simple functions. Type the following commands in R:
df$Month = months(DateConvert)
df$Weekday = weekdays(DateConvert)
# This creates two new variables in our data frame, 
# Month and Weekday, and sets them equal to the month and weekday values 
# that we can extract from the Date object. 
# Lastly, replace the old Date variable with DateConvert by typing:
df$Date = DateConvert

# Using the table command, answer the following questions.
# In which month did the fewest motor vehicle thefts occur?
sort(table(df$Month))
# -> february

# On which weekday did the most motor vehicle thefts occur?
sort(table(df$Weekday))
# -> friday

# Each observation in the dataset represents a motor vehicle theft, 
# and the Arrest variable indicates whether an arrest was later made for this theft. 
# Which month has the largest number of motor vehicle thefts for which an arrest was made?
table(df$Arrest,df$Month)
