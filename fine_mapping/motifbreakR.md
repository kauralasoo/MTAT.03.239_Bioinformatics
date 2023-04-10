---
title: "motifbreakR intro"
output: 
  html_document: 
    keep_md: yes
---




#Importing the required packages

```r
library("motifbreakR")
library("MotifDb")
library("BSgenome.Hsapiens.UCSC.hg38")
library("dplyr")
library("GenomicRanges")
library("tidyr")
```


# Import credible sets from the eQTL Catalogue

First, we need to download the eQTL fine mapping results from the Alasoo_2018 study from macrophages stimulated with interferon-gamma and Salmonella. 


```r
cs_table = readr::read_tsv("ftp://ftp.ebi.ac.uk/pub/databases/spot/eQTL/susie/QTS000001/QTD000016/QTD000016.credible_sets.tsv.gz")
```

```
## Rows: 43744 Columns: 13
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: "\t"
## chr (6): molecular_trait_id, gene_id, cs_id, variant, rsid, region
## dbl (7): cs_size, pip, pvalue, beta, se, z, cs_min_r2
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

# GP1BA
Next, let's extract the credible set for the GP1BA gene (ENSG00000185245):


```r
GP1BA_cs = dplyr::filter(cs_table, molecular_trait_id == "ENSG00000185245") %>%
  dplyr::select(-rsid) %>% dplyr::distinct() %>%
  tidyr::separate(variant, into = c("chromosome", "position", "ref", "alt"), sep = "\\_", remove = FALSE) %>%
  dplyr::mutate(chromosome = stringr::str_replace(chromosome,"chr", replacement = "")) %>%
  dplyr::mutate(position = as.integer(position))
GP1BA_cs
```

```
## # A tibble: 9 × 16
##   molecular_t…¹ gene_id cs_id variant chrom…² posit…³ ref   alt   cs_size    pip
##   <chr>         <chr>   <chr> <chr>   <chr>     <int> <chr> <chr>   <dbl>  <dbl>
## 1 ENSG00000185… ENSG00… ENSG… chr17_… 17      4922449 AAAAT A           9 0.104 
## 2 ENSG00000185… ENSG00… ENSG… chr17_… 17      4925554 C     G           9 0.121 
## 3 ENSG00000185… ENSG00… ENSG… chr17_… 17      4926692 A     G           9 0.112 
## 4 ENSG00000185… ENSG00… ENSG… chr17_… 17      4926809 G     A           9 0.112 
## 5 ENSG00000185… ENSG00… ENSG… chr17_… 17      4930090 T     C           9 0.113 
## 6 ENSG00000185… ENSG00… ENSG… chr17_… 17      4935854 C     T           9 0.117 
## 7 ENSG00000185… ENSG00… ENSG… chr17_… 17      4942473 G     A           9 0.146 
## 8 ENSG00000185… ENSG00… ENSG… chr17_… 17      4951185 C     T           9 0.0754
## 9 ENSG00000185… ENSG00… ENSG… chr17_… 17      4952343 A     AT          9 0.101 
## # … with 6 more variables: pvalue <dbl>, beta <dbl>, se <dbl>, z <dbl>,
## #   cs_min_r2 <dbl>, region <chr>, and abbreviated variable names
## #   ¹​molecular_trait_id, ²​chromosome, ³​position
```

We can see that this credible set consists of nine variants, two of which are indels (chr17_4922449_AAAAT_A and chr17_4952343_A_AT). Although motifbreakR package should in principle support indels, I could not get it to work right now, so we are going to exclude the indel for now. When performing real analysis, you should always consider indels as well, because they can often be the true causal variant. 


```r
GP1BA_cs_no_indel = GP1BA_cs %>%
  dplyr::mutate(max_allele_nchar = pmax(nchar(ref), nchar(alt))) %>%
  dplyr::filter(max_allele_nchar == 1)
