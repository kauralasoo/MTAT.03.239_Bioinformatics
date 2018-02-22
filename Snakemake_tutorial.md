# Snakemake tutorial
Snakemake has an excellent online [tutorial](https://snakemake.readthedocs.io/en/stable/tutorial/tutorial.html) on how the get started. You should be able to find answers to most of your questions from that tutorial, although, I admit, it can be quite difficult due to the large amount if information in there. There is also a shorter summary in the form of [slides](http://slides.com/johanneskoester/snakemake-tutorial-2016#/). Thus, to make it easier for you, I have but a couple of basic examples here as well.

## First rule
To get  started, let's look at the HISAT2 command from the RNA-seq tutorial:
	
	hisat2 -x annotations/hisat2_index/hisat2_index -1 data/fikt_A.1.fastq.gz -2 data/fikt_A.2.fastq.gz | samtools view -Sb > results/fikt_A.bam

We can easiliy convert it into a Snakemake rule:

	rule align_reads:
		intput:
			fastq1 = data/fikt_A.1.fastq.gz,
			fastq2 = data/fikt_A.2.fastq.gz
		output:
			bam = results/fikt_A.bam
		shell:
			"hisat2 -x annotations/hisat2_index/hisat2_index -1 {input.fastq1} -2 {input.fastq2} | samtools view -Sb > {outbut.bam}"
	
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTIxMTc3MzAyMTVdfQ==
-->