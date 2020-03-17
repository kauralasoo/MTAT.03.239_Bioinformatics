### Open interactive slurm session

(You can also do this inside a screen session)
srun --pty bash

### Run nextflow

nextflow main.nf --studyFile study_file.txt\
    --hisat2_index hisat2_index/hisat2_index\
    --gtf_file annotations/Homo_sapiens.GRCh38.91.chr21.gtf