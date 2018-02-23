# Snakemake tutorial
Snakemake has an excellent online [tutorial](https://snakemake.readthedocs.io/en/stable/tutorial/tutorial.html) on how the get started. You should be able to find answers to most of your questions from that tutorial, although, I admit, it can be quite difficult due to the large amount if information in there. There is also a shorter summary in the form of [slides](http://slides.com/johanneskoester/snakemake-tutorial-2016#/). Thus, to make it easier for you, I have but a couple of basic examples here as well.

## Multiple input files in a rule
Couple of you have asked me, how to construct Snakemake rules with multiple input files, as is required for the HISAT2 command in the [RNA-seq tutorial](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/blob/master/RNA-seq_alignment.md)):
	
	hisat2 -x annotations/hisat2_index/hisat2_index -1 data/fikt_A.1.fastq.gz -2 data/fikt_A.2.fastq.gz | samtools view -Sb > results/fikt_A.bam

One option is to specify names for input or output files:

	rule align_reads:
		intput:
			fastq1 = data/{sample}.1.fastq.gz,
			fastq2 = data/{sample}.2.fastq.gz
		output:
			bam = results/{sample}.bam
		shell:
			"hisat2 -x annotations/hisat2_index/hisat2_index -1 {input.fastq1} -2 {input.fastq2} | samtools view -Sb > {outbut.bam}"

Alternatively, you can use index to access multiple individual input or output files separately:



We can now execute this rule by running:

	snakemake -p results/fikt_A.bam


However, this rule is not very useful, because it will only work on a single sample. To make the rule more general, we can replace the sample name with a wildcard:


Now we can use the same rule to also process a different sample:

	snakemake -p results/fikt_C.bam

Instead of named input parameters, you can al


	
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE4OTA3MDUyNTZdfQ==
-->