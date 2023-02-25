# Assignment 9

# Task 1 (4 points)
**Learning outcomes**: In this task, you will learn how statistical fine mapping results can be combined with information about regulatory elements (accessible chromatin regions) and transcription factor motifs to identify putative causal variants as well as likely transcription factors through which these variants act. You will also see that pinpointing to a single causal variant and trancription factor that it influences is usually much trickier than one would exect.

In this task, you will study two fine mapped eQTL credible sets from the Alasoo et al, 2018 publication: (A) Inteferon-gamma + Salmonella-specific eQTL for the GP1BA gene detected (Figure 2d) and (b) interferon-gamma-specific eQTL for the SPOPL gene (Figure 3a).

**Part a: GP1BA eQTL**

Following the [motifbreakR tutorial](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/blob/master/fine_mapping/motifbreakR.md), answer the following the questions for the GP1BA eQTL:
1. How many genetic variants belong to the 95% credible set? What is the largest observed posterior inclusion probability (PIP)?
2. How many of those credible set variants overlap at least one open chromatin region in macrophages?
3. Does the variant with the largest PIP value overlap an open chromatin region?
4. Now focussing only on the variants that lie in open chromatin regions, use motifbreakR R package and the HOCOMOCO database to scan for transcription factors whose  binding affinity might be influenced by these variants? Using the p-value threshold of 1e-4, how many distinct transcription factors can you detect (geneSymbol column)? Is NFKB1 or RELA one of those factors as reported in the Alasoo et al, 2018 publication?
5. What if you reduce the p-value threshold to 1e-3? Is NFKB1 or RELA now one of the detected factors? How big is the difference in the relative bindign score the the reference and alternative alleles (use the values in the pctRef and pctAlt columns)? How many other distinct factors are detected (geneSymbol column)?
6. Use plotMB function to visualise which position of the NFKB1/RELA motif is disrupted by the genetic variant.
7. Assuming that lower binding affinity (and less transcription factor binding) translates to less gene expression, is the direction of the motif disruption effect consitent with the eQTL effect of the putative causal variant? Look at the sign of the z-score column (z) in the fine-mapping results. Negative z-score values indicate that the alternative allele decreases expression while positive z-scores values indicate that the alternative allele increases expression).

**Part b: SPOPL eQTL**

Following the [motifbreakR tutorial](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/blob/master/fine_mapping/motifbreakR.md), answer the following the questions for the SPOPL eQTL:
1. How many genetic variants belong to the 95% credible set? What is the largest observed posterior inclusion probability (PIP)?
2. How many of those credible set variants overlap at least one open chromatin region in macrophages?
3. Does the variant with the largest PIP value overlap an open chromatin region?
4. Now focussing only on the variants that lie in open chromatin regions, use motifbreakR R package and the HOCOMOCO database to scan for transcription factors whose binding affinity might be influenced by these variants? Using the p-value threshold of 1e-4, how many distinct transcription factors can you detect (geneSymbol column)? Is SPI1 (PU.1 one of those factors as reported in the Alasoo et al, 2018 publication?
5. What if you reduce the p-value threshold to 1e-3? Is SPI1 now one of the detected factors? How big is the difference in the relative bindign score for the reference and alternative alleles (use the values in the pctRef and pctAlt columns for this)? How many other distinct factors are detected (geneSymbol column)?
6. Use plotMB function to visualise which position of SPI1 motif is disrupted by the genetic variant.
7. Assuming that lower binding affinity (and less transcription factor binding) translates to less gene expression, is the direction of the motif disruption effect consitent with the eQTL effect of the putative causal variant? Look at the sign of the z-score column (z) in the fine-mapping results. Negative z-score values indicate that the alternative allele decreases expression while positive z-scores values indicate that the alternative allele increases expression).
