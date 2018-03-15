# Homework 4

## Task 1: Gene expression clustering with funcExplorer (2 points)
**Learning objective:** Learn how clustering gene expression can reveal biological structure in the data.

Open the [full macrophage RNA-seq dataset](https://biit.cs.ut.ee/funcexplorer/link/ecb43) in funcExplorer and answer the following questions:

 1. Can you find clusters of gene that are upregulated by interferon-gamma (conditions B and D)? What are terms that these genes are enriched for?
 2. Your scatter plot of log2 fold-changes between naive vs IFNg and naive vs Salmonella highlighted that there was a modest correlation (Pearson's r = 0.5) between differentially expressed genes in these two conditions. This suggests that some genes are  activated by both stimuli. Can you find a cluster of genes that is upregulated in all stimulated conditions (B, C and D)? What terms is it enriched for?
 3. Is there a group of genes that is upregulated only when both of the stimuli are present? What is it enriched for?
 4. Can you find a group of genes that is specifically downregulated by IFNg (conditons B and D) but not Salmonella (C). What is this cluster enriched for?

## Task 3: 

In cluster 4119 (enriched for extracellular matrix organisation), instead of b
 

## Task 2: Variance component analysis (2 points)
**Learning objective:** Understand how hierarchical models (aka linear mixed models) can be used to estimate the proportion of total of variance explained by different factors.

Using the variance component analysis [tutorial](https://github.com/kauralasoo/flow_cytomtery_genetics/blob/master/analysis/variance_components/estimate_variance_components.md), repeat the the variance component analysis for the CD16 and CD206 markers on both the full and replicated datasets. Do they give the same result as CD14, where most of the variance was explained by cell line?  If not, can you explain why? (HINT: you can use the same dot plots that were used under the section "Visualising sources of variation" to prove your point).
<!--stackedit_data:
eyJoaXN0b3J5IjpbNzA4MDI3NDIzXX0=
-->