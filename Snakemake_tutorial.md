# Snakemake tutorial
Snakemake has an excellent online [tutorial](https://snakemake.readthedocs.io/en/stable/tutorial/tutorial.html) on how the get started. You should be able to find answers to most of your questions from that tutorial, although, I admit, it can be quite difficult due to the large amount if information in there. There is also a shorter summary in the form of [slides](http://slides.com/johanneskoester/snakemake-tutorial-2016#/). To make your life a little bit easier, I have also but a couple of basic examples here as well.

## Multiple input files in a rule
Couple of you have asked me, how to construct Snakemake rules with multiple input files, as is required for the HISAT2 command in the [RNA-seq tutorial](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/blob/master/RNA-seq_alignment.md)):
	
	hisat2 -x annotations/hisat2_index/hisat2_index -1 data/fikt_A.1.fastq.gz -2 data/fikt_A.2.fastq.gz | samtools view -Sb > results/fikt_A.bam

One option is to specify names for input or output files:

	rule align_reads:
		input:
			fastq1 = "data/{sample}.1.fastq.gz",
			fastq2 = "data/{sample}.2.fastq.gz"
		output:
			bam = "results/{sample}.bam"
		shell:
			"hisat2 -x annotations/hisat2_index/hisat2_index -1 {input.fastq1} -2 {input.fastq2} | samtools view -Sb > {output.bam}"

Alternatively, you can access individual input or output files separately by their index:

	rule align_reads:
		input:
			"data/{sample}.1.fastq.gz",
			"data/{sample}.2.fastq.gz"
		output:
			"results/{sample}.bam"
		shell:
			"hisat2 -x annotations/hisat2_index/hisat2_index -1 {input[0]} -2 {input[1]} | samtools view -Sb > {output}"

I prefer (and recommend) to use names, because I find that it makes it easier to read to rules.

## Executing rules on multiple samples
The simplest option is to specify the list of samples at the top of your Snakemake file and then write one 'meta rule' that collects the results from all of the samples. This would look something like this:
	
	#Specify the list of samples
	SAMPLES = ['eipl_A', 'eipl_C', 'fikt_A', 'fikt_C']
	
	#Rule that performs the alignments
	rule align_reads:
		input:
			fastq1 = "data/{sample}.1.fastq.gz",
			fastq2 = "data/{sample}.2.fastq.gz"
		output:
			bam = "results/{sample}.bam"
		shell:
			"hisat2 -x annotations/hisat2_index/hisat2_index -1 {input.fastq1} -2 {input.fastq2} | samtools view -Sb > {output.bam}"
	
	#One meta rule whose input files are all 
	#of the desired output files
	rule make_all:
		input:
			expand("results/{sample}.bam", sample=SAMPLES)
		output:
			"out.txt"
		shell:
			"echo 'Done!' > {output}"

You can now execute this Snakefile using the following command:

	snakemake -p out.txt

## Using configuration files
Instead of specifying the list of sample names in the Snakefile, you can also put them into a configuration file. This helps to separate workflow logic (which tools to run and in which order) from dataset specific parameters (list of samples, etc.). 

First let's create a configuration file called `config.yaml` with the following content:
samples: ['eipl_A', 'eipl_C', 'fikt_A', 'fikt_C']



<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE0OTczNDQ4MDYsLTEyMjkwNzIyOTNdfQ
==
-->