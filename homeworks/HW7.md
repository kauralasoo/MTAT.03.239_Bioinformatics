# Homework 7

## Task 1: Estimating colocalisation between gene expression and disease associations (2 points).

Based on the colocalisation tutorial available [here](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/blob/master/colocalisation/Introduction_to_coloc.md) and using the default prior probabilities of coloc (p1 = p2 = 1e-4, p12 = 1e-5), estimate the colocalisation of genetic associations for the following traits:

 1. Expression of PTK2B gene in the naive condition and Alzheimer's disease (AD)
 2. Expression of ICOSLG gene in the naive condition and ulcerative colitis (UC).
 3. Expression of the TRAF1 gene and rheumatoid arthritis, both in the naive as well as in the IFNg + Salmonella condition.

In all three cases, use the region +/- 200 kb from the lead eQTL variant. For all three analyses, report the posterior probabilities for all 5 hypothesis (H0-H4). To remind yourself what the hypotheses  were, have a look at the [original paper](http://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1004383).  Which of these three gene expression signals colocalise with the disease association?

In all three cases, make also Manhattan plots for both the disease and gene expression associations. On both plots, mark the lead eQTL variant in red and the lead GWAS variant in blue. Also, report the p-values for these two variants for both of the traits (4 p-values in total). For a given trait (gene expression or disease) are the p-values similar or different? Does this reflect the colocalisation posterior probabilities (PP4)?

## Task 2: How do the prior probabilities influence colocalisation results? (1.5 points)

Repeat the colocalisation analyses that you did in Task 1, but now change the prior probabilites to the ones recommended in the paper (p1 = p2 = 1e-4, p12 = **1e-6**). Note that although the paper and the software were written by the same authors, they recommend different prior probabilities. How can this new lower p12 prior probability be interpreted? (HINT: Read the [original paper](%28http://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1004383)). 

How do the results for the three colocalisations from Task 1 change? Are the TRAF1 and PTK2B associations influenced differently the the change in prior probabilities? If yes, can you understand why?  (HINT: Reading case studies in the [original paper](%28http://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1004383)) might again be helpful. 

## Task 3: How does the length of the genomic region influence colocalisation results?
Repe



<!--stackedit_data:
eyJoaXN0b3J5IjpbLTExNjU5NzE3MDYsLTg3NjE0MTA3NiwyMD
MxMzM3MSwtMTUyNzgyNTAwMV19
-->