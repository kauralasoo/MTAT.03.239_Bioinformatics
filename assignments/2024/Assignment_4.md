# Assignment 4

## Task 1: RNA-seq alignment (2 points)
**Learning objective:** You will learn how RNA sequencing is used to measure gene expression and what computational steps are needed to do that. First, you will understand what the raw RNA sequencing reads (in FASTQ format) look like and how you can use alignment software (HISAT2) to find the locations in the reference genome where these reads come from. Counting the number of reads overlapping gene annotations will also show you how gene expression is measured using RNA-seq. 

Using the [RNA-seq alignment tutorial](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/blob/master/RNA-seq_alignment.md), answer the following questions:

 1. How many reads are there in the fikt_A.1.fastq.gz and fikt_A.2.fastq.gz FASTQ files?
 2. Following the instructions, align the FASTQ files to the reference genome. Sort the alignments by position and create the index.
 3. What fraction of the reads mapped to the reference genome? (HINT: use samtools flagstat).
 4. What fraction of the paired-end fragments were assigned to genes? (HINT: You can find this from the summary file created by featureCounts)
 5. Copy to sorted BAM file together with the index from the HPC to your own environment (See Assignment 1). Open the BAM file in IGV. Zoom into the PFKL gene on chromosome 21. You should be able to see individual reads mapping to the exons of the gene. Now move to the neighbouring AIRE gene. What do you see? Make IGV screenshots for both genes and include them into your report.
 6. Find the number of paired-end fragments overlapping the PFKL and AIRE genes from the featureCounts file (last column). Do these broadly match what you observed in the IGV? (No need to count fragments manually from IGV) (HINT: You can use the search box on the [Ensembl website](http://www.ensembl.org/) to find the gene ids for both gens).
 7. Repeat the same processing steps on all of the four samples (fikt_A, fikt_C, eipl_A, eipl_C) found in [Zenodo](https://zenodo.org/record/1173306).  Report the paired-end fragment counts for PFKL and AIRE genes in all four samples.

## Task 2: Exploratory data analysis (1.5  points)
**Learning objective**: Learn how to use exploratory data analysis techniques to detect issues with data quality.

The [gene expression data tutorial](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/blob/master/gene_expression/Exploring_gene_expression.md) tells you how to get started with analysing gene expression data in R. The dataset used in the tutorial has already been cleaned, but this is usually not the case for real biological data. For example, sometimes samples can get accidentally mis-labeled in the laboratory. A common occurrence (that has happened to me as well!) is that different treatments from the same individual are accidentally swapped. 

In this exercise, your task is to download a 'dirty' [gene expression dataset](https://zenodo.org/records/10805436/files/RNA_SummarizedExperiment_swapped.rds?download=1) and use exploratory data analysis techniques (gene expression correlation heatmap, PCA) to identify which (if any) of the samples have been swapped. In your report, please include the plots that you created, the code that you used to generate these plots and the names of the samples that have been swapped and what should be their correct names.

## Task 3: Differential expression analysis (2 points)
**Learning objective**: Learn how to identify genes that are significantly differentially expressed between two conditions and how sample size influences your power to detect differences.

 1. Download the original [clean gene expression](https://zenodo.org/records/10805436/files/RNA_SummarizedExperiment.rds?download=1) dataset from the course website (**not** the one used in Task 2). Using the [gene expression tutorial](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/blob/master/gene_expression/Exploring_gene_expression.md), sample three (3) random donors (individuals) from the original dataset and subset the data. Use the same `set.seed(1)` command as shown in the tutorial to ensure reproducibility of the results. 
 1. Using DESeq2 as shown in the tutorial, identify genes that significantly differentially between the naive and interferon-gamma (IFNg) conditions (false discovery rate (FDR) < 0.01). Answer the the following questions:
	 - How many genes are significantly differentially expressed (FDR < 0.01)? How many of them are *upregulated* (increase in expression, log2 fold-change > 0) by IFNg and how many are *downregulated* (decrease on expression, log2 fold-change < 0)? (NOTE: the sign of the log2 fold-change depends on the factor levels of the conditions that you put into the model, always check that the sign is what you expect it to be using the raw counts!)
	 - How many of the signficantly differentially expressed genes have absolute log2 fold-change > 1? How many of them are upregulated and how many of them are downregulated?
1. Repeat the the analysis done in point 1 for increasingly larger number of donors (try at least 5, 8, 16, and 24 random donors). Find the answers to the same questions highlighted in point 1. How does the number of differentially expressed genes (FDR < 0.01) change with increased sample size? What happens when you also filter the differentially expressed genes according to their effect size (absolute log2 fold-change > 1)? Does the number of differentially expressed genes above the effect size threshold (absolute log2 fold-change > 1) keep increasing when you increase the sample size? You could use a simple line plot to illustrate these points.
2.  Repeat the same analysis done in points 2 and 3 on the naive vs Salmonella (SL1344) conditions. Do you get similar results as in the naive vs IFNg analysis?

## Task 4: Functional enrichment analysis (1.5 points)
**Learning objective:** Learn how to interpret the differentially expressed gene lists that you generated in Task 3.

 1. Identify genes that are **upregulated** after IFNg stimulation (FDR < 0.01, log2 fold-change > 1). Copy this gene list into [g:Profiler](https://biit.cs.ut.ee/gprofiler/). Report the top 20 most strongly enriched Gene Ontology biological processes (GO:BP) (HINT: Click Detailed Results to see enrichment results by annotation category). Can you find evidence that your gene list is enriched for known genes involved in response to interferon-gamma? 
 2. Repeat the same g:Profiler analysis for genes **upregulated** after *Salmonella* infection (FDR < 0.01, log2 fold-change > 1). Report the top 20 most enriched Gene Ontology biological processes (GO:BP). How do the results compare to the IFNg response? Are there shared terms between IFNg and *Salmonella* response? Are there specific enrichments that you did not see in the IFNg results?

