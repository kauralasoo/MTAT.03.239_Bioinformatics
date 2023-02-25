# Assignment 6

## Task 1: Variance component analysis (2 point)
**Learning objective:** Understand how hierarchical models (linear mixed models) can be used to estimate the proportion of total of variance explained by different factors.

Using the variance component analysis [tutorial](https://github.com/kauralasoo/flow_cytomtery_genetics/blob/master/analysis/variance_components/estimate_variance_components.md), repeat the variance component analysis for the CD16 and CD206 markers on both the full and replicated datasets. 
1. Does the cell line (line_id) explain most of variance observed in the expression of these proteins as well (like CD14) or is the contribution of flow_date larger for them? 
2. Please illustrate your conclusions by making the same dot plots that were used under the section "Visualising sources of variation" to prove your point.
3. Do you get the same result when you fit line_id and flow_date as fixed effects in standard linear model (lm)? (Hint: Fit two separate linear models, one with line_id as a fixed effect and another one with flow_data as fixed effect, make sure that you convert flow_date to factor first (as.factor).

Note that the flow cytometry data is in its own GitHub repository: https://github.com/kauralasoo/flow_cytomtery_genetics.

## Task 2: Understanding the mechanism of the CD14 QTL (2 points)
There are many possible ways how a genetic variant could change protein cell surface expression. One possibility is that the genetic variant changes the expression of the gene at the mRNA level and this in turn influences how much protein is made. Alternatively, the genetic variant could directly regulate the rate of protein translation or its stability with no effect on the mRNA. 
Can you find out which of these two mechanisms is more likely to be true in the case of CD14 and rs778587? You can find the read counts of the CD14 gene from the [SummarizedExperiment object](https://courses.cs.ut.ee/2018/bioinfo/spring/uploads/Main/RNA_SummarizedExperiment.rds.zip) that you used in Assignment 3. The genotypes for the rs778587 variant are available from [here](https://github.com/kauralasoo/flow_cytomtery_genetics/blob/master/data/genotypes/cd14_lead_variant.txt).  Use the read counts from the naive condition only. You can use linear regression (`lm` function in R) to test for the association between CD14 gene expression and rs778587 variant, but do not forget that you need to transform the read counts first (using either log transformation or variance stabilising transformation). Alternatively, you can also use the DESeq2 package. Illustrate your conclusions with a boxplots of CD14 gene and protein expression stratified by the genotype of the rs778587 variant. 

What is the correlation between CD14 log-transformed gene expression and protein expression in naive (unstimulated) macrophages? Hint: since gene expression and protein expression were measured in the same individuals, you can use the line_id or genotype_id to match the two. 