GP1BA_cs_no_indel
```

```
## # A tibble: 7 × 17
##   molecular_t…¹ gene_id cs_id variant chrom…² posit…³ ref   alt   cs_size    pip
##   <chr>         <chr>   <chr> <chr>   <chr>     <int> <chr> <chr>   <dbl>  <dbl>
## 1 ENSG00000185… ENSG00… ENSG… chr17_… 17      4925554 C     G           9 0.121 
## 2 ENSG00000185… ENSG00… ENSG… chr17_… 17      4926692 A     G           9 0.112 
## 3 ENSG00000185… ENSG00… ENSG… chr17_… 17      4926809 G     A           9 0.112 
## 4 ENSG00000185… ENSG00… ENSG… chr17_… 17      4930090 T     C           9 0.113 
## 5 ENSG00000185… ENSG00… ENSG… chr17_… 17      4935854 C     T           9 0.117 
## 6 ENSG00000185… ENSG00… ENSG… chr17_… 17      4942473 G     A           9 0.146 
## 7 ENSG00000185… ENSG00… ENSG… chr17_… 17      4951185 C     T           9 0.0754
## # … with 7 more variables: pvalue <dbl>, beta <dbl>, se <dbl>, z <dbl>,
## #   cs_min_r2 <dbl>, region <chr>, max_allele_nchar <int>, and abbreviated
## #   variable names ¹​molecular_trait_id, ²​chromosome, ³​position
```

Next, we need format the credible set variant so that they will work with motifbreakR. This is a bit annoying as we need to first save the variants into a text file in BED format and then read them back into R. 

```r
GP1BA_snps = dplyr::transmute(GP1BA_cs_no_indel, 
                              V1 = paste0("chr",chromosome), 
                              V2 = position - 1, 
                              V3 = position, 
                              V4 = paste(paste0("chr",chromosome), position, ref, alt, sep = ":"), 
                              V5 = 0, 
                              V6 = "+")
write.table(GP1BA_snps, "snps_bed.tsv", sep = "\t", row.names = F, quote = F, col.names = F)
GP1BA_granges <- motifbreakR::snps.from.file(file = "snps_bed.tsv",
                                  search.genome = BSgenome.Hsapiens.UCSC.hg38,
                                  format = "bed")
