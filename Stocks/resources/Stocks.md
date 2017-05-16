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
