Channel.fromPath(params.studyFile)
    .ifEmpty { error "Cannot find study file: ${params.studyFile}" }
    .splitCsv(header: true, sep: '\t', strip: true)
    .map{row -> [ row.study, file(row.fastq1), file(row.fastq2) ]}
    .set { fastq_ch }

Channel
    .fromPath( "${params.hisat2_index}*" )
    .ifEmpty { exit 1, "HISAT2 index files not found: ${params.hisat2_index}" }
    .set { hisat2_index_ch }

include { hisat2Align } from './modules/hisat2'

workflow {
    hisat2Align(fastq_ch, hisat2_index_ch.collect())
}
