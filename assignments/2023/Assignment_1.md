# Assignment 1

## Task 1: Using the High Performance Computing Center (1 point)
**Learning objective:** The aim of this task is to learn how to use the [University of Tartu High Performance Computing (HPC) Center](https://hpc.ut.ee/en/home/) to run computational tasks. The main thing to remember is to **NEVER** run any computations on the head node of the HPC. You can use the head node to download and move files, but you should always use the [SLURM](https://docs.hpc.ut.ee/cluster/quickstart/) system when you want to run computations.

 1. If you have never used the HPC before, go through the [introductory slides](https://docs.google.com/presentation/d/1XhA4YnnZ-Gzuyo-_PghMcu_X-fXe_EUhiW2bHoABwgI/edit#slide=id.g3308ddf0d8_2_160) to learn what it's all about. 
 2. Log into the head node of the rocket cluster using ssh. If you are using Mac or Linux, you can do it straight from the command line: `ssh <your_user_name>@rocket.hpc.ut.ee.` On Windows you might need to install [Putty](https://www.putty.org/). More instructions are available [here](https://hpc.ut.ee/en/using-ssh/). 
 3. Submit your first jobs to the cluster by following the [SLURM submit job](https://docs.hpc.ut.ee/cluster/monitoring_and_managing_jobs/submit_jobs/) tutorial and look at it's output.
 4. Learn how to transfer files between your computer and the HPC system. On Mac I prefer to use the [Cyberduck](https://cyberduck.io/) sftp client and it might work on Windows as well. Another option is [FileZilla](https://filezilla-project.org/), which should also work on all three platforms. If you prefer command line over Graphical User Interfaces please check out the [scp usage](https://docs.hpc.ut.ee/cluster/quickstart/#copy-data).
 5. Demonstrate the you have managed to successfully execute your first job by copying the contents of the SLURM output file into your report.

## Task 2: Adding a new process to a Nextflow workflow
The aim of this task is to practice the writing and modifiyng Nextflow workflow. You can start from the small [example workflow](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/tree/master/Nextflow_example) that we developed in the lecture. Your task is to modify the workflow to run the featureCounts tool on all of the bam files produced by the hisat2_align process. For this, you need to write a definition for the new process and then modify the workflow definition so that the output from the hisat2_align process will be used by the new featureCounts process.

The software container for the featureCounts tool can be found here:
```bash
docker://quay.io/eqtlcatalogue/rnaseq:v20.11.1
```

And you can find an example featureCounts command from this [RNA-seq tutorial](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/blob/master/RNA-seq_alignment.md).

featureCounts also needs a chromosome 21 GTF file (gene annotation file) as an imput. You can manually download the GTF file and extract chromosome 21 following the RNA-seq [RNA-seq tutorial](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/blob/master/RNA-seq_alignment.md). Only the featureCounts step needs to be part of the workflow.


