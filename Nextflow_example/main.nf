ref_genome_ch = Channel.fromPath( "${params.ref_genome}" )

fastq_ch = Channel.fromPath(params.input)
    .splitCsv(header: true, sep: ',', strip: true)
    .map{row -> [ row.study, file(row.fastq1), file(row.fastq2) ]}

include { build_hisat2_index; hisat2_align } from './modules/hisat2'

workflow {
    build_hisat2_index(ref_genome_ch)
    hisat2_align(fastq_ch, build_hisat2_index.out.collect())
}
