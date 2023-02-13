#!/bin/bash

#SBATCH --time=2:00:00
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=4G
#SBATCH --job-name="nf-hisat2"
#SBATCH --partition=testing

# Load needed system tools (Java 8 is required, one of singularity or anaconda - python 2.7 is needed,
# depending on the method for dependancy management). The exact names of tool modules might depend on HPC.
module load any/jdk/1.8.0_265
module load any/singularity/3.7.3
module load squashfs/4.4
module load nextflow

nextflow main.nf -resume\
    --input study_file.txt\
    --ref_genome annotations/Homo_sapiens.GRCh38.dna.chromosome.21.fa