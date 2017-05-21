R Notebook
================

CLIMATE CHANGE
==============

OBJECTIVE
---------

There have been many studies documenting that the average global temperature has been increasing over the last century. The consequences of a continued rise in global temperature will be dire. Rising sea levels and an increased frequency of extreme weather events will affect billions of people.

In this problem, we will attempt to study the relationship between average global temperature and several other factors.

DIRECTIVE
---------

This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code.

Try executing this chunk by clicking the *Run* button within the chunk or by placing your cursor inside it and pressing *Ctrl+Shift+Enter*.

Add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Ctrl+Alt+I*.

When you save the notebook, an HTML file containing the code and output will be saved alongside it (click the *Preview* button or press *Ctrl+Shift+K* to preview the HTML file).

DATA DESCRIPTION
----------------

The file climate\_change.csv contains climate data from May 1983 to December 2008. The available variables include:

### Year:

the observation year. Month: the observation month.

### Temp:

the difference in degrees Celsius between the average global temperature in that period and a reference value. This data comes from the Climatic Research Unit at the University of East Anglia.

### CO2, N2O, CH4, CFC.11, CFC.12:

atmospheric concentrations of carbon dioxide (CO ), nitrous oxide (N O), methane  (CH ), trichlorofluoromethane (CCl F; commonly referred to as CFC-11) and dichlorodifluoromethane (CCl F ; commonly referred to as CFC-12), respectively. This data comes from the ESRL/NOAA Global Monitoring Division.

### CO2, N2O and CH4

are expressed in ppmv (parts per million by volume  -- i.e., 397 ppmv of CO2 means that CO2 constitutes 397 millionths of the total volume of the atmosphere) CFC.11 and CFC.12 are expressed in ppbv (parts per billion by volume). 

### Aerosols:

the mean stratospheric aerosol optical depth at 550 nm. This variable is linked to volcanoes, as volcanic eruptions result in new particles being added to the atmosphere, which affect how much of the sun's energy is reflected back into space. This data is from the Godard Institute for Space Studies at NASA.

### TSI:

