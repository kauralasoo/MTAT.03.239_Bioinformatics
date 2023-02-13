Channel.fromPath( "${params.ref_genome}" )
    .ifEmpty { exit 1, "Reference genome not found: ${params.ref_genome}" }
    .set { ref_genome_ch }

Channel.fromPath(params.input)
    .ifEmpty { error "Cannot find study file: ${params.input}" }
    .splitCsv(header: true, sep: ',', strip: true)
    .map{row -> [ row.study, file(row.fastq1), file(row.fastq2) ]}
    .set { fastq_ch }

include { build_hisat2_index } from './modules/hisat2'
include { hisat2_align } from './modules/hisat2'

workflow {
    build_hisat2_index(ref_genome_ch)
    hisat2_align(fastq_ch, build_hisat2_index.out.collect())
}
