# Homework 4

## Task 1: Gene expression clustering with funcExplorer (2 points)
**Learning objective:** Learn how clustering gene expression can reveal biological structure in the data.

Open the [full macrophage RNA-seq dataset](https://biit.cs.ut.ee/funcexplorer/link/ecb43) in funcExplorer and answer the following questions:

 1. Can you find clusters of gene that are upregulated by interferon-gamma (conditions B and D)? What are terms that these genes are enriched for?
 2. Your scatter plot of log2 fold-changes between naive vs IFNg and naive vs Salmonella highlighted that there was a modest correlation (Pearson's r = 0.5) between differentially expressed genes in these two conditions. This suggests that some genes are  activated by both stimuli. Can you find a cluster of genes that is upregulated in all stimulated conditions (B, C and D)? What terms is it enriched for?
 3. Is there a group of genes that is upregulated only when both of the stimuli are present? What is it enriched for?
 4. Can you find a group of genes that is specifically downregulated by IFNg (conditons B and D) but not Salmonella (C). What is this cluster enriched for?
 5. Play around with funcExplorer parameters (Strategy, Additional p-value threshold). Can you still identify the same clusters and enriched terms?

## Task 2: Interpreting co-expressed genes (2 points)
**Learning objective**: Learn how you can interpret an unknown group of co-expressed genes by comparing their summarised expression values (eigengene values) to sample annotations.

In cluster 4119 (enriched for extracellular matrix organisation) the genes are not differential expressed between conditions. Instead, the genes seem to have similar expression values in all samples from the same donor and different expression values in different donors (i.e. the genes are differentially expressed between different donors, but not between different conditions). Extract the eigengene values for all clusters from funcExplorer (Summary -> Eigengene data) (or download from [here](https://courses.cs.ut.ee/2018/bioinfo/spring/uploads/Main/RNA_336_samples_protein_coding_eigengene.txt)) and compare th the eigengene values of cluster 4119 to the sample metadata columns of the original dataset. You can view the sample metadata using the colData() function of the SummarizedExperiment class and you can find a longer description of the metadata columns in [here](https://zenodo.org/record/1188300/files/RNA_metadata_columns.txt).

Which *numerical* metadata column is most highly correlated with the eigengene values of cluster 4119 across samples? Report the correlation coefficient and make a scatterplot. Based on these results, can you guess what the genes in cluster 4119 might represent?

## Task 3: Variance component analysis (1 point)
**Learning objective:** Understand how hierarchical models (aka linear mixed models) can be used to estimate the proportion of total of variance explained by different factors.

Using the variance component analysis [tutorial](https://github.com/kauralasoo/flow_cytomtery_genetics/blob/master/analysis/variance_components/estimate_variance_components.md), repeat the the variance component analysis for the CD16 and CD206 markers on both the full and replicated datasets. Do they give the same result as CD14, where most of the variance was explained by cell line?  If not, can you explain why? (HINT: you can use the same dot plots that were used under the section "Visualising sources of variation" to prove your point).
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTYyNjU2Mzc0XX0=
-->