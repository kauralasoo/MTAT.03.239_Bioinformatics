# Assignment 2
## Task 1: Burrows-Wheeler Transform (BWT) (2 point)
**Learning objective:** Learn how Burrows-Wheeler Transform and FM-index work and how they can be used to perform sequence matching and alignment extremely fast.

Given the Borrows-Wheeler transformed string 'ACTCA$TA'.  
1. Construct the FM index  
2. Show how many times the pattern 'CA' occurs in original string using the FM index and LF(i) (Last-to-First) function
3. Does the pattern 'CATTA' appear in original string?

**Additional reading**
 - An entertaining video explaining how Burrows-Wheeler Transform works: [link](https://www.youtube.com/watch?v=4WRANhDiSHM).
 - Explantation of the FM index from Ben Langmead: [link](https://www.youtube.com/watch?v=kvVGj5V65io&t=1195s)

## Task 3: Using the High Performance Computing Center (1 point)
**Learning objective:** The aim of this task is to learn how to use the [University of Tartu High Performance Computing (HPC) Center](https://hpc.ut.ee/en/home/) to run computational tasks. The main thing to remember is to **NEVER** run any computations on the head node of the HPC. You can use the head node to download and move files, but you should always use the [SLURM](https://hpc.ut.ee/en/slurm/) system when you want to run computations.

 1. If you have never used the HPC before, go through the [introductory slides](https://docs.google.com/presentation/d/1XhA4YnnZ-Gzuyo-_PghMcu_X-fXe_EUhiW2bHoABwgI/edit#slide=id.g3308ddf0d8_2_160) to learn what it's all about. 
 2. Log into the head node of the rocket cluster using ssh. If you are using Mac or Linux, you can do it straight from the command line: `ssh <your_user_name>@rocket.hpc.ut.ee.` On Windows you might need to install [Putty](https://www.putty.org/). More instructions are available [here](https://hpc.ut.ee/en/using-ssh/). 
 3. Submit your first jobs to the cluster by following the [SLURM](https://hpc.ut.ee/en/slurm/) tutorial and look at it's output.
 4. Learn how to transfer files between your computer and the HPC system. On Mac I prefer to use the [Cyberduck](https://cyberduck.io/) sftp client and it might work on Windows as well. Another option is [FileZilla](https://filezilla-project.org/), which should also work on all three platforms. 
 5. Demonstrate the you have managed to successfully execute your first job by copying the contents of the SLURM output file into your report.

## Task 4: RNA-seq alignment (2 points)
**Learning objective:** You will learn how RNA sequencing is used to measure gene expression and what computational steps are needed to do that. First, you will understand what the raw RNA sequencing reads (in FASTQ format) look like and how you can use alignment software (HISAT2) to find the locations in the reference genome where these reads come from. Counting the number of reads overlapping gene annotations will also show you how gene expression is measured using RNA-seq. 

Using the [RNA-seq alignment tutorial](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/blob/master/RNA-seq_alignment.md), answer the following questions:

 1. How many reads are there in the fikt_A.1.fastq.gz and fikt_A.2.fastq.gz FASTQ files?
 2. Following the instructions, align the FASTQ files to the reference genome. Sort the alignments by position and create the index.
 3. What fraction of the reads mapped to the reference genome? (HINT: use samtools flagstat).
 4. What fraction of the paired-end fragments were assigned to genes? (HINT: You can find this from the summary file created by featureCounts)
 5. Copy to sorted BAM file together with the index from the HPC to your own environment (See Task 2). Open the BAM file in IGV. Zoom into the PFKL gene on chromosome 21. You should be able to see individual reads mapping to the exons of the gene. Now move to the neighbouring AIRE gene. What do you see? Make IGV screenshots for both genes and include them into your report.
 6. Find the number of paired-end fragments overlapping the PFKL and AIRE genes from the featureCounts file (last column). Do these broadly match what you observed in the IGV? (No need to count fragments manually from IGV) (HINT: You can use the search box on the [Ensembl website](http://www.ensembl.org/) to find the gene ids for both gens).
 7. Repeat the same processing steps on all of the four samples (fikt_A, fikt_C, eipl_A, eipl_C) found in [Zenodo](https://zenodo.org/record/1173306).  Report the paired-end fragment counts for PFKL and AIRE genes in all four samples.
