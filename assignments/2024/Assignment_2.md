# Assignment 2

## Task 1: Using the High Performance Computing Center (1 point)
**Learning objective:** The aim of this task is to learn how to use the [University of Tartu High Performance Computing (HPC) Center](https://hpc.ut.ee/) to run computational tasks. The main thing to remember is to **NEVER** run any computations on the head node of the HPC. You can use the head node to download and move files, but you should always use the [SLURM](https://docs.hpc.ut.ee/public/cluster/quickstart/) system when you want to run computations.

 1. If you have never used the HPC before, go through the [introductory slides](https://docs.google.com/presentation/d/1XhA4YnnZ-Gzuyo-_PghMcu_X-fXe_EUhiW2bHoABwgI/edit#slide=id.g3308ddf0d8_2_160) to learn what it's all about. 
 2. Log into the head node of the rocket cluster using ssh. If you are using Mac or Linux, you can do it straight from the command line: `ssh <your_user_name>@rocket.hpc.ut.ee.` On Windows you might need to install [Putty](https://www.putty.org/). More instructions are available [here](https://docs.hpc.ut.ee/public/ssh/). 
 3. Submit your first jobs to the cluster by following the [SLURM submit job](https://docs.hpc.ut.ee/public/cluster/monitoring_and_managing_jobs/submit_jobs/) tutorial and look at it's output.
 4. Learn how to transfer files between your computer and the HPC system. On Mac I prefer to use the [Cyberduck](https://cyberduck.io/) sftp client and it might work on Windows as well. Another option is [FileZilla](https://filezilla-project.org/) or MobaXterm (https://mobaxterm.mobatek.net/), which should also work on all three platforms. You need to use port 22. If you prefer command line over Graphical User Interfaces please check out the [scp usage](https://docs.hpc.ut.ee/public/cluster/quickstart/#copy-data).
 5. Demonstrate the you have managed to successfully execute your first job by copying the contents of the SLURM output file into your report.

## Task 2: Adding a new process to a Nextflow workflow (3 points)
The aim of this task is to practice the writing and modifiyng of Nextflow workflows. You can start from the small [example workflow](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/tree/master/Nextflow_example) that we developed in the lecture. Your task is to modify the workflow to run the featureCounts tool on all of the bam files produced by the hisat2_align process. For this, you need to do the following three steps:
1. Wite a new process definition that takes the *.bam files from the hisat2_align process and the gene annotation file (GTF) as input and produces read count files as output. You can find an example featureCounts command from this [RNA-seq tutorial](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/blob/master/RNA-seq_alignment.md). 

The featureCounts command will look something like this:
```bash
featureCounts -p -C -D 5000 -d 50 -s2 -a annotations/Homo_sapiens.GRCh38.91.chr21.gtf -o results/fikt_A.counts results/fikt_A.sortedByCoords.bam
```
 You can manually download the GTF file and extract chromosome 21 following the RNA-seq [RNA-seq tutorial](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/blob/master/RNA-seq_alignment.md). Only the featureCounts step needs to be part of the workflow.

The software container for the featureCounts tool can be found here:
```bash
docker://quay.io/eqtlcatalogue/rnaseq:v20.11.1
```

2. You need to define a new input channel for the gene annotation file in the main workflow file (main.nf).

3. You need to inclde to new process into the workflow and correctly define its inputs and outputs.



