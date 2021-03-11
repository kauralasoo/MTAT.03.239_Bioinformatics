## Bonus task 1: Implement RNA-seq quantification workflow in Nextflow (3 points)

In Assignment 2, Task 3 you had to quantify gene expression from four RNA-seq samples (fikt_A, fikt_C, eipl_A, eipl_C). This involved aligning reads to the reference genome with HISAT2 and counting the number of reads overlapping gene annotations using featureCounts. This a very typical scenario in Bioinformatics workflows, where you need to apply to multiple sequential data analysis steps to number of biological samples. Multiple workflow languages and managers have been developed to simlify the execution of such workflows (eg [Nextflow](https://www.nextflow.io/) and [Snakemake](https://snakemake.readthedocs.io/en/v5.10.0/)).

In this task, you goal is to implement the read alignemnt (HISAT2) and counting (featureCounts) steps as a Nextflow workflow and execute that workflow on the University of Tartu HPC. You can assume that the HISAT2 index has already been generated. Optionally, you can also merge the featureCounts output from all four samples into one file. You should be able to run the workflow an arbitrary number of samples (i.e. you should not hard code the sample names into the workflow).

For assistance, see this [tutorial](https://github.com/AlasooLab/onboarding/blob/main/resources/nextflow.md) on how to execute nextflow workflows on the HPC. You can also use the minimal Nextflow [example](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/tree/master/Nextflow_example) that uses HISAT2 to perform read alignment. 


