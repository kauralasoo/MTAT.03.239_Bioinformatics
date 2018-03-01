# Homework 2

## Task 1: Exploratory data analysis (1 point)
**Learning objective**: Learn how to use exploratory data analysis techniques to detect issues with data quality.

The [gene expression data tutorial](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/blob/master/gene_expression/Exploring_gene_expression.md) tells you how to get started with analysing gene expression data in R. The dataset used in the tutorial has already been cleaned, but this is usually not the case for real biological data. For example, sometimes samples can get accidentally mis-labeled in the laboratory. A common occurence (that has happened to me me as well!) is that different treatments from the same individual are accidentally swapped. 

In this exercise, your task is to download a 'dirty' [gene expression dataset](https://www.dropbox.com/s/ogwvx9qf8hwt591/RNA_SummarizedExperiment_swapped.rds) and use exploratory data analysis techniques (heatmap, PCA) to identify which (if any) of the samples have been swapped. In your report, please include the plots that you created, the code that you used to generate these plots and the names of the samples that have been swapped and what should be their correct names.

## Task 2: Differential expression analysis
**Learning objective**: Learn how to identify genes that are significantly differentially expressed between two conditions.

 1. Following the gene expression tutorial, identify genes that are significantly differentially expressed between the naive and interferon-gamma (IFNg) conditions (false discovery rate (FDR) < 0.01). How many genes are there? How many genes have absolute  log2 fold-change > 1? How many genes are upregulated by IFNg stimulation these fold-change and FDR thresholds? How many genes are downregulated (de?

<!--stackedit_data:
eyJoaXN0b3J5IjpbNDI1MjYxNTldfQ==
-->