GP1BA_granges
```

```
## GRanges object with 7 ranges and 3 metadata columns:
##                     seqnames    ranges strand |            SNP_id
##                        <Rle> <IRanges>  <Rle> |       <character>
##   chr17:4925554:C:G    chr17   4925554      * | chr17:4925554:C:G
##   chr17:4926692:A:G    chr17   4926692      * | chr17:4926692:A:G
##   chr17:4926809:G:A    chr17   4926809      * | chr17:4926809:G:A
##   chr17:4930090:T:C    chr17   4930090      * | chr17:4930090:T:C
##   chr17:4935854:C:T    chr17   4935854      * | chr17:4935854:C:T
##   chr17:4942473:G:A    chr17   4942473      * | chr17:4942473:G:A
##   chr17:4951185:C:T    chr17   4951185      * | chr17:4951185:C:T
##                                REF            ALT
##                     <DNAStringSet> <DNAStringSet>
##   chr17:4925554:C:G              C              G
##   chr17:4926692:A:G              A              G
##   chr17:4926809:G:A              G              A
##   chr17:4930090:T:C              T              C
##   chr17:4935854:C:T              C              T
##   chr17:4942473:G:A              G              A
##   chr17:4951185:C:T              C              T
##   -------
##   seqinfo: 1 sequence from hg38 genome
```

# Overlap with ATAC-seq data
Next, we can ask which of the seven credible set variants overlap with accessible chromatin regions in macrophage. To do this, we first need to import all of the accessible regions identified with ATAC-seq in the Alasoo_2018 study.


```r
peaks = rtracklayer::import.gff3("https://zenodo.org/record/1188300/files/ATAC_consensus_peaks.gff3.gz")
seqlevelsStyle(peaks) <- "UCSC" #This make chromosome names compatible with the motifbreakR object
peaks
```

```
## GRanges object with 296908 ranges and 5 metadata columns:
##            seqnames            ranges strand |      source     type     score
##               <Rle>         <IRanges>  <Rle> |    <factor> <factor> <numeric>
##        [1]     chr1        9979-10668      + | rtracklayer     exon        NA
##        [2]     chr1       10939-11473      + | rtracklayer     exon        NA
##        [3]     chr1       15505-15729      + | rtracklayer     exon        NA
##        [4]     chr1       21148-21481      + | rtracklayer     exon        NA
##        [5]     chr1       21864-22067      + | rtracklayer     exon        NA
##        ...      ...               ...    ... .         ...      ...       ...
##   [296904]     chrY 56838945-56839087      + | rtracklayer     exon        NA
##   [296905]     chrY 56842226-56842490      + | rtracklayer     exon        NA
##   [296906]     chrY 56847117-56847262      + | rtracklayer     exon        NA
##   [296907]     chrY 56850324-56850559      + | rtracklayer     exon        NA
##   [296908]     chrY 56850698-56851195      + | rtracklayer     exon        NA
##                phase          gene_id
##            <integer>      <character>
##        [1]      <NA>      ATAC_peak_1
##        [2]      <NA>      ATAC_peak_2
##        [3]      <NA>      ATAC_peak_3
##        [4]      <NA>      ATAC_peak_4
##        [5]      <NA>      ATAC_peak_5
##        ...       ...              ...
##   [296904]      <NA> ATAC_peak_296904
##   [296905]      <NA> ATAC_peak_296905
##   [296906]      <NA> ATAC_peak_296906
##   [296907]      <NA> ATAC_peak_296907
##   [296908]      <NA> ATAC_peak_296908
##   -------
##   seqinfo: 24 sequences from an unspecified genome; no seqlengths
```

Now we can find the variants the overlap open chromatin regions:

```r
olaps = GenomicRanges::findOverlaps(GP1BA_granges, peaks)
GP1BA_olaps = GP1BA_granges[queryHits(olaps)]
GP1BA_olaps
```

```
## GRanges object with 2 ranges and 3 metadata columns:
##                     seqnames    ranges strand |            SNP_id
##                        <Rle> <IRanges>  <Rle> |       <character>
##   chr17:4926692:A:G    chr17   4926692      * | chr17:4926692:A:G
##   chr17:4926809:G:A    chr17   4926809      * | chr17:4926809:G:A
##                                REF            ALT
##                     <DNAStringSet> <DNAStringSet>
##   chr17:4926692:A:G              A              G
##   chr17:4926809:G:A              G              A
##   -------
##   seqinfo: 1 sequence from hg38 genome
```

Finally, we can use motifbreakR together with the HOCOMOCO database to identify transcription factors whose motifs might be disrupted by these genetic variants:


```r
data("hocomoco")
results <- motifbreakR(snpList = GP1BA_olaps, filterp = TRUE,
                       pwmList = hocomoco,
                       threshold = 1e-4,
                       method = "ic",
                       bkg = c(A=0.25, C=0.25, G=0.25, T=0.25),
                       BPPARAM = BiocParallel::bpparam())
results_df = dplyr::as_tibble(as.data.frame(elementMetadata(results)))
results_df
```

```
## # A tibble: 8 × 23
##   SNP_id     REF   ALT   varType motif…¹ geneS…² dataS…³ provi…⁴ provi…⁵ seqMa…⁶
##   <chr>      <chr> <chr> <chr>   <list>  <chr>   <chr>   <chr>   <chr>   <chr>  
## 1 chr17:492… G     A     SNV     <dbl>   SP3     HOCOMO… SP3_f1  SP3_HU… "aacaa…
## 2 chr17:492… G     A     SNV     <dbl>   KLF4    HOCOMO… KLF4_f2 KLF4_H… "     …
## 3 chr17:492… G     A     SNV     <dbl>   SP1     HOCOMO… SP1_f2  SP1_HU… "aacaa…
## 4 chr17:492… G     A     SNV     <dbl>   MAZ     HOCOMO… MAZ_f1  MAZ_HU… "  caa…
## 5 chr17:492… G     A     SNV     <dbl>   IKZF1   HOCOMO… IKZF1_… IKZF1_… "     …
## 6 chr17:492… G     A     SNV     <dbl>   SP1     HOCOMO… SP1_f1  SP1_HU… "     …
## 7 chr17:492… G     A     SNV     <dbl>   KLF1    HOCOMO… KLF1_f1 KLF1_H… "     …
## 8 chr17:492… G     A     SNV     <dbl>   HIVEP2  HOCOMO… ZEP2_si ZEP2_H… "     …
## # … with 13 more variables: pctRef <dbl>, pctAlt <dbl>, scoreRef <dbl>,
## #   scoreAlt <dbl>, Refpvalue <lgl>, Altpvalue <lgl>, snpPos <int>,
## #   alleleRef <dbl>, alleleAlt <dbl>, effect <chr>, altPos <int>,
## #   alleleDiff <dbl>, alleleEffectSize <dbl>, and abbreviated variable names
## #   ¹​motifPos, ²​geneSymbol, ³​dataSource, ⁴​providerName, ⁵​providerId, ⁶​seqMatch
```

To identify more potential hits, we can reduce the p-value threshold to 1e-3:


```r
results <- motifbreakR(snpList = GP1BA_olaps, filterp = TRUE,
                       pwmList = hocomoco,
                       threshold = 1e-3,
                       method = "ic",
                       bkg = c(A=0.25, C=0.25, G=0.25, T=0.25),
                       BPPARAM = BiocParallel::bpparam())