the total solar irradiance (TSI) in W/m (the rate at which the sun's energy is deposited per unit area). Due to sunspots and other solar phenomena, the amount of energy that is given off by the sun varies substantially with time. This data is from the SOLARIS-HEPPA project website.

### MEI:

multivariate El Nino Southern Oscillation index (MEI), a measure of the strength of the El Nino/La Nina-Southern Oscillation (a weather effect in the Pacific Ocean that affects global temperatures). This data comes from the ESRL/NOAA Physical Sciences Division.

1.1 - CREATING OUR FIRST MODEL
------------------------------

We are interested in how changes in these variables affect future temperatures, as well as how well these variables explain temperature changes so far. To do this, first read the dataset climate\_change.csv into R.

Then, split the data into a training set, consisting of all the observations up to and including 2006, and a testing set consisting of the remaining years (hint: use subset). A training set refers to the data that will be used to build the model (this is the data we give to the lm() function), and a testing set refers to the data we will use to test our predictive ability.

Next, build a linear regression model to predict the dependent variable Temp, using MEI, CO2, CH4, N2O, CFC.11, CFC.12, TSI, and Aerosols as independent variables (Year and Month should NOT be used in the model). Use the training set to build the model.

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
data <- read.csv("../data/climate_change.csv")
df <- tbl_df(data)
tr <- subset(df,subset = Year <=2006)
test <- subset(df,subset = Year > 2006)
```

``` r
model = lm(data=tr,formula = Temp ~ MEI+CO2+CH4+N2O+CFC.11+CFC.12+TSI+Aerosols)
```

Enter the model R (the "Multiple R-squared" value):

0.7509
------

``` r
summary(model)
```

    ## 
    ## Call:
    ## lm(formula = Temp ~ MEI + CO2 + CH4 + N2O + CFC.11 + CFC.12 + 
    ##     TSI + Aerosols, data = tr)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.25888 -0.05913 -0.00082  0.05649  0.32433 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) -1.246e+02  1.989e+01  -6.265 1.43e-09 ***
    ## MEI          6.421e-02  6.470e-03   9.923  < 2e-16 ***
    ## CO2          6.457e-03  2.285e-03   2.826  0.00505 ** 
    ## CH4          1.240e-04  5.158e-04   0.240  0.81015    
    ## N2O         -1.653e-02  8.565e-03  -1.930  0.05467 .  
    ## CFC.11      -6.631e-03  1.626e-03  -4.078 5.96e-05 ***
    ## CFC.12       3.808e-03  1.014e-03   3.757  0.00021 ***
    ## TSI          9.314e-02  1.475e-02   6.313 1.10e-09 ***
    ## Aerosols    -1.538e+00  2.133e-01  -7.210 5.41e-12 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.09171 on 275 degrees of freedom
    ## Multiple R-squared:  0.7509, Adjusted R-squared:  0.7436 
    ## F-statistic: 103.6 on 8 and 275 DF,  p-value: < 2.2e-16

Which variables are significant in the model? We will consider a variable signficant only if the p-value is below 0.05. (Select all that apply.)

MEI,CO2,CH4,TSI,CF.11,CF.12,Aerosols
------------------------------------

2.1 - UNDERSTANDING THE MODEL
-----------------------------

Current scientific opinion is that nitrous oxide and CFC-11 are greenhouse gases: gases that are able to trap heat from the sun and contribute to the heating of the Earth. However, the regression coefficients of both the N2O and CFC-11 variables are negative, indicating that increasing atmospheric concentrations of either of these two compounds is associated with lower global temperatures.

Which of the following is the simplest correct explanation for this contradiction?

Answer: All of the gas concentration variables reflect human development - N2O and CFC.11 are correlated with other variables in the data set

EXPLANATION: The linear correlation of N2O and CFC.11 with other variables in the data set is quite large. The first explanation does not seem correct, as the warming effect of nitrous oxide and CFC-11 are well documented, and our regression analysis is not enough to disprove it. The second explanation is unlikely, as we have estimated eight coefficients and the intercept from 284 observations.

Compute the correlations between all the variables in the training set.

Which of the following independent variables is N2O highly correlated with (absolute correlation greater than 0.7)? Select all that apply.

Which of the following independent variables is CFC.11 highly correlated with? Select all that apply.

``` r
cor(tr)
```

    ##                 Year         Month           MEI         CO2         CH4
    ## Year      1.00000000 -0.0279419602 -0.0369876842  0.98274939  0.91565945
    ## Month    -0.02794196  1.0000000000  0.0008846905 -0.10673246  0.01856866
    ## MEI      -0.03698768  0.0008846905  1.0000000000 -0.04114717 -0.03341930
    ## CO2       0.98274939 -0.1067324607 -0.0411471651  1.00000000  0.87727963
    ## CH4       0.91565945  0.0185686624 -0.0334193014  0.87727963  1.00000000
    ## N2O       0.99384523  0.0136315303 -0.0508197755  0.97671982  0.89983864
    ## CFC.11    0.56910643 -0.0131112236  0.0690004387  0.51405975  0.77990402
    ## CFC.12    0.89701166  0.0006751102  0.0082855443  0.85268963  0.96361625
    ## TSI       0.17030201 -0.0346061935 -0.1544919227  0.17742893  0.24552844
    ## Aerosols -0.34524670  0.0148895406  0.3402377871 -0.35615480 -0.26780919
    ## Temp      0.78679714 -0.0998567411  0.1724707512  0.78852921  0.70325502
    ##                  N2O      CFC.11        CFC.12         TSI    Aerosols
    ## Year      0.99384523  0.56910643  0.8970116635  0.17030201 -0.34524670
    ## Month     0.01363153 -0.01311122  0.0006751102 -0.03460619  0.01488954
    ## MEI      -0.05081978  0.06900044  0.0082855443 -0.15449192  0.34023779
    ## CO2       0.97671982  0.51405975  0.8526896272  0.17742893 -0.35615480
    ## CH4       0.89983864  0.77990402  0.9636162478  0.24552844 -0.26780919
    ## N2O       1.00000000  0.52247732  0.8679307757  0.19975668 -0.33705457
    ## CFC.11    0.52247732  1.00000000  0.8689851828  0.27204596 -0.04392120
    ## CFC.12    0.86793078  0.86898518  1.0000000000  0.25530281 -0.22513124
    ## TSI       0.19975668  0.27204596  0.2553028138  1.00000000  0.05211651
    ## Aerosols -0.33705457 -0.04392120 -0.2251312440  0.05211651  1.00000000
    ## Temp      0.77863893  0.40771029  0.6875575483  0.24338269 -0.38491375
    ##                 Temp
    ## Year      0.78679714
    ## Month    -0.09985674
    ## MEI       0.17247075
    ## CO2       0.78852921
    ## CH4       0.70325502
    ## N2O       0.77863893
    ## CFC.11    0.40771029
    ## CFC.12    0.68755755
    ## TSI       0.24338269
    ## Aerosols -0.38491375
    ## Temp      1.00000000

3 - SIMPLIFYING THE MODEL
-------------------------

Given that the correlations are so high, let us focus on the N2O variable and build a model with only MEI, TSI, Aerosols and N2O as independent variables. Remember to use the training set to build the model.

Enter the coefficient of N2O in this reduced model:

``` r
model = lm(data = tr,formula = Temp ~ MEI+TSI+Aerosols+N2O)
summary(model)
```

    ## 
    ## Call:
    ## lm(formula = Temp ~ MEI + TSI + Aerosols + N2O, data = tr)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.27916 -0.05975 -0.00595  0.05672  0.34195 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) -1.162e+02  2.022e+01  -5.747 2.37e-08 ***
    ## MEI          6.419e-02  6.652e-03   9.649  < 2e-16 ***
    ## TSI          7.949e-02  1.487e-02   5.344 1.89e-07 ***
    ## Aerosols    -1.702e+00  2.180e-01  -7.806 1.19e-13 ***
    ## N2O          2.532e-02  1.311e-03  19.307  < 2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.09547 on 279 degrees of freedom
    ## Multiple R-squared:  0.7261, Adjusted R-squared:  0.7222 
    ## F-statistic: 184.9 on 4 and 279 DF,  p-value: < 2.2e-16

4 - AUTOMATICALLY BUILDING THE MODEL
------------------------------------

We have many variables in this problem, and as we have seen above, dropping some from the model does not decrease model quality. R provides a function, step, that will automate the procedure of trying different combinations of variables to find a good compromise of model simplicity and R . This trade-off is formalized by the Akaike information criterion (AIC) - it can be informally thought of as the quality of the model with a penalty for the number of variables in the model.

The step function has one argument - the name of the initial model. It returns a simplified model. Use the step function in R to derive a new model, with the full model as the initial model (HINT: If your initial full model was called "climateLM", you could create a new model with the step function by typing step(climateLM). Be sure to save your new model to a variable name so that you can look at the summary. For more information about the step function, type ?step in your R console.)

Enter the R value of the model produced by the step function:

``` r
StepModel = step(model)
```

    ## Start:  AIC=-1329.25
    ## Temp ~ MEI + TSI + Aerosols + N2O
    ## 
    ##            Df Sum of Sq    RSS     AIC
    ## <none>                  2.5429 -1329.2
    ## - TSI       1    0.2603 2.8032 -1303.6
    ## - Aerosols  1    0.5554 3.0984 -1275.1
    ## - MEI       1    0.8487 3.3916 -1249.5
    ## - N2O       1    3.3975 5.9404 -1090.3

``` r
summary(StepModel)
```

    ## 
    ## Call:
    ## lm(formula = Temp ~ MEI + TSI + Aerosols + N2O, data = tr)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.27916 -0.05975 -0.00595  0.05672  0.34195 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) -1.162e+02  2.022e+01  -5.747 2.37e-08 ***
    ## MEI          6.419e-02  6.652e-03   9.649  < 2e-16 ***
    ## TSI          7.949e-02  1.487e-02   5.344 1.89e-07 ***
    ## Aerosols    -1.702e+00  2.180e-01  -7.806 1.19e-13 ***
    ## N2O          2.532e-02  1.311e-03  19.307  < 2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.09547 on 279 degrees of freedom
    ## Multiple R-squared:  0.7261, Adjusted R-squared:  0.7222 
    ## F-statistic: 184.9 on 4 and 279 DF,  p-value: < 2.2e-16

TESTING ON UNSEEN DATA
----------------------

We have developed an understanding of how well we can fit a linear regression to the training data, but does the model quality hold when applied to unseen data? Using the model produced from the step function, calculate temperature predictions for the testing data set, using the predict function. Enter the testing set R :

``` r
tempPredict = predict(StepModel, newdata = test)
```
