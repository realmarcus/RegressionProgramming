#libraries
library("dplyr")
library("ggplot2")

# import data
data <- read.csv("./Detective/data/mvtWeek1.csv")

# create data frame
df <- tbl_df(data)

# How many rows of data (observations) are in this dataset?
N = nrow(df)
L = ncol(df)
str(df)
# 191641 obs. of  11 variables

# Using the "max" function, what is the maximum value of the variable "ID"?
max(df$ID)

# What is the minimum value of the variable "Beat"?
min(df$Beat)

# How many observations have a LocationDescription value of ALLEY?
summary(df$LocationDescription)

# In what format are the entries in the variable Date?
# first line: 12/31/12 23:15
# -> Month/Day/Year Hour:Minute
head(df)

# let's convert these characters into a Date object in R
DateConvert =  as.Date(strptime(df$Date, "%m/%d/%y %H:%M"))

# What is the month and year of the median date in our dataset?
summary(DateConvert)
# -> 2006-05-21 -> May 2006

#  let's extract the month and the day of the week, and add these variables to our data frame 
df$Month = months(DateConvert)
df$Weekday = weekdays(DateConvert)

# In which month did the fewest motor vehicle thefts occur?
