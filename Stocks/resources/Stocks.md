R Notebook
================

1.  Objective

A stock market is where buyers and sellers trade shares of a company, and is one of the most popular ways for individuals and companies to invest money. The size of the world stock market  is now estimated to be in the trillions. The largest stock market in the world is the New York Stock Exchange (NYSE), located in New York City. About 2,800 companies are listed on the NSYE. In this problem, we'll look at the monthly stock prices of five of these companies: IBM, General Electric (GE), Procter and Gamble, Coca Cola, and Boeing. The data used in this problem comes from Infochimps.

TODO
----

Download and read the following files into R, using the read.csv function: IBMStock.csv, GEStock.csv, ProcterGambleStock.csv, CocaColaStock.csv, and BoeingStock.csv. (Do not open these files in any spreadsheet software before completing this problem because it might change the format of the Date field.) Call the data frames "IBM", "GE", "ProcterGamble", "CocaCola", and "Boeing", respectively. Each data frame has two variables, described as follows: Date: the date of the stock price, always given as the first of the month. StockPrice: the average stock price of the company in the given month. In this problem, we'll take a look at how the stock dynamics of these companies have changed over time

``` r
Sys.setlocale("LC_ALL","English")
```

    ## [1] "LC_COLLATE=English_United States.1252;LC_CTYPE=English_United States.1252;LC_MONETARY=English_United States.1252;LC_NUMERIC=C;LC_TIME=English_United States.1252"

``` r
library(dplyr)
```

    ## Warning: package 'dplyr' was built under R version 3.3.3

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(ggplot2)
```

    ## Warning: package 'ggplot2' was built under R version 3.3.2

``` r
data1 = read.csv("../data/IBMStock.csv")
IBM = tbl_df(data1)
data2 = read.csv("../data/GEStock.csv")
GE = tbl_df(data2)
data3 = read.csv("../data/ProcterGambleStock.csv")
ProcterGamble = tbl_df(data3)
data4 = read.csv("../data/CocaColaStock.csv")
CocaCola = tbl_df(data4)
data5 = read.csv("../data/BoeingStock.csv")
Boeing = tbl_df(data5)
```

1.1 - SUMMARY STATISTICS

Before working with these data sets, we need to convert the dates into a format that R can understand. Take a look at the structure of one of the datasets using the str function. Right now, the date variable is stored as a factor. We can convert this to a "Date" object in R by using the following five commands (one for each data set):

``` r
IBM$Date = as.Date(IBM$Date, "%m/%d/%y")
GE$Date = as.Date(GE$Date, "%m/%d/%y")
CocaCola$Date = as.Date(CocaCola$Date, "%m/%d/%y")
ProcterGamble$Date = as.Date(ProcterGamble$Date, "%m/%d/%y")
Boeing$Date = as.Date(Boeing$Date, "%m/%d/%y")
```

The first argument to the as.Date function is the variable we want to convert, and the second argument is the format of the Date variable. We can just overwrite the original Date variable values with the output of this function. Now, answer the following questions using the str and summary functions.

Our five datasets all have the same number of observations. How many observations are there in each data set?

``` r
str(IBM)
```

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    480 obs. of  2 variables:
    ##  $ Date      : Date, format: "1970-01-01" "1970-02-01" ...
    ##  $ StockPrice: num  360 347 327 320 270 ...

1.2 - SUMMARY STATISTICS

What is the earliest year in our datasets?

``` r
summary(IBM)
```

    ##       Date              StockPrice    
    ##  Min.   :1970-01-01   Min.   : 43.40  
    ##  1st Qu.:1979-12-24   1st Qu.: 88.34  
    ##  Median :1989-12-16   Median :112.11  
    ##  Mean   :1989-12-15   Mean   :144.38  
    ##  3rd Qu.:1999-12-08   3rd Qu.:165.41  
    ##  Max.   :2009-12-01   Max.   :438.90

1.3 - SUMMARY STATISTICS

What is the latest year in our datasets?

1.4 - SUMMARY STATISTICS

What is the mean stock price of IBM over this time period?

1.5 - SUMMARY STATISTICS

What is the minimum stock price of General Electric (GE) over this time period?

``` r
summary(GE)
```

    ##       Date              StockPrice     
    ##  Min.   :1970-01-01   Min.   :  9.294  
    ##  1st Qu.:1979-12-24   1st Qu.: 44.214  
    ##  Median :1989-12-16   Median : 55.812  
    ##  Mean   :1989-12-15   Mean   : 59.303  
    ##  3rd Qu.:1999-12-08   3rd Qu.: 72.226  
    ##  Max.   :2009-12-01   Max.   :156.844

1.6 - SUMMARY STATISTICS

What is the maximum stock price of Coca-Cola over this time period?

``` r
summary(CocaCola)
```

    ##       Date              StockPrice    
    ##  Min.   :1970-01-01   Min.   : 30.06  
    ##  1st Qu.:1979-12-24   1st Qu.: 42.76  
    ##  Median :1989-12-16   Median : 51.44  
    ##  Mean   :1989-12-15   Mean   : 60.03  
    ##  3rd Qu.:1999-12-08   3rd Qu.: 69.62  
    ##  Max.   :2009-12-01   Max.   :146.58

1.7 - SUMMARY STATISTICS

What is the median stock price of Boeing over this time period?

``` r
summary(Boeing)
```

    ##       Date              StockPrice    
    ##  Min.   :1970-01-01   Min.   : 12.74  
    ##  1st Qu.:1979-12-24   1st Qu.: 34.64  
    ##  Median :1989-12-16   Median : 44.88  
    ##  Mean   :1989-12-15   Mean   : 46.59  
    ##  3rd Qu.:1999-12-08   3rd Qu.: 57.21  
    ##  Max.   :2009-12-01   Max.   :107.28

1.8 - SUMMARY STATISTICS

What is the standard deviation of the stock price of Procter & Gamble over this time period?

``` r
sd(ProcterGamble$StockPrice)
```

    ## [1] 18.19414

2.1 - VISUALIZING STOCK DYNAMICS
