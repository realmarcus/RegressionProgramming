Demographics Notebook
================

OBJECTIVE:
----------

In the wake of the Great Recession of 2009, there has been a good deal of focus on employment statistics, one of the most important metrics policymakers use to gauge the overall strength of the economy. In the United States, the government measures unemployment using the Current Population Survey (CPS), which collects demographic and employment information from a wide range of Americans each month. In this exercise, we will employ the topics reviewed in the lectures as well as a few new techniques using the September 2013 version of this rich, nationally representative dataset (available online).

<http://thedataweb.rm.census.gov/ftp/cps_ftp.html>

The observations in the dataset represent people surveyed in the September 2013 CPS who actually completed a survey. While the full dataset has 385 variables, in this exercise we will use a more compact version of the dataset, CPSData.csv, which has the following variables: PeopleInHousehold: The number of people in the interviewee's household. Region: The census region where the interviewee lives. State: The state where the interviewee lives. MetroAreaCode: A code that identifies the metropolitan area in which the interviewee lives (missing if the interviewee does not live in a metropolitan area). The mapping from codes to names of metropolitan areas is provided in the file MetroAreaCodes.csv. Age: The age, in years, of the interviewee. 80 represents people aged 80-84, and 85 represents people aged 85 and higher. Married: The marriage status of the interviewee. Sex: The sex of the interviewee. Education: The maximum level of education obtained by the interviewee. Race: The race of the interviewee. Hispanic: Whether the interviewee is of Hispanic ethnicity. CountryOfBirthCode: A code identifying the country of birth of the interviewee. The mapping from codes to names of countries is provided in the file CountryCodes.csv. Citizenship: The United States citizenship status of the interviewee. EmploymentStatus: The status of employment of the interviewee. Industry: The industry of employment of the interviewee (only available if they are employed).

DIRECTIVES:
-----------

This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code.

Try executing this chunk by clicking the *Run* button within the chunk or by placing your cursor inside it and pressing *Ctrl+Shift+Enter*.

Add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Ctrl+Alt+I*.

When you save the notebook, an HTML file containing the code and output will be saved alongside it (click the *Preview* button or press *Ctrl+Shift+K* to preview the HTML file).

LOADING AND SUMMARIZING THE DATASET
-----------------------------------

Load the dataset from CPSData.csv into a data frame called CPS, and view the dataset with the summary() and str() commands.

``` r
library(dplyr)
```

    ## Warning: package 'dplyr' was built under R version 3.3.2

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

What is the local language?

``` r
Sys.getlocale()
```

    ## [1] "LC_COLLATE=French_France.1252;LC_CTYPE=French_France.1252;LC_MONETARY=French_France.1252;LC_NUMERIC=C;LC_TIME=French_France.1252"

Change the local to English

``` r
Sys.setlocale("LC_ALL","English")
```

    ## [1] "LC_COLLATE=English_United States.1252;LC_CTYPE=English_United States.1252;LC_MONETARY=English_United States.1252;LC_NUMERIC=C;LC_TIME=English_United States.1252"

``` r
data <- read.csv("../data/CPSData.csv")
CPS <- tbl_df(data) 
```

How many interviewees are in the dataset?

``` r
str(CPS)
```

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    131302 obs. of  14 variables:
    ##  $ PeopleInHousehold : int  1 3 3 3 3 3 3 2 2 2 ...
    ##  $ Region            : Factor w/ 4 levels "Midwest","Northeast",..: 3 3 3 3 3 3 3 3 3 3 ...
    ##  $ State             : Factor w/ 51 levels "Alabama","Alaska",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ MetroAreaCode     : int  26620 13820 13820 13820 26620 26620 26620 33660 33660 26620 ...
    ##  $ Age               : int  85 21 37 18 52 24 26 71 43 52 ...
    ##  $ Married           : Factor w/ 5 levels "Divorced","Married",..: 5 3 3 3 5 3 3 1 1 3 ...
    ##  $ Sex               : Factor w/ 2 levels "Female","Male": 1 2 1 2 1 2 2 1 2 2 ...
    ##  $ Education         : Factor w/ 8 levels "Associate degree",..: 1 4 4 6 1 2 4 4 4 2 ...
    ##  $ Race              : Factor w/ 6 levels "American Indian",..: 6 3 3 3 6 6 6 6 6 6 ...
    ##  $ Hispanic          : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ CountryOfBirthCode: int  57 57 57 57 57 57 57 57 57 57 ...
    ##  $ Citizenship       : Factor w/ 3 levels "Citizen, Native",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ EmploymentStatus  : Factor w/ 5 levels "Disabled","Employed",..: 4 5 1 3 2 2 2 2 3 2 ...
    ##  $ Industry          : Factor w/ 14 levels "Agriculture, forestry, fishing, and hunting",..: NA 11 NA NA 11 4 14 4 NA 12 ...

