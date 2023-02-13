#!/bin/bash

#SBATCH --time=2:00:00
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=4G
#SBATCH --job-name="nf-featureCounts"
#SBATCH --partition=testing

# Load needed system tools (Java 8 is required, one of singularity or anaconda - python 2.7 is needed,
# depending on the method for dependancy management). The exact names of tool modules might depend on HPC.
module load any/singularity/3.7.3
module load squashfs/4.4

singularity build hisat2.img docker://quay.io/eqtlcatalogue/rnaseq_hisat2:v22.03.01
