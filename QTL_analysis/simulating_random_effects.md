---
title: "Simulating random effects"
output: 
  html_document: 
    keep_md: yes
---



## Load the necessary packages

```r
library("lme4")
```

```
## Loading required package: Matrix
```

```r
library("dplyr")
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library("ggplot2")
```

# Application to a balanced dataset

## Simulate data

Simulate a dataset with 5 individuals, each one containing 10 replicates.

Specify tesired desired between-individual variance and measurement noise variance. In this case the variance between individuals equal to the variance within individuals.


```r
var_individual = 0.5
var_noise = 0.5
set.seed(34)
```

We can confirm this by calculating the theoretical (population) variance explained by between-individual differences:

```r
var_individual/(var_individual + var_noise)
```

```
## [1] 0.5
```

Now, let's simulate the data:

```r
#Specify the number of replicates per individual
replicate_counts = c(10,10,10,10,10)

#Sample individual means from the normal distribution with variance var_individual
individual_means = rnorm(5, mean = 0, sd = sqrt(var_individual))
ind_means = dplyr::tibble(individual_mean = individual_means, 
                              individual = paste0("ind_", c(1:5)))

#Add replicates and sample measurement noise
data_balanced = dplyr::tibble(individual = paste0("ind_", rep(c(1,2,3,4,5), times = replicate_counts))) %>%
  dplyr::left_join(ind_means, by = "individual") %>%
  #Sample measurement noise from the normal distribution with variance var_noise
  dplyr::mutate(noise = rnorm(length(individual), mean = 0, sd = sqrt(var_noise))) %>%
  dplyr::mutate(expression = individual_mean + noise) %>%
  dplyr::mutate(sample_index = c(1:length(individual)))
data_balanced
```

```
## # A tibble: 50 x 5
##    individual individual_mean    noise expression sample_index
##    <chr>                <dbl>    <dbl>      <dbl>        <int>
##  1 ind_1              -0.0982 -0.322       -0.420            1
##  2 ind_1              -0.0982  0.474        0.376            2
##  3 ind_1              -0.0982 -0.600       -0.699            3
##  4 ind_1              -0.0982  0.754        0.656            4
##  5 ind_1              -0.0982 -0.00528     -0.103            5
##  6 ind_1              -0.0982 -0.285       -0.383            6
##  7 ind_1              -0.0982  0.508        0.410            7
##  8 ind_1              -0.0982 -0.127       -0.226            8
##  9 ind_1              -0.0982  0.740        0.642            9
## 10 ind_1              -0.0982  0.284        0.186           10
## # … with 40 more rows
```


Simulated sample variance explained by between-individual differences. Note that this is not exactly same as the theortical estimate above due to sampling noise. 

```r
var(individual_means)/(var(individual_means) + var(data_balanced$noise))
```

```
## [1] 0.374504
```

## Visualise data

Make a plot of the raw data

```r
ggplot(data_balanced, aes(x = sample_index, y = expression, color = individual)) + 
  geom_point() + 
  facet_grid(~individual, scales = "free_x")
```

