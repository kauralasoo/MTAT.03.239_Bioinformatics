Test# Homework 1

## Task 1: Getting familiar with the IGV genome browser (1 point)

 1. Download and run the [Integrative Genomics Viewer](http://software.broadinstitute.org/software/igv/).
 2. Change the genome version to hg38 (top left corner)
 3. Search for the Sonic Hedgehog (SHH) gene. Right click on the gene and select Expanded to see all of the annotate transcripts. How many annotated transcript does the SHH gene have?
 4. How long is the longest transcript? How far is it from closest neighbouring genes on the left and right?
 5. Now go to the lactase (LCT) gene (it's the gene that allows us to drink milk). How long is this on? How far is it from its neigbours?

## Task 2: RNA-seq alignment (2 points)
Using the [RNA-seq alignment tutorial](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/blob/master/RNA-seq_alignment.md), answer the following questions:

 1. How many reads are there in the fikt_A.1.fastq.gz and fikt_A.1.fastq.gz FASTQ files?
 2. Following the instructions, align the FASTQ files to the reference genome. Sort the alignments by position and create the index.
 3. What fraction of the reads mapped to the reference genome? (HINT: use samtools flagstat).
 4. What fraction of the paired-end fragments were assigned to genes? (HINT: You can find this from the summary file created by featureCounts)
 5. Copy to sorted BAM file together with the index out of the docker container to your own environment. Open the BAM file in IGV. Zoom into the PFKL gene on chromosome 21. You should be able to see individual reads mapping to the exons of the gene. Now move to the neighbouring AIRE gene. Make IGV screenshots for both genes and include them to your report.
 6. Find the number of paired-end fragments overlapping the the PFKL and AIRE genes from the featureCounts file. Do these match to what you observed in IGV? 

<!--stackedit_data:
eyJoaXN0b3J5IjpbMTg2ODk4NzgzNV19
-->