results_df = dplyr::as_tibble(as.data.frame(elementMetadata(results)))
results_df
```

```
## # A tibble: 30 × 23
##    SNP_id    REF   ALT   varType motif…¹ geneS…² dataS…³ provi…⁴ provi…⁵ seqMa…⁶
##    <chr>     <chr> <chr> <chr>   <list>  <chr>   <chr>   <chr>   <chr>   <chr>  
##  1 chr17:49… A     G     SNV     <dbl>   FOXF1   HOCOMO… FOXF1_… FOXF1_… "     …
##  2 chr17:49… A     G     SNV     <dbl>   FOXF2   HOCOMO… FOXF2_… FOXF2_… "     …
##  3 chr17:49… A     G     SNV     <dbl>   FOXJ2   HOCOMO… FOXJ2_… FOXJ2_… "     …
##  4 chr17:49… A     G     SNV     <dbl>   HIVEP2  HOCOMO… ZEP2_si ZEP2_H… "  gga…
##  5 chr17:49… A     G     SNV     <dbl>   NFATC2  HOCOMO… NFAC2_… NFAC2_… "     …
##  6 chr17:49… A     G     SNV     <dbl>   NFATC4  HOCOMO… NFAC4_… NFAC4_… "     …
##  7 chr17:49… A     G     SNV     <dbl>   ZBTB4   HOCOMO… ZBTB4_… ZBTB4_… "gggga…
##  8 chr17:49… G     A     SNV     <dbl>   HIVEP2  HOCOMO… ZEP2_si ZEP2_H… "     …
##  9 chr17:49… G     A     SNV     <dbl>   IKZF1   HOCOMO… IKZF1_… IKZF1_… "     …
## 10 chr17:49… G     A     SNV     <dbl>   KLF1    HOCOMO… KLF1_f1 KLF1_H… "     …
## # … with 20 more rows, 13 more variables: pctRef <dbl>, pctAlt <dbl>,
## #   scoreRef <dbl>, scoreAlt <dbl>, Refpvalue <lgl>, Altpvalue <lgl>,
## #   snpPos <int>, alleleRef <dbl>, alleleAlt <dbl>, effect <chr>, altPos <int>,
## #   alleleDiff <dbl>, alleleEffectSize <dbl>, and abbreviated variable names
## #   ¹​motifPos, ²​geneSymbol, ³​dataSource, ⁴​providerName, ⁵​providerId, ⁶​seqMatch
```
The NFKB transcription factor consists of multiple sub-units. In this case, we can look for both NFKB1 and RELA:


```r
nfkb_results = results[results$geneSymbol %in% c("NFKB1", "RELA"),]
nfkb_results
```

```
## GRanges object with 2 ranges and 23 metadata columns:
##                     seqnames    ranges strand |            SNP_id
##                        <Rle> <IRanges>  <Rle> |       <character>
##   chr17:4926809:G:A    chr17   4926809      + | chr17:4926809:G:A
##   chr17:4926809:G:A    chr17   4926809      - | chr17:4926809:G:A
##                                REF            ALT     varType motifPos
##                     <DNAStringSet> <DNAStringSet> <character>   <list>
##   chr17:4926809:G:A              G              A         SNV    -2, 8
##   chr17:4926809:G:A              G              A         SNV    -2, 8
##                      geneSymbol  dataSource providerName  providerId
##                     <character> <character>  <character> <character>
##   chr17:4926809:G:A       NFKB1    HOCOMOCO     NFKB1_f1 NFKB1_HUMAN
##   chr17:4926809:G:A        RELA    HOCOMOCO      TF65_f2  TF65_HUMAN
##                                   seqMatch    pctRef    pctAlt  scoreRef
##                                <character> <numeric> <numeric> <numeric>
##   chr17:4926809:G:A           ggtgggtggg..  0.858902  0.727704   9.03707
##   chr17:4926809:G:A           ggtgggtggg..  0.871681  0.739436   9.96409
##                      scoreAlt Refpvalue Altpvalue    snpPos alleleRef alleleAlt
##                     <numeric> <logical> <logical> <integer> <numeric> <numeric>
##   chr17:4926809:G:A   7.68218      <NA>      <NA>      <NA>        NA        NA
##   chr17:4926809:G:A   8.47282      <NA>      <NA>      <NA>        NA        NA
##                          effect    altPos alleleDiff alleleEffectSize
##                     <character> <integer>  <numeric>        <numeric>
##   chr17:4926809:G:A      strong         1   -1.35489        -0.129109
##   chr17:4926809:G:A      strong         1   -1.49127        -0.130686
##   -------
##   seqinfo: 1 sequence from hg38 genome
```

```r
#plotMB(results = nfkb_results, rsid = "chr17:4926809:G:A", effect = "strong")
```


# SPOPL


```r
cs_table = readr::read_tsv("ftp://ftp.ebi.ac.uk/pub/databases/spot/eQTL/susie/QTS000001/QTD000006/QTD000006.credible_sets.tsv.gz")
```

```
## Rows: 61056 Columns: 13
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: "\t"
## chr (6): molecular_trait_id, gene_id, cs_id, variant, rsid, region
## dbl (7): cs_size, pip, pvalue, beta, se, z, cs_min_r2
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
SPOPL_cs = dplyr::filter(cs_table, molecular_trait_id == "ENSG00000144228") %>%
  dplyr::select(-rsid) %>% dplyr::distinct() %>%
  tidyr::separate(variant, into = c("chromosome", "position", "ref", "alt"), sep = "\\_", remove = FALSE) %>%
  dplyr::mutate(chromosome = stringr::str_replace(chromosome,"chr", replacement = "")) %>%
  dplyr::mutate(position = as.integer(position))
