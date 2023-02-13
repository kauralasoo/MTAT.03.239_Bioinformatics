### Use Singularity containers to run tools manually on the HPC

```bash
#Load required modules
module load any/singularity/3.7.3
module load squashfs/4.4

#Build HISAT2 container
singularity build hisat2.img docker://quay.io/eqtlcatalogue/rnaseq_hisat2:v22.03.01

#Or run the command via sbatch
sbatch build_hisat2_container.sh

#Run HISAT2 via singularity
singularity exec hisat2.img hisat2 --version

#Build HISAT2 index
singularity exec hisat2.img hisat2-build annotations/Homo_sapiens.GRCh38.dna.chromosome.21.fa hisat2_index/hisat2_index

#Build featureCounts container
singularity build featureCounts.img docker://quay.io/eqtlcatalogue/rnaseq:v20.11.1

#Or run it directly via sbatch
sbatch build_featureCounts_container.sh
```

### Run the same commands via a Nextflow workflow

This is what the sbatch file looks like

```bash
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
    --input study_file.csv\
    --ref_genome annotations/Homo_sapiens.GRCh38.dna.chromosome.21.fa
```

And this is how you can run it
```bash
 sbatch run_nextflow.sh
```
