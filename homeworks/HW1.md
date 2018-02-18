# Homework 1

## Task 1: Getting familiar with the IGV genome browser (1 point)
**Learning objective:** Gain an intuitive feeling of what the human genome looks like. How long are the genes, where they are located and what fraction of the genome codes for proteins.

 1. Download and run the [Integrative Genomics Viewer](http://software.broadinstitute.org/software/igv/).
 2. Change the genome version to hg38 (top left corner)
 3. Search for the Sonic Hedgehog (SHH) gene. Right click on the gene and select Expanded to see all of the annotate transcripts. How many annotated transcript does the SHH gene have?
 4. How long is the longest transcript? How far is it from closest neighbouring genes on the left and right?
 5. Now go to the lactase (LCT) gene (it's the gene that allows us to drink milk). How long is this on? How far is it from its neigbours?

## Task 2: RNA-seq alignment (2 points)
**Learning objective:** You will learn how RNA sequencing is used to measure gene expression and what computational steps are needed to do that. First, you will understand what the raw RNA sequencing reads (in FASTQ format) look like and how you can use alignment software (HISAT2) to find the locations in the reference genome where these reads come from. Counting the number of reads overlapping gene annotations will also show you how gene expression is measured using RNA-seq. 

Using the [RNA-seq alignment tutorial](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/blob/master/RNA-seq_alignment.md), answer the following questions:

 1. How many reads are there in the fikt_A.1.fastq.gz and fikt_A.1.fastq.gz FASTQ files?
 2. Following the instructions, align the FASTQ files to the reference genome. Sort the alignments by position and create the index.
 3. What fraction of the reads mapped to the reference genome? (HINT: use samtools flagstat).
 4. What fraction of the paired-end fragments were assigned to genes? (HINT: You can find this from the summary file created by featureCounts)
 5. Copy to sorted BAM file together with the index out of the docker container to your own environment. Open the BAM file in IGV. Zoom into the PFKL gene on chromosome 21. You should be able to see individual reads mapping to the exons of the gene. Now move to the neighbouring AIRE gene. Make IGV screenshots for both genes and include them to your report.
 6. Find the number of paired-end fragments overlapping the the PFKL and AIRE genes from the featureCounts file. Do these match to what you observed in the IGV? (HINT: You can use the search box on the [Ensembl website](http://www.ensembl.org/) to find the gene ids for both gens).

## Task 3. Constructing a data analysis workflow with Snakemake (2 points)
**Learning objective:** In Task 2, you learned how to measure gene expression (count the number of RNA-seq reads overlapping a gene) in one sample. You saw, that this process involved multiple steps - alignment, sorting, indexing and counting. This a typical of many real-world bioinformatics workflows where you have to run tens of data processing steps on hundreds of samples. In this task, you will learn how to automate these steps using Snakemake. A key advantage of Snakemake is that the same pipeline works equally well on your own computer as well as on a cloud environment or a [high performance computing](https://hpc.ut.ee/en_US) infrastructure with only minor modifications needed.

**Assignment**: Use [Snakemake](https://snakemake.readthedocs.io/en/stable/tutorial/tutorial.html) to automate the RNA-seq analysis that you perfomed in Task 2. Expand this to all four RNA-seq samples available from [Zenodo](https://zenodo.org/record/1173306). Snakemake can be a bit daunting to get started initially, but has an excellent [tutorial](https://snakemake.readthedocs.io/en/stable/tutorial/tutorial.html).

 1. Submit the Snakemake workflow that you wrote as well as the the graphical representation of the workflow (generated with `snakemake --dag`).
 2. Report the paired-end fragment counts for PFKL and AIRE genes in all four samples.

<!--stackedit_data:
eyJoaXN0b3J5IjpbMTIzNjU4NTA5NF19
-->