Among the interviewees with a value reported for the Industry variable, what is the most common industry of employment? Please enter the name exactly how you see it.

``` r
sort(summary(CPS$Industry))
```

    ##                                Armed forces 
    ##                                          29 
    ##                                      Mining 
    ##                                         550 
    ## Agriculture, forestry, fishing, and hunting 
    ##                                        1307 
    ##                                 Information 
    ##                                        1328 
    ##                       Public administration 
    ##                                        3186 
    ##                              Other services 
    ##                                        3224 
    ##                Transportation and utilities 
    ##                                        3260 
    ##                                   Financial 
    ##                                        4347 
    ##                                Construction 
    ##                                        4387 
    ##                     Leisure and hospitality 
    ##                                        6364 
    ##                               Manufacturing 
    ##                                        6791 
    ##          Professional and business services 
    ##                                        7519 
    ##                                       Trade 
    ##                                        8933 
    ##             Educational and health services 
    ##                                       15017 
    ##                                        NA's 
    ##                                       65060

Recall from the homework assignment "The Analytical Detective" that you can call the sort() function on the output of the table() function to obtain a sorted breakdown of a variable. For instance, sort(table(CPS$Region)) sorts the regions by the number of interviewees from that region.

Which state has the fewest interviewees? Which state has the largest number of interviewees?

Method 1:

``` r
sort(table(CPS$State))
```

    ## 
    ##           New Mexico              Montana          Mississippi 
    ##                 1102                 1214                 1230 
    ##              Alabama        West Virginia             Arkansas 
    ##                 1376                 1409                 1421 
    ##            Louisiana                Idaho             Oklahoma 
    ##                 1450                 1518                 1523 
    ##              Arizona               Alaska              Wyoming 
    ##                 1528                 1590                 1624 
    ##         North Dakota       South Carolina            Tennessee 
    ##                 1645                 1658                 1784 
    ## District of Columbia             Kentucky                 Utah 
    ##                 1791                 1841                 1842 
    ##               Nevada              Vermont               Kansas 
    ##                 1856                 1890                 1935 
    ##               Oregon             Nebraska        Massachusetts 
    ##                 1943                 1949                 1987 
    ##         South Dakota              Indiana               Hawaii 
    ##                 2000                 2004                 2099 
    ##             Missouri         Rhode Island             Delaware 
    ##                 2145                 2209                 2214 
    ##                Maine           Washington                 Iowa 
    ##                 2263                 2366                 2528 
    ##           New Jersey       North Carolina        New Hampshire 
    ##                 2567                 2619                 2662 
    ##            Wisconsin              Georgia          Connecticut 
    ##                 2686                 2807                 2836 
    ##             Colorado             Virginia             Michigan 
    ##                 2925                 2953                 3063 
    ##            Minnesota             Maryland                 Ohio 
    ##                 3139                 3200                 3678 
    ##             Illinois         Pennsylvania              Florida 
    ##                 3912                 3930                 5149 
    ##             New York                Texas           California 
    ##                 5595                 7077                11570

What proportion of interviewees are citizens of the United States? Method1

``` r
table(CPS$Citizenship)
```

    ## 
    ##      Citizen, Native Citizen, Naturalized          Non-Citizen 
    ##               116639                 7073                 7590

``` r
(116639+7073)/(116639+7073+7590)
```

    ## [1] 0.9421943

The CPS differentiates between race (with possible values American Indian, Asian, Black, Pacific Islander, White, or Multiracial) and ethnicity. A number of interviewees are of Hispanic ethnicity, as captured by the Hispanic variable.

For which races are there at least 250 interviewees in the CPS dataset of Hispanic ethnicity? (Select all that apply.)

``` r
table(CPS$Race,CPS$Hispanic)
```

    ##                   
    ##                        0     1
    ##   American Indian   1129   304
    ##   Asian             6407   113
    ##   Black            13292   621
    ##   Multiracial       2449   448
    ##   Pacific Islander   541    77
    ##   White            89190 16731

EVALUATING MISSING VALUES
=========================

Which variables have at least one interviewee with a missing (NA) value? (Select all that apply.)

