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

	samples: [eipl_A, eipl_C, fikt_A, fikt_C]

Next, you need to modify the Snakefile so that it would now take the sample list from the configuration file:
	
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
			expand("results/{sample}.bam", sample=config["samples"])
		output:
			"out.txt"
		shell:
			"echo 'Done!' > {output}"

Finally, you need to specify the configuration file when running Snakemake:

	snakemake -p out.txt --configfile config.yaml

## Using Snakemake to submit jobs on the HPC
To submit jobs to the HPC, you need to specify the maximum amount of memory that your job requires as well as the number CPU cores. Fortunately, you specify those easily for each Snakemake rule. You just need to add the `threads` and `resources` directives. You can read more about these options in the [Snakemake documentation](http://snakemake.readthedocs.io/en/stable/tutorial/advanced.html).

HPC at the University of Tartu has a lot of software installed using the modules system and you can add them to your path using the `module load` command. For example, to add HISAT2 to your path, you can run  `module load hisat-2.0.4`. More information is available [here](https://hpc.ut.ee/en_US/web/guest/using-modules).

	#Rule that performs the alignments
	rule align_reads:
		input:
			fastq1 = "data/{sample}.1.fastq.gz",
			fastq2 = "data/{sample}.2.fastq.gz"
		output:
			bam = "results/{sample}.bam"
		resources:
			mem = 8000
		threads: 1
		shell:
			"""
			module load hisat-2.0.4
			hisat2 -p {threads} -x annotations/hisat2_index/hisat2_index -1 {input.fastq1} -2 {input.fastq2} | samtools view -Sb > {output.bam}
			"""
Next, you need to tell Snakemake how to submit SLURM jobs. I have written a short [Python script](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/blob/master/Snakemake_example/snakemake_submit_UT.py) for that and you should be able to use if without modifications.

We are now almost ready to run Snakemake on the HPC, but first we need to make a directory named **SlurmOut** for the SLURM log files. This directory has to exist, because otherwise Snakemake is not able to write SLURM output files to disk.
	
	mkdir SlurmOut
And then run Snakemake:

	module load python-3.6.0 #Snakemake is installed under Python 3.6
	snakemake --cluster ./snakemake_submit_UT.py -p out.txt --configfile config.yaml --jobs 20

The `--jobs` option tells Snakemake how many parallel SLURM jobs to run at any one time. **If your jobs involve reading large input files form the disk, you should probably limit the number of concurrent jobs to something relatively small (eg 10-20).**

Remember to **always run Snakemake with the `--cluster` option** when you are using it on the HPC, because otherwise it will run all of the computations on the head node (and you will very quickly get a very angry email from someone). 

Finally, to make sure that your Snakemake process is not killed when you log out of the head node, I usually run it within a `screen` session. [Click here](https://www.tecmint.com/screen-command-examples-to-manage-linux-terminals/) to learn how to use `screen`. 

All of the example files to run Snakemake on the HPC are here:
https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/tree/master/Snakemake_example
<!--stackedit_data:
eyJoaXN0b3J5IjpbNTQ1Mjc5NDI2XX0=
-->