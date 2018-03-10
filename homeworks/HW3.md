# Homework 3

## Task 1: Estimating transcript expression using the EM algorithm (2 points)
**Learning objective**: Understand how the EM algorithm can be used to estimate transcript expression and how it can be influenced by missing transcript annotations.

Your are given the following three transcripts with corresponding exon-level read counts. You can assume that all exons have equal length of 100 nucleotides. With the help of the [EM algorithm tutorial](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/blob/master/transcript_expression/EM-algorithm.md), answer the following questions:
![](HW3_transcripts.png)<!-- -->

 1. Write down the transcript compatibility matrix `M` and the corresponding read count vector `k`. See the example in the slides for reference.
 2. Using the EM-algorithm implemented in the tutorial, estimate the expression of all three transcripts. In our report, provide these final estimates after 1000 iterations as well as a visualisation of how these estimates evolved.
 3. Now, remove Transcript 2 from the annotations, construct a new transcript compatibility matrix `M` and count vector `k` and re-estimate the expression of the remaining two transcripts. How did the expression estimates change compared to using the original 'correct' annotations?

## Task 2: Identify transcripts that are differentially used between conditions (2 points)
**Learning objective**: Learn how differentially used transcripts can be detected using DRIMSeq and how these changes can be visualized using IGV.

**Dataset:** [SummarizedExperiment object](https://www.dropbox.com/s/hwl30are5g6k3ka/salmon_SummarizedExperiment_subset.rds?dl=0) ([alternative link](https://1drv.ms/f/s!AmCRrTXF10_MgWr91VIHfVT9booG)) containing transcript expression levels estimated using [Salmon](https://combine-lab.github.io/salmon/). [BigWig files](https://1drv.ms/f/s!AmCRrTXF10_MgWr91VIHfVT9booG) for visualisation.

**Software:** [DRIMSeq R package](http://bioconductor.org/packages/release/bioc/html/DRIMSeq.html), IGV

Following the [DRIMSeq tutorial](http://bioconductor.org/packages/release/bioc/vignettes/DRIMSeq/inst/doc/DRIMSeq.pdf) and example code provided in [here](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/blob/master/transcript_expression/DRIMSeq_test.R), perform differential transcript usage (DTU) analysis on naive vs Salmonella condition. To limit the computational time required, only include genes from chromosome 6 in your analysis. Answer the following questions.

 1. How many genes undergo differential transcript usage (DTU) in these two conditions (FDR < 0.01)? What fraction of total genes tested is it?
 2. What are the three genes with the smallest DTU p-values? Report both the Ensembl gene ids as well as the their friendly names.
 3. Using the plotProportions function, visualise the transcript proportions before and after Salmonella infection for each of the top 3 genes. What do you see? Report the names of the transcript whose proportion changed the most. Is it only one transcript that changes or are there many transcript that change simultaneously?
 4. Repeat the same analysis for naive vs IFNg conditions and answer the same questions. Are the top 3 with smallestDTU p-values the same or different?

## Task 3: Visualise differentially used transcripts using IGV (1 point)
**Learning objective:** Understand how differential transcript usage manifest at the level of RNA-seq read coverage and how these changes can be detected using visual inspection.

 1. First, download the [BigWig files](https://1drv.ms/f/s!AmCRrTXF10_MgWr91VIHfVT9booG) containing the RNA-seq read coverage from four of the samples found in the original dataset. The `aipt_A` and `auim_A` samples are from the naive condition and the `aipt_C` and `auim_C` samples are from the *Salmonella* condition. 
 2. Open these four bigWig files in IGV and make sure that the reference genome version is set to GRCh38.
 3. Use the search box in IGV to locate the top 3 genes with the smallest differential transcript usage p-values from the naive vs *Salmonella* comparison that you identified in Task 2. 
 4. Make screenshots of RNA-seq read coverage from these three genes and include them in your report. Also, highlight (e.g. with a red rectangle) the specific exons or parts of transcript whose usage changes between naive vs `Salmonella` conditions. 




<!--stackedit_data:
eyJoaXN0b3J5IjpbLTUwNzU5OTEwXX0=
-->