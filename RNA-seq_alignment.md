# RNA-seq alignment
This tutorial describes how to align RNA sequencing data to the reference genome. To make the process faster, we will perform all of the analyses on human chromosome 21, but all of steps will remain the same when you perform the analysis at the level of the full genome.

## Useful tutorials

 - [NBIS RNA-seq tutorial](https://scilifelab.github.io/courses/rnaseq/labs/)
 - [HISAT2 documentation](https://ccb.jhu.edu/software/hisat2/manual.shtml)

## Example workflow
### Downloading the reference genome
You can find the human reference genome from the Ensembl [website](https://www.ensembl.org). Go to Downloads -> Download databases and software and then follow the links to Human - DNA (FASTA).

Let's download the sequence for chromosme 21:

	mkdir annotations
	cd annotations
	wget ftp://ftp.ensembl.org/pub/release-91/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.chromosome.21.fa.gz
	gunzip Homo_sapiens.GRCh38.dna.chromosome.21.fa.gz
	cd ..

### Build the HISAT2 index
First you need to get the HISAT2 software. If you are using the [University of Tartu High Performance Computing Center](https://hpc.ut.ee/en/home/), then HISAT2 is already installed for you and you can add it to your path using the modules system. Click [here](https://hpc.ut.ee/en/guides/using-modules/) to read more about modules.

    module load hisat-2.0.4

**Remember that you should NEVER run any code on the head node of the HPC**. You should use the SLURM queue system instead. Before proceeding to the next steps, you should first familiarise yourself with the SLURM system and how to submit jobs using the documentation found [here](https://hpc.ut.ee/en/slurm/).

We can now use the FASTA file that we downloaded above to build an index of the reference genome.

	mkdir hisat2_index
	hisat2-build annotations/Homo_sapiens.GRCh38.dna.chromosome.21.fa hisat2_index/hisat2_index

### Download RNA-seq reads
I have uploaded some RNA-seq data to this [Zenodo](https://zenodo.org/record/1173306) repository. Let's download both pairs of a single paired-end RNA-seq sample (fikt_A). These fastq files only contain reads from chromosome 21.

	mkdir data
	cd data
	wget https://zenodo.org/record/1173306/files/fikt_A.1.fastq.gz
	wget https://zenodo.org/record/1173306/files/fikt_A.2.fastq.gz
	cd ..
	
### Viewing and counting lines in the fastq files
We can use zless to view the contents of compressed text files.
	
	zless data/fikt_A.1.fastq.gz
**Tip**: To exit less, press Q.

We can also count the number of lines in each file using a combination of zcat and wc:

	zcat data/fikt_A.1.fastq.gz | wc -l

### Align with HISAT2
Now, let's align all of the reads in these two files to the reference genome using HISAT2. We will need the supply index that we created beforehand with the `-x` option and both read pairs with `-1` and `-2` options.

By default, HISAT2 outputs results as uncompressed SAM to the standard output. Since these files can be very large, it makes sense to convert them directly into binary compressed BAM format using samtools. See [wikipedia](https://en.wikipedia.org/wiki/SAMtools) and [SAM format specification](https://samtools.github.io/hts-specs/SAMv1.pdf) for more detail.

First add samtools to your path:

    module load samtools-1.9

Then align with HISAT2:

	mkdir results
	hisat2 -x hisat2_index/hisat2_index -1 data/fikt_A.1.fastq.gz -2 data/fikt_A.2.fastq.gz | samtools view -Sb > results/fikt_A.bam

### Sort and index the BAM file
Next, we can sort the BAM file according to the position of each read in the reference genome and create a binary index to allow fast random access to the file.

	samtools sort -o results/fikt_A.sortedByCoords.bam results/fikt_A.bam
	samtools index results/fikt_A.sortedByCoords.bam
	
	
### Downloading transcript annotations
Ultimately, we want to know what is the relative expression of each gene in the genome. To do this, we need download transcript annotations in the Gene Transfer Format (GTF). 

> Annotations in the GTF format are similar to the transcript annotations that you saw in IGV. In fact, you can open and view GTF files with IGV.

From the Ensembl website we need to download the gene annotations in GTF format:
	
	cd annotations
	wget ftp://ftp.ensembl.org/pub/release-91/gtf/homo_sapiens/Homo_sapiens.GRCh38.91.gtf.gz
	cd ..

Now, let's uncompress them and extract only those genes that are on chromosome 21:

	gunzip annotations/Homo_sapiens.GRCh38.91.gtf.gz
	grep ^21 annotations/Homo_sapiens.GRCh38.91.gtf > annotations/Homo_sapiens.GRCh38.91.chr21.gtf

### Counting the number of reads overlapping gene annotations 
We can now proceed with read counting with featureCounts
	
	featureCounts -p -C -D 5000 -d 50 -s2 -a annotations/Homo_sapiens.GRCh38.91.chr21.gtf -o results/fikt_A.counts results/fikt_A.sortedByCoords.bam
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE0NTk3MTE0MTUsLTUxOTM5MjE2MCw1OT
Q0NjUyNSwtMTkwNDg1NzIwMCw2NzY4NTg1NTNdfQ==
-->