![](simulating_random_effects_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

Specify a helper function that extracts the proportion of variance explained by different paramters of the linear mixed model

```r
#' Calculate the proportion of variance explaned by different factors in a lme4 model
varianceExplained <- function(lmer_model){
  variance = as.data.frame(lme4::VarCorr(lmer_model))
  var_percent = dplyr::mutate(variance, percent_variance = vcov/sum(vcov)) %>% 
    dplyr::select(grp, percent_variance) %>% 
    dplyr::mutate(type = "gene")
  var_row = tidyr::spread(var_percent, grp, percent_variance)
  return(var_row)  
}
```

Fit a linear mixed model to the dataset to estimate the porportion of variance explained by differences between individuals. Note that this model assumes that the underlying "true" mean expression level for each individual comes from the same distribution. 

```r
model = lmer(expression ~ (1|individual), data_balanced)
varianceExplained(model)
```

```
##   type individual  Residual
## 1 gene  0.3589928 0.6410072
```

Perform the same analysis with a standard fixed effect linear model. The standard fixed effect linear model considers each individual completely seprately, without taking other individuals into account.

```r
model_fixed = lm(expression ~ individual, data_balanced)
#Estimate variance explained
summary(model_fixed)$adj.r.squared
```

```
## [1] 0.3137426
```

Extract model coefficients (estimated mean expression levels for each individual) from the linear mixed model:

```r
coefs = coef(model)$individual
coefs_df = dplyr::data_frame(individual = rownames(coefs), coef = coefs[,1], type = "lme4")
```

```
## Warning: `data_frame()` is deprecated, use `tibble()`.
## This warning is displayed once per session.
```

Estmate individual means for the linear model (these are just the means calculated for each individual separately):

```r
ind_means = dplyr::group_by(data_balanced, individual) %>% 
  dplyr::summarize(coef = mean(expression), type = "lm")
```

Visualise the raw data together with the estimated means from the linear model and linear mixed model:

```r
ggplot(data_balanced, aes(x = sample_index, y = expression, color = individual)) + 
  geom_point() + 
  facet_grid(~individual, scales = "free_x") + 
  geom_hline(data = coefs_df, aes(yintercept = coef, linetype = type)) +
  geom_hline(data = ind_means, aes(yintercept = coef, linetype = type))
```

![](simulating_random_effects_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

What you should see is that although the estimates from the linear model (lm) and linear mixed model (lme4) are similar, they are not exactly the same. This is because we have simulated a relatively large measurement noise (var_noise) which makes the linear mixed model to "trust" the estimates within each individual less and forces the estimates from each individual to be close to the global mean across individuals.


# Application to an unbalanced dataset

Now, let's consider an unbalanced example where the number of samples collected from each individual is very different. For example, here we have a situation where three individuals have very many replicates (13-20) and two individuals have only two replicates:


```r
#Specify the number of replicates per individual
replicate_counts = c(20,15,13,1,1)

#Sample individual means from the normal distribution with variance var_individual
individual_means = rnorm(5, mean = 0, sd = sqrt(var_individual))
ind_means = dplyr::data_frame(individual_mean = individual_means, 
                              individual = paste0("ind_", c(1:5)))

#Add replicates and sample measurement noise
data_unbalanced = dplyr::data_frame(individual = paste0("ind_", rep(c(1,2,3,4,5), times = replicate_counts))) %>%
  dplyr::left_join(ind_means, by = "individual") %>%
  #Sample measurement noise from the normal distribution with variance var_noise
  dplyr::mutate(noise = rnorm(length(individual), mean = 0, sd = sqrt(var_noise))) %>%
  dplyr::mutate(expression = individual_mean + noise) %>%
  dplyr::mutate(sample_index = c(1:length(individual)))
data_unbalanced
```

```
## # A tibble: 50 x 5
##    individual individual_mean  noise expression sample_index
##    <chr>                <dbl>  <dbl>      <dbl>        <int>
##  1 ind_1                0.681 -0.726    -0.0457            1
##  2 ind_1                0.681  0.992     1.67              2
##  3 ind_1                0.681 -0.926    -0.245             3
##  4 ind_1                0.681 -1.26     -0.584             4
##  5 ind_1                0.681 -0.512     0.168             5
##  6 ind_1                0.681  0.216     0.896             6
##  7 ind_1                0.681  0.596     1.28              7
##  8 ind_1                0.681  0.481     1.16              8
##  9 ind_1                0.681  0.474     1.15              9
## 10 ind_1                0.681 -0.339     0.342            10
## # … with 40 more rows
```

Visualise the data

```r
ggplot(data_unbalanced, aes(x = sample_index, y = expression, color = individual)) + 
  geom_point() + 
  facet_grid(~individual, scales = "free_x")
```

![](simulating_random_effects_files/figure-html/unnamed-chunk-14-1.png)<!-- -->

Estimate simulated variance explained

```r
var(individual_means)/(var(individual_means) + var(data_unbalanced$noise))
```

```
## [1] 0.4608552
```

With linear mixed model

```r
model = lmer(expression ~ (1|individual), data_unbalanced)
varianceExplained(model)
```

```
##   type individual  Residual
## 1 gene  0.5775757 0.4224243
```

With linear model

```r
model_fixed = lm(expression ~ individual, data_unbalanced)
#Estimate variance explained
summary(model_fixed)$adj.r.squared
```

```
## [1] 0.4234042
```

Extract model (estimated mean expression levels for each individual) from the linear mixed model:

```r
coefs = coef(model)$individual
coefs_df = dplyr::data_frame(individual = rownames(coefs), coef = coefs[,1], type = "lme4")
model_df = dplyr::left_join(data_unbalanced, coefs_df, by = "individual")
```

Estmate individual means for the linear model (these are just the means calculated for each individual separately):

```r
ind_means = dplyr::group_by(data_unbalanced, individual) %>% 
  dplyr::summarize(coef = mean(expression), type = "lm")
```

Visualise the data together with estimated means. 

```r
ggplot(data_unbalanced, aes(x = sample_index, y = expression, color = individual)) + 
  geom_point() + 
  facet_grid(~individual, scales = "free_x") + 
  geom_hline(data = coefs_df, aes(yintercept = coef, linetype = type)) +
  geom_hline(data = ind_means, aes(yintercept = coef, linetype = type))
```

![](simulating_random_effects_files/figure-html/unnamed-chunk-20-1.png)<!-- -->

From here, you should be able to see that for individuals 1-3 that have many data points both linear model and linear mixed model produce very similar estimates for mean expression. However, for individuals 4 and 5 that each have only one data point, the only estimate that a linear model can provide for the mean is the value of the one data point itself. In contrast, because the linear mixed model assumes that all individuals come the from same global distribution with shared mean and standard deviation, it "pulls" the estimates for individuals 4 and 5 closer to the means of the other individuals, because it recognises that there is less data to support such large mean values for these two individuals.

## Exercise 1
You should now try to change the `var_noise` parameter at the top of this document from 0.5 to 0.05, thus reducing the simulated measurement noise by 10-fold. What do you see? Are the estimates from the linear mixed model and linear model now agreeing more with each other? 

