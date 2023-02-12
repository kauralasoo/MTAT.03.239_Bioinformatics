process hisat2Align{
    container = 'quay.io/eqtlcatalogue/rnaseq_hisat2:v22.03.01'

    input:
    set sample_name, file(fastq1), file(fastq2)
    file hisat2_indices

    output:
    set sample_name, file("${sample_name}.bam")

    script:
    index_base = hisat2_indices[0].toString() - ~/.\d.ht2/
    """
    hisat2 -x $index_base -1 ${fastq1} -2 ${fastq2} | samtools view -Sb > ${sample_name}.bam
    """
}