``` r
summary(CPS)
```

    ##  PeopleInHousehold       Region               State       MetroAreaCode  
    ##  Min.   : 1.000    Midwest  :30684   California  :11570   Min.   :10420  
    ##  1st Qu.: 2.000    Northeast:25939   Texas       : 7077   1st Qu.:21780  
    ##  Median : 3.000    South    :41502   New York    : 5595   Median :34740  
    ##  Mean   : 3.284    West     :33177   Florida     : 5149   Mean   :35075  
    ##  3rd Qu.: 4.000                      Pennsylvania: 3930   3rd Qu.:41860  
    ##  Max.   :15.000                      Illinois    : 3912   Max.   :79600  
    ##                                      (Other)     :94069   NA's   :34238  
    ##       Age                 Married          Sex       
    ##  Min.   : 0.00   Divorced     :11151   Female:67481  
    ##  1st Qu.:19.00   Married      :55509   Male  :63821  
    ##  Median :39.00   Never Married:30772                 
    ##  Mean   :38.83   Separated    : 2027                 
    ##  3rd Qu.:57.00   Widowed      : 6505                 
    ##  Max.   :85.00   NA's         :25338                 
    ##                                                      
    ##                    Education                   Race       
    ##  High school            :30906   American Indian :  1433  
    ##  Bachelor's degree      :19443   Asian           :  6520  
    ##  Some college, no degree:18863   Black           : 13913  
    ##  No high school diploma :16095   Multiracial     :  2897  
    ##  Associate degree       : 9913   Pacific Islander:   618  
    ##  (Other)                :10744   White           :105921  
    ##  NA's                   :25338                            
    ##     Hispanic      CountryOfBirthCode               Citizenship    
    ##  Min.   :0.0000   Min.   : 57.00     Citizen, Native     :116639  
    ##  1st Qu.:0.0000   1st Qu.: 57.00     Citizen, Naturalized:  7073  
    ##  Median :0.0000   Median : 57.00     Non-Citizen         :  7590  
    ##  Mean   :0.1393   Mean   : 82.68                                  
    ##  3rd Qu.:0.0000   3rd Qu.: 57.00                                  
    ##  Max.   :1.0000   Max.   :555.00                                  
    ##                                                                   
    ##            EmploymentStatus                               Industry    
    ##  Disabled          : 5712   Educational and health services   :15017  
    ##  Employed          :61733   Trade                             : 8933  
    ##  Not in Labor Force:15246   Professional and business services: 7519  
    ##  Retired           :18619   Manufacturing                     : 6791  
    ##  Unemployed        : 4203   Leisure and hospitality           : 6364  
    ##  NA's              :25789   (Other)                           :21618  
    ##                             NA's                              :65060

