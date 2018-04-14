# Homework 7

## Task 1: Estimating colocalisation between gene expression and disease associations.

Based on the colocalisation tutorial available [here](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/blob/master/colocalisation/Introduction_to_coloc.md) and using the default prior probabilities of coloc (p1 = p2 = 1e-4, p12 = 1e-5), estimate the colocalisation of genetic associations for the following traits:

 1. Expression of PTK2B gene in the naive condition and Alzheimer's disease (AD)
 2. Expression of ICOSLG gene in the naive condition and ulcerative colitis (UC).
 3. Expression of the TRAF1 gene and rheumatoid arthritis, both in the naive as well as in the IFNg + Salmonella condition.

For all three analyses, report the posterior probabilities for all 5 hypothesis (H0-H4). To remind yourself what the hypotheses  were, have a look at the [original paper](http://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1004383).  Which of these three gene expression signals colocalise with the disease association?

In all three cases, make also Manhattan plots for both the disease and gene expression associations. On both plots, mark the lead eQTL variant in red and the lead GWAS variant in blue. Also, report the p-values for these two variants for both of the traits (4 p-values in total). For a given trait (gene expression or disease) are the p-values similar or different? Does this reflect the colocalisation posterior probabilities (PP4)?

## Task 2: Understanding the impact of prior probabilities on colocalisation.

Repeat the colocalisation analyses 

## Task 3: How sensitive is colocalisation to prior probabilities? Explore this at the PTK2B and TRAF1 loci.


<!--stackedit_data:
eyJoaXN0b3J5IjpbMTc0NzU5OTA4OCwtODc2MTQxMDc2LDIwMz
EzMzcxLC0xNTI3ODI1MDAxXX0=
-->