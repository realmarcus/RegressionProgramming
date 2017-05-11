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