Often when evaluating a new dataset, we try to identify if there is a pattern in the missing values in the dataset. We will try to determine if there is a pattern in the missing values of the Married variable. The function is.na(CPS*M**a**r**r**i**e**d*)*r**e**t**u**r**n**s**a**v**e**c**t**o**r**o**f**T**R**U**E*/*F**A**L**S**E**v**a**l**u**e**s**f**o**r**w**h**e**t**h**e**r**t**h**e**M**a**r**r**i**e**d**v**a**r**i**a**b**l**e**i**s**m**i**s**s**i**n**g*.*W**e**c**a**n**s**e**e**t**h**e**b**r**e**a**k**d**o**w**n**o**f**w**h**e**t**h**e**r**M**a**r**r**i**e**d**i**s**m**i**s**s**i**n**g**b**a**s**e**d**o**n**t**h**e**r**e**p**o**r**t**e**d**v**a**l**u**e**o**f**t**h**e**R**e**g**i**o**n**v**a**r**i**a**b**l**e**w**i**t**h**t**h**e**f**u**n**c**t**i**o**n**t**a**b**l**e*(*C**P**S*Region, is.na(CPS$Married)). Which is the most accurate:

``` r
 table(CPS$Region, is.na(CPS$Married))
```

    ##            
    ##             FALSE  TRUE
    ##   Midwest   24609  6075
    ##   Northeast 21432  4507
    ##   South     33535  7967
    ##   West      26388  6789

The Married variable being missing is related to the Age value for the interviewee

``` r
table(CPS$Age, is.na(CPS$Married))
```

    ##     
    ##      FALSE TRUE
    ##   0      0 1283
    ##   1      0 1559
    ##   2      0 1574
    ##   3      0 1693
    ##   4      0 1695
    ##   5      0 1795
    ##   6      0 1721
    ##   7      0 1681
    ##   8      0 1729
    ##   9      0 1748
    ##   10     0 1750
    ##   11     0 1721
    ##   12     0 1797
    ##   13     0 1802
    ##   14     0 1790
    ##   15  1795    0
    ##   16  1751    0
    ##   17  1764    0
    ##   18  1596    0
    ##   19  1517    0
    ##   20  1398    0
    ##   21  1525    0
    ##   22  1536    0
    ##   23  1638    0
    ##   24  1627    0
    ##   25  1604    0
    ##   26  1643    0
    ##   27  1657    0
    ##   28  1736    0
    ##   29  1645    0
    ##   30  1854    0
    ##   31  1762    0
    ##   32  1790    0
    ##   33  1804    0
    ##   34  1653    0
    ##   35  1716    0
    ##   36  1663    0
    ##   37  1531    0
    ##   38  1530    0
    ##   39  1542    0
    ##   40  1571    0
    ##   41  1673    0
    ##   42  1711    0
    ##   43  1819    0
    ##   44  1764    0
    ##   45  1749    0
    ##   46  1665    0
    ##   47  1647    0
    ##   48  1791    0
    ##   49  1989    0
    ##   50  1966    0
    ##   51  1931    0
    ##   52  1935    0
    ##   53  1994    0
    ##   54  1912    0
    ##   55  1895    0
    ##   56  1935    0
    ##   57  1827    0
    ##   58  1874    0
    ##   59  1758    0
    ##   60  1746    0
    ##   61  1735    0
    ##   62  1595    0
    ##   63  1596    0
    ##   64  1519    0
    ##   65  1569    0
    ##   66  1577    0
    ##   67  1227    0
    ##   68  1130    0
    ##   69  1062    0
    ##   70  1195    0
    ##   71  1031    0
    ##   72   941    0
    ##   73   896    0
    ##   74   842    0
    ##   75   763    0
    ##   76   729    0
    ##   77   698    0
    ##   78   659    0
    ##   79   661    0
    ##   80  2664    0
    ##   85  2446    0

For each possible value of Region, Sex, and Citizenship, there are both interviewees with missing and non-missing Married values. However, Married is missing for all interviewees Aged 0-14 and is present for all interviewees aged 15 and older. This is because the CPS does not ask about marriage status for interviewees 14 and younger.

As mentioned in the variable descriptions, MetroAreaCode is missing if an interviewee does not live in a metropolitan area. Using the same technique as in the previous question, answer the following questions about people who live in nonmetropolitan areas.

How many states had all interviewees living in a non-metropolitan area (aka they have a missing MetroAreaCode value)? For this question, treat the District of Columbia as a state (even though it is not technically a state). How many states had all interviewees living in a metropolitan area? Again, treat the District of Columbia as a state.

``` r
table(CPS$State,is.na(CPS$MetroAreaCode))
```

    ##                       
    ##                        FALSE  TRUE
    ##   Alabama               1020   356
    ##   Alaska                   0  1590
    ##   Arizona               1327   201
    ##   Arkansas               724   697
    ##   California           11333   237
    ##   Colorado              2545   380
    ##   Connecticut           2593   243
    ##   Delaware              1696   518
    ##   District of Columbia  1791     0
    ##   Florida               4947   202
    ##   Georgia               2250   557
    ##   Hawaii                1576   523
    ##   Idaho                  761   757
    ##   Illinois              3473   439
    ##   Indiana               1420   584
    ##   Iowa                  1297  1231
    ##   Kansas                1234   701
    ##   Kentucky               908   933
    ##   Louisiana             1216   234
    ##   Maine                  909  1354
    ##   Maryland              2978   222
    ##   Massachusetts         1858   129
    ##   Michigan              2517   546
    ##   Minnesota             2150   989
    ##   Mississippi            376   854
    ##   Missouri              1440   705
    ##   Montana                199  1015
    ##   Nebraska               816  1133
    ##   Nevada                1609   247
    ##   New Hampshire         1148  1514
    ##   New Jersey            2567     0
    ##   New Mexico             832   270
    ##   New York              5144   451
    ##   North Carolina        1642   977
    ##   North Dakota           432  1213
    ##   Ohio                  2754   924
    ##   Oklahoma              1024   499
    ##   Oregon                1519   424
    ##   Pennsylvania          3245   685
    ##   Rhode Island          2209     0
    ##   South Carolina        1139   519
    ##   South Dakota           595  1405
    ##   Tennessee             1149   635
    ##   Texas                 6060  1017
    ##   Utah                  1455   387
    ##   Vermont                657  1233
    ##   Virginia              2367   586
    ##   Washington            1937   429
    ##   West Virginia          344  1065
    ##   Wisconsin             1882   804
    ##   Wyoming                  0  1624

Which region of the United States has the largest proportion of interviewees living in a non-metropolitan area?

``` r
table(CPS$Region,is.na(CPS$MetroAreaCode))
```

    ##            
    ##             FALSE  TRUE
    ##   Midwest   20010 10674
    ##   Northeast 20330  5609
    ##   South     31631  9871
    ##   West      25093  8084
