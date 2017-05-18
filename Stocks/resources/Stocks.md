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

Let's plot the stock prices to see if we can visualize trends in stock prices during this time period. Using the plot function, plot the Date on the x-axis and the StockPrice on the y-axis, for Coca-Cola. This plots our observations as points, but we would really like to see a line instead, since this is a continuous time period. To do this, add the argument type="l" to your plot command, and re-generate the plot (the character is quotes is the letter l, for line). You should now see a line plot of the Coca-Cola stock price.

``` r
plot(CocaCola$Date, CocaCola$StockPrice, type="l")
```

![](Stocks_files/figure-markdown_github/plot1%20Stock%20price%20vs%20Date-1.png)

Around what year did Coca-Cola has its highest stock price in this time period?

**1973**

Around what year did Coca-Cola has its lowest stock price in this time period?

**1980**

2.2 - VISUALIZING STOCK DYNAMICS

Now, let's add the line for Procter & Gamble too. You can add a line to a plot in R by using the lines function instead of the plot function. Keeping the plot for Coca-Cola open, type in your R console:

Unfortunately, it's hard to tell which line is which. Let's fix this by giving each line a color. First, re-run the plot command for Coca-Cola, but add the argument col="red". You should see the plot for Coca-Cola show up again, but this time in red. Now, let's add the Procter & Gamble line (using the lines function like we did before), adding the argument col="blue". You should now see in your plot the Coca-Cola stock price in red, and the Procter & Gamble stock price in blue.

``` r
plot(CocaCola$Date, CocaCola$StockPrice, type="l",col="red")
lines(ProcterGamble$Date, ProcterGamble$StockPrice,col="blue")
```

![](Stocks_files/figure-markdown_github/plot2%20add%20a%20line%20and%20color-1.png)

As an alternative choice to changing the colors, you could instead change the line type of the Procter & Gamble line by adding the argument lty=2. This will make the Procter & Gamble line dashed. Using this plot, answer the following questions.

``` r
plot(CocaCola$Date, CocaCola$StockPrice, type="l",col="red",lty=1)
lines(ProcterGamble$Date, ProcterGamble$StockPrice,col="blue",lty=2)
abline(v=as.Date(c("2000-03-01")), lwd=2)
```

![](Stocks_files/figure-markdown_github/plot3%20add%20line%20type-1.png)

In March of 2000, the technology bubble burst, and a stock market crash occurred. According to this plot, which company's stock dropped more?

**Procter and Gamble**

in your R console, with the plot still open. This generates a vertical line at the date March 1, 2000. The argument lwd=2 makes the line a little thicker. You can change the date in this command to generate the vertical line in different locations.

2.3 - VISUALIZING STOCK DYNAMICS

Answer these questions using the plot you generated in the previous problem. Around 1983, the stock for one of these companies (Coca-Cola or Procter and Gamble) was going up, while the other was going down. Which one was going up?

``` r
plot(CocaCola$Date, CocaCola$StockPrice, type="l",col="red",lty=1)
lines(ProcterGamble$Date, ProcterGamble$StockPrice,col="blue",lty=2)
abline(v=as.Date(c("1983-01-01")), lwd=2)
```

![](Stocks_files/figure-markdown_github/plot4%20around%201983-1.png)

**Coca-Cola**

In the time period shown in the plot, which stock generally has lower values?

**Coca-Cola**

3.1 - VISUALIZING STOCK DYNAMICS 1995-2005 Let's take a look at how the stock prices changed from 1995-2005 for all five companies. In your R console, start by typing the following plot command:

``` r
plot(CocaCola$Date[301:432], CocaCola$StockPrice[301:432], type="l", col="red", ylim=c(0,210))
```

![](Stocks_files/figure-markdown_github/plot5%20period%201995-2005-1.png)

This will plot the CocaCola stock prices from 1995 through 2005, which are the observations numbered from 301 to 432. The additional argument, ylim=c(0,210), makes the y-axis range from 0 to 210. This will allow us to see all of the stock values when we add in the other companies.

Now, use the lines function to add in the other four companies, remembering to only plot the observations from 1995 to 2005, or \[301:432\]. You don't need the "type" or "ylim" arguments for the lines function, but remember to make each company a different color so that you can tell them apart. Some color options are "red", "blue", "green", "purple", "orange", and "black". To see all of the color options in R, type colors() in your R console.

``` r
plot(CocaCola$Date[301:432], CocaCola$StockPrice[301:432], type="l", col="red", ylim=c(0,210))
lines(ProcterGamble$Date, ProcterGamble$StockPrice,col="blue",lty=2)
lines(IBM$Date, IBM$StockPrice,col="green",lty=3)
lines(Boeing$Date, Boeing$StockPrice,col="purple",lty=4)
lines(GE$Date, GE$StockPrice,col="orange",lty=5)
abline(v=as.Date(c("2000-03-01")), lwd=2)
```

![](Stocks_files/figure-markdown_github/plot6%20All%20companies-1.png) Which stock fell the most right after the technology bubble burst in March 2000?

**GE**

Which stock reaches the highest value in the time period 1995-2005?

**IBM**

3.3 - VISUALIZING STOCK DYNAMICS 1995-2005 In October of 1997, there was a global stock market crash that was caused by an economic crisis in Asia. Comparing September 1997 to November 1997, which companies saw a decreasing trend in their stock price?

``` r
plot(CocaCola$Date[301:432], CocaCola$StockPrice[301:432], type="l", col="red", ylim=c(0,210))
lines(ProcterGamble$Date, ProcterGamble$StockPrice,col="blue",lty=2)
lines(IBM$Date, IBM$StockPrice,col="green",lty=3)
lines(Boeing$Date, Boeing$StockPrice,col="purple",lty=4)
lines(GE$Date, GE$StockPrice,col="orange",lty=5)
abline(v=as.Date(c("1997-09-01")), lwd=2)
abline(v=as.Date(c("1997-11-01")), lwd=2)
```

![](Stocks_files/figure-markdown_github/plot7-1.png) 3.4 - VISUALIZING STOCK DYNAMICS 1995-2005 (1/1 point) In the last two years of this time period (2004 and 2005) which stock seems to be performing the best, in terms of increasing stock price?

**Boeing**

``` r
plot(CocaCola$Date[301:432], CocaCola$StockPrice[301:432], type="l", col="red", ylim=c(0,210))
lines(ProcterGamble$Date, ProcterGamble$StockPrice,col="blue",lty=2)
lines(IBM$Date, IBM$StockPrice,col="green",lty=3)
lines(Boeing$Date, Boeing$StockPrice,col="purple",lty=4)
lines(GE$Date, GE$StockPrice,col="orange",lty=5)
abline(v=as.Date(c("2004-01-01")), lwd=2)
abline(v=as.Date(c("2005-12-31")), lwd=2)
```

![](Stocks_files/figure-markdown_github/plot8-1.png)

4.1 - MONTHLY TRENDS (1/1 point) Lastly, let's see if stocks tend to be higher or lower during certain months. Use the tapply command to calculate the mean stock price of IBM, sorted by months. To sort by months, use: months(IBM$Date) as the second argument of the tapply function.

``` r
 tapply(IBM$StockPrice, months(IBM$Date), mean)
```

    ##     April    August  December  February   January      July      June 
    ##  152.1168  140.1455  140.7593  152.6940  150.2384  139.0670  139.0907 
    ##     March       May  November   October September 
    ##  152.4327  151.5022  138.0187  137.3466  139.0885
