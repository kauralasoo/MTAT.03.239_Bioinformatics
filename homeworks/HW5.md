# Homework 5

## Task 1: Understanding linkage disequilibrium (1.5 point)
How many variants are in high linkage disequilibrium with the lead CD14 QTL variant (R2 > 0.8)?

## Task 2: Calculating empirical p-values (2 points)
Permutation testing.

## Task 3: Understanding the mechanism of the CD14 QTL (2 points)
There are many possible ways how a genetic variant could change protein cell surface expression. One possibility is that the genetic variant changes the expression of the gene already at the mRNA level and this in turn influences how much protein is made. Alternatively, the genetic variant could directly regulate the rate of protein translation or its stability with no effect on the mRNA. Can you find out, which of these two mechanisms is more likely to be true in the case of CD14 and rs778587. You can find the read counts of the CD14 gene from the [SummarizedExperiment object](https://courses.cs.ut.ee/2018/bioinfo/spring/uploads/Main/RNA_SummarizedExperiment.rds.zip) that you used in Homework 2. The genotypes for the rs778587 variant are available from [here](https://github.com/kauralasoo/flow_cytomtery_genetics/blob/master/data/genotypes/cd14_lead_variant.txt).  Use the read counts from the naive condition only. You can use linear regression (`lm` function in R) to test for the association between CD14 gene expression and rs778587 variant, but do not forget that you need to transform the read counts first (using either log transformation or variance stabilising transformation). Alternatively, you can also use the DESeq2 package. Illustrate your conclusions with a boxplot of CD14 gene and protein expression stratified by the genotype of the rs778587 variant.


<!--stackedit_data:
eyJoaXN0b3J5IjpbODA3ODU2MjkyXX0=
-->