SPOPL_cs
```

```
## # A tibble: 10 × 16
##    molecular_…¹ gene_id cs_id variant chrom…² posit…³ ref   alt   cs_size    pip
##    <chr>        <chr>   <chr> <chr>   <chr>     <int> <chr> <chr>   <dbl>  <dbl>
##  1 ENSG0000014… ENSG00… ENSG… chr2_1… 2        1.39e8 C     T          10 0.110 
##  2 ENSG0000014… ENSG00… ENSG… chr2_1… 2        1.39e8 T     C          10 0.110 
##  3 ENSG0000014… ENSG00… ENSG… chr2_1… 2        1.39e8 C     T          10 0.103 
##  4 ENSG0000014… ENSG00… ENSG… chr2_1… 2        1.39e8 T     C          10 0.110 
##  5 ENSG0000014… ENSG00… ENSG… chr2_1… 2        1.39e8 C     T          10 0.0936
##  6 ENSG0000014… ENSG00… ENSG… chr2_1… 2        1.39e8 C     G          10 0.0940
##  7 ENSG0000014… ENSG00… ENSG… chr2_1… 2        1.39e8 G     A          10 0.0939
##  8 ENSG0000014… ENSG00… ENSG… chr2_1… 2        1.39e8 G     A          10 0.0933
##  9 ENSG0000014… ENSG00… ENSG… chr2_1… 2        1.39e8 A     G          10 0.0935
## 10 ENSG0000014… ENSG00… ENSG… chr2_1… 2        1.39e8 T     C          10 0.0997
## # … with 6 more variables: pvalue <dbl>, beta <dbl>, se <dbl>, z <dbl>,
## #   cs_min_r2 <dbl>, region <chr>, and abbreviated variable names
## #   ¹​molecular_trait_id, ²​chromosome, ³​position
```
