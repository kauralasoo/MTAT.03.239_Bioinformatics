---
title: "Import Genotypes with GDSArray"
output: 
  html_document: 
    keep_md: yes
---



## Load packages

```r
suppressMessages(library("SNPRelate"))
suppressMessages(library("GDSArray"))
source("GDSArray_helpers.R")
```

## Step 1: Convert a VCF file to a binary GDS format


```r
SNPRelate::snpgdsVCF2GDS("GEUVADIS_genotypes.vcf.gz", "GEUVADIS_genotypes.gds", method="biallelic.only")
```

```
## VCF Format ==> SNP GDS Format
## Method: exacting biallelic SNPs
## Number of samples: 445
## Parsing "GEUVADIS_genotypes.vcf.gz" ...
## 	import 37262 variants.
## + genotype   { Bit2 445x37262, 4.0M } *
## Optimize the access efficiency ...
## Clean up the fragments of GDS file:
##     open the file 'GEUVADIS_genotypes.gds' (4.1M)
##     # of fragments: 55
##     save to 'GEUVADIS_genotypes.gds.tmp'
##     rename 'GEUVADIS_genotypes.gds.tmp' (4.1M, reduced: 420B)
##     # of fragments: 20
```

## Step 2: Import variant names and coordinates from the GDS file


```r
variant_info = importVariantInformationFromGDS("GEUVADIS_genotypes.gds")
```

```
## Warning: `data_frame()` is deprecated, use `tibble()`.
## This warning is displayed once per session.
```

```r
variant_info
```

```
## # A tibble: 37,262 x 4
##    gds_snp_id chromosome     pos snp_id          
##         <int> <chr>        <int> <chr>           
##  1          1 1          1301656 chr1_1301656_T_C
##  2          2 1          1302224 chr1_1302224_T_C
##  3          3 1          1302799 chr1_1302799_C_A
##  4          4 1          1303112 chr1_1303112_G_A
##  5          5 1          1303800 chr1_1303800_G_A
##  6          6 1          1303959 chr1_1303959_T_G
##  7          7 1          1304555 chr1_1304555_A_C
##  8          8 1          1304573 chr1_1304573_A_G
##  9          9 1          1305900 chr1_1305900_C_T
## 10         10 1          1306149 chr1_1306149_A_G
## # … with 37,252 more rows
```

## Step 3: Exptract genotypes for one specific variant


```r
variant_genotypes = extractVariantGenotypeFromGDS(variant_id = "chr1_1302224_T_C", variant_information = variant_info, gdsfile = "GEUVADIS_genotypes.gds")
variant_genotypes
```

```
## # A tibble: 445 x 3
##    genotype_id genotype_value snp_id          
##    <chr>                <int> <chr>           
##  1 NA20508                  0 chr1_1302224_T_C
##  2 NA12812                  0 chr1_1302224_T_C
##  3 HG00315                  0 chr1_1302224_T_C
##  4 NA12749                  0 chr1_1302224_T_C
##  5 NA20510                  0 chr1_1302224_T_C
##  6 NA07056                  0 chr1_1302224_T_C
##  7 HG00155                  0 chr1_1302224_T_C
##  8 HG00355                  1 chr1_1302224_T_C
##  9 NA19119                  1 chr1_1302224_T_C
## 10 HG00350                  0 chr1_1302224_T_C
## # … with 435 more rows
```

## Step 4: Extract genotypes matrix for all variants in a given region


```r
genotype_matrix = extractGenotypeMatrixFromGDS(chr = "1", start = 1301656, end = 1306149, variant_information = variant_info, gdsfile = "GEUVADIS_genotypes.gds")
genotype_matrix[1:8,1:10]
```

```
##                  NA20508 NA12812 HG00315 NA12749 NA20510 NA07056 HG00155
## chr1_1302224_T_C       0       0       0       0       0       0       0
## chr1_1302799_C_A       2       2       2       2       2       2       2
## chr1_1303112_G_A       2       1       1       2       2       2       2
## chr1_1303800_G_A       2       1       1       2       2       2       2
## chr1_1303959_T_G       0       0       0       0       0       0       0
## chr1_1304555_A_C       2       1       1       2       2       2       2
## chr1_1304573_A_G       0       0       0       0       0       0       0
## chr1_1305900_C_T       2       2       2       2       2       2       2
##                  HG00355 NA19119 HG00350
## chr1_1302224_T_C       1       1       0
## chr1_1302799_C_A       2       2       2
## chr1_1303112_G_A       2       1       2
## chr1_1303800_G_A       2       2       2
## chr1_1303959_T_G       1       1       0
## chr1_1304555_A_C       2       1       2
## chr1_1304573_A_G       1       1       0
## chr1_1305900_C_T       2       2       2
```

