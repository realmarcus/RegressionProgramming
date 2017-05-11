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
