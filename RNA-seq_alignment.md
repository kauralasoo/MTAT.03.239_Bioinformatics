# RNA-seq alignment
This tutorial describes how to align RNA sequencing data to the reference genome. To make the process faster, we will perform all of the analyses on human chromosome 21, but all of steps will remain the same when you perform the analysis at the level of the full genome.

## Useful tutorials

 - [NBIS RNA-seq tutorial](https://scilifelab.github.io/courses/rnaseq/labs/)

## Downloading the reference genome
You can find the human reference genome from the Ensembl [website](https://www.ensembl.org). Go to Downloads -> Download databases and software and then follow the links to Human - DNA (FASTA).

Let's download the sequence for chromosme 21:

	mkdir annotations
	cd annotations
	wget ftp://ftp.ensembl.org/pub/release-91/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.chromosome.21.fa.gz
	gunzip Homo_sapiens.GRCh38.dna.chromosome.21.fa.gz

From the website we also need to download the gene annotations if GFF3 format:
	
	 wget ftp://ftp.ensembl.org/pub/release-91/gff3/homo_sapiens/Homo_sapiens.GRCh38.91.chromosome.21.gff3.gz
	 gunzip Homo_sapiens.GRCh38.91.chromosome.21.gff3.gz
	 cd ..

### Build the HISAT2 index
We can now use the FASTA and GFF3 files to build an index of the reference genome:

	mkdir hisat2_index
	hisat2-build Homo_sapiens.GRCh38.dna.chromosome.21.fa hisat2_index/hisat2_index

### Download RNA-seq reads

	mkdir data
	cd data
	wget https://www.dropbox.com/s/tx711uumrareh2j/fikt_A.1.fastq.gz
	wget https://www.dropbox.com/s/u6zzkypm3uzte4s/fikt_A.2.fastq.gz
	cd ..

### Align with HISAT2

	hisat2 -x annotations/hisat2_index/hisat2_index -1 data/fikt_A.1.fastq.gz -2 data/fikt_A.2.fastq.gz | samtools view -Sb > results/fikt_A.bam

### Sort and index the BAM file

	samtools sort -o results/fikt_A.sortedByCoords.bam results/fikt_A.bam
	samtools index results/fikt_A.sortedByCoords.bam
	
	
### Counting reads overlapping gene annotations

<!--stackedit_data:
eyJoaXN0b3J5IjpbMTI4NjQ1OTM4NF19
-->