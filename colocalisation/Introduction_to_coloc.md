---
title: "Introduction to colocalisation"
output: 
  html_document: 
    keep_md: yes
---





## Import the necessary R packages

```r
library("dplyr")
library("coloc")
```

## Import association summary statistics
You can find the full eQTL summary statistics from Zenodo: https://zenodo.org/record/1158560. Since the TRAF1 eQTL was specific to the IFNg + Salmonella condition, then the file that you need is RNA_FastQTL_IFNg_SL1344_500kb_pvalues.sorted.txt.gz. For the PTK2B and ICOSLG eQTLs you should use the RNA_FastQTL_naive_500kb_pvalues.sorted.txt.gz file, because those eQTLs were detected in the naive condition. Since the summary files are quite big (~430mb compressed), you might not want to load the complete files into R, especialy because you only need data from specific genes.

The simplest thing to do is to extract the TRAF1 eQTL summary statistics from the file using grep:
```{
gunzip -c  RNA_FastQTL_IFNg_SL1344_500kb_pvalues.sorted.txt.gz | grep ENSG00000056558 > TRAF1_eQTL.txt
```

Now we can just load the eQTL summary statistics into R

```r
eQTL_summaries = read.table("TRAF1_eQTL.txt", stringsAsFactors = FALSE, col.names = c("phenotype_id","chr","pos","snp_id","distance","p_nominal","beta")) %>% tbl_df()
eQTL_summaries
```

```
## # A tibble: 1,494 x 7
##    phenotype_id      chr       pos snp_id     distance p_nominal    beta
##    <chr>           <int>     <int> <chr>         <int>     <dbl>   <dbl>
##  1 ENSG00000056558     9 120403829 rs16909739  -498565    0.0385  0.110 
##  2 ENSG00000056558     9 120403882 rs2297453   -498512    0.345  -0.0317
##  3 ENSG00000056558     9 120404641 rs3780674   -497753    0.176  -0.0513
##  4 ENSG00000056558     9 120407440 rs2282168   -494954    0.616  -0.0176
##  5 ENSG00000056558     9 120407793 rs1888893   -494601    0.285  -0.0367
##  6 ENSG00000056558     9 120407889 rs914592    -494505    0.501  -0.0236
##  7 ENSG00000056558     9 120407932 rs914593    -494462    0.616  -0.0176
##  8 ENSG00000056558     9 120408455 rs4837768   -493939    0.396  -0.0284
##  9 ENSG00000056558     9 120408642 rs7874364   -493752    0.225  -0.0403
## 10 ENSG00000056558     9 120409378 rs36054791  -493016    0.377  -0.0606
## # ... with 1,484 more rows
```

We can also import the rheumatoid arhtris (RA) GWAS summary statistics from the TRAF1 locus:

```r
gwas_summaries = read.table("RA_GWAS_TRAF1_locus.txt", stringsAsFactors = FALSE, header = TRUE) %>% tbl_df()
gwas_summaries
```

```
## # A tibble: 626 x 14
##    effect_allele p_nominal beta     OR  log_OR     se z_score trait   PMID
##    <chr>             <dbl> <lgl> <dbl>   <dbl>  <dbl>   <dbl> <chr>  <int>
##  1 T               0.0660  NA    0.970 -0.0305 0.0166  -1.84  Rheu… 2.44e7
##  2 T               0.0170  NA    0.960 -0.0408 0.0171  -2.39  Rheu… 2.44e7
##  3 G               0.700   NA    0.980 -0.0202 0.0524  -0.385 Rheu… 2.44e7
##  4 T               0.120   NA    1.03   0.0296 0.0190   1.55  Rheu… 2.44e7
##  5 A               0.00680 NA    1.05   0.0488 0.0180   2.71  Rheu… 2.44e7
##  6 T               0.00670 NA    1.05   0.0488 0.0180   2.71  Rheu… 2.44e7
##  7 G               0.00680 NA    1.05   0.0488 0.0180   2.71  Rheu… 2.44e7
##  8 G               0.00680 NA    1.05   0.0488 0.0180   2.71  Rheu… 2.44e7
##  9 T               0.00690 NA    0.960 -0.0408 0.0151  -2.70  Rheu… 2.44e7
## 10 T               0.00660 NA    1.05   0.0488 0.0180   2.72  Rheu… 2.44e7
## # ... with 616 more rows, and 5 more variables: used_file <chr>,
## #   snp_id <chr>, chr <int>, pos <int>, MAF <dbl>
```

## Filter the summary statistics to a region +/- 200kb from the lead eQTL variant

Identify the lead eQTL variant (the genetic variant that has the smallest p-value in the eQTL analyis):

```r
lead_var = dplyr::arrange(eQTL_summaries, p_nominal) %>% dplyr::filter(row_number() == 1)
```
Keep only those eQTL variants that are +/- 200kb from the lead variant


```r
eQTL_filtered = dplyr::filter(eQTL_summaries, (pos > lead_var$pos - 200000) & (pos < lead_var$pos + 200000))
```

Keep only those variants that are present in both eQTL and GWAS datasets:

```r
shared_variants = intersect(eQTL_filtered$snp_id, gwas_summaries$snp_id)
eQTL_shared = dplyr::filter(eQTL_filtered, snp_id %in% shared_variants) %>% dplyr::arrange(pos)
gwas_shared = dplyr::filter(gwas_summaries, snp_id %in% shared_variants) %>% dplyr::arrange(pos)
```
Copy minor allele frequency from the GWAS summary statistics into the eQTL summary statistics

```r
eQTL_shared = dplyr::left_join(eQTL_shared, dplyr::select(gwas_shared, snp_id, MAF), by = "snp_id")
```

### Test for colocalisation between eQTL and GWAS summary statistics

First, let's set up both datasets for colocalisation. Note that if the `log_OR` column in the GWAS dataset contains only NAs then you should use the `beta` column instead.

```r
eQTL_dataset = list(pvalues = eQTL_shared$p_nominal, 
                    N = 84, #The sample size of the eQTL dataset was 84
                    MAF = eQTL_shared$MAF, 
                    type = "quant", 
                    beta = eQTL_shared$beta,
                    snp = eQTL_shared$snp_id)
gwas_dataset = list(beta = gwas_shared$log_OR, #If log_OR column is full of NAs then use beta column instead
                    varbeta = gwas_shared$se^2, 
                    type = "cc", 
                    snp = gwas_shared$snp_id,
                    s = 0.5, #This is acutally not used, because we already specified varbeta above.
                    MAF = gwas_shared$MAF)
```

Now we can finally run coloc itself

```r
coloc_res = coloc::coloc.abf(dataset1 = eQTL_dataset, dataset2 = gwas_dataset,p1 = 1e-4, p2 = 1e-4, p12 = 1e-5)
```

```
## PP.H0.abf PP.H1.abf PP.H2.abf PP.H3.abf PP.H4.abf 
##  1.38e-06  6.01e-05  1.66e-03  7.12e-02  9.27e-01 
## [1] "PP abf for shared variant: 92.7%"
```

```r
coloc_res$summary
```

```
##        nsnps    PP.H0.abf    PP.H1.abf    PP.H2.abf    PP.H3.abf 
## 6.050000e+02 1.381368e-06 6.011075e-05 1.656579e-03 7.115952e-02 
##    PP.H4.abf 
## 9.271224e-01
```

