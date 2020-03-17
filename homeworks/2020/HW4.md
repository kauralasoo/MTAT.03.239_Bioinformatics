# Homework 4

## Task 1: Understanding the VCF file format (2 points)
**Learning objective:** Learn how to extract and interpret genetic variant data from VCF files.

The genetic variant most commonly associated with lactose persistence (ability to drink milk) in European populations is rs4988235 located on chromosome 2 on position 135851076. The reference allele at this position is G and the alternative allele is A. The AA and AG genotypes are associated with lactose persistence while individuals who have the GG genotype are likely to be lactose intolerant. The [GEUVADIS dataset](https://www.nature.com/articles/nature12531) contains individuals from four European populations (FIN, CEU, GBR, TSI) and one African population (YRI). You can find the VCF file with the genotypes of the GEUVADIS dataset on the HPC: 

	/gpfs/hpc/projects/MTAT.03.239_Bioinformatics/data/GEUVADIS/GEUVADIS_GRCh38_filtered_chr2.vcf.gz

1. Extract the genotypes of the rs4988235 genetic variant from the the VCF file. One way to do this is to use the bcftools command line utility:
	`module load bcftools-1.9`
    `bcftools view -r <chr>:<position> <path_to_vcf_file>`
2. Convert the genotypes from the numerical representation in the VCF file to reference and alternative alleles (AA, AG, or GG).
3. Count the frequencies of the AA, AG and GG genotypes in each of the 5 populations and make a table or a barplot. You can find which sample belongs to which population from the `GEUVADIS_populations.tsv` text file located in the same folder with the VCF file in the HPC. You can ignore the one individual (NA19171) with missing population information. Which population has the largest fraction of  people who are likely to be able to drink milk? Which one has the lowest?

## Task 2: Characterising population structure using PCA (1.5 points)
**Learning objective:** Learn how principal component analysis of the genotype data can be used to assign individuals to populations.

Using the same VCF file as in Task 1 and [QTLtools software](https://qtltools.github.io/qtltools/), perform principal component analysis fo the genotype data from the GEUVADIS dataset. QTLtools is installed in here: 

    /gpfs/hpc/projects/MTAT.03.239_Bioinformatics/software/bin/QTLtools

QTLtools allows you to perform PCA directly on VCF file without converting the dataset into 0,1,2 genotype matrix beforehand. The command that you need is something similar:

    QTLtools pca --vcf GEUVADIS_GRCh38_filtered_chr2.vcf.gz --scale --center --maf 0.05 --distance 50000 --out GEUVADIS_pca

The `--maf 0.05` option ensures that only common variants with minor allele frequency higher than 5% are included in the analysis. The `--distance 50000` option ensures that only genetic variances separated by at least 50000 nucleotides are included in the analysis. Both of these heuristics ensure that variants included in the analysis are approximately uncorrelated with each other (or in genetics jargon, they are in *linkage equilibrium* with each other). 
1. Perform PCA on the GEUVADIS genotype dataset using the QTLtools command described above. This will create a text file containing the principal component loadings for each sample in the VCF file.
2. Import the principal components file into R (or Python) and make scatter plot of the first two principal components. Colour the samples according to their population_code in the `GEUVADIS_populations.tsv`. Can you see a clear separation between European and African populations?
3. One of the samples (NA19171) in the `GEUVADIS_populations.tsv` file was missing the population information. Based on the PCA plot, can you predict the population from which the sample comes from?

## Task 3: Matching RNA-seq samples to individuals in the VCF file (1.5 points)
**Learning objective** Understand how genetic variants present in the RNA-seq data can used to detect which individual it was generated from.

You have received a new RNA-seq sample from the sequencing center (ERR188146.bam). You know that this samples is from one of the individuals in the GEUVADIS dataset,  but unfortunately the id of the individual has been lost. Your task is to compare the genotypes in the VCF and RNA-seq BAM files to detect which genotyped individual in the VCF file is the best match for this RNA-seq sample. This can be done using the QTLtools mbv tool. You can read more how this approach works from the original [publication](https://academic.oup.com/bioinformatics/article/33/12/1895/2982050). 

Using `QTLtools mbv` is easy, you just need to specify the BAM file, the VCF file and the output file for the results:
	
	QTLtools mbv --vcf GEUVADIS_GRCh38_filtered_chr2.vcf.gz --bam ERR188146.bam --out mbv_out

1. Describe in your own words in 4-5 sentences how the QTLtools mbv method works and how it can be used to detect matches between genotyped individuals and sequencing reads from RNA-seq experiment. I strongly recommend you to read the QTLtools mbv [publication](https://academic.oup.com/bioinformatics/article/33/12/1895/2982050) and [Supplementary Information](https://academic.oup.com/bioinformatics/article/33/12/1895/2982050#supplementary-data) on the journal website.
2. Once you have run QTLtools mbv, import the results into R (or Python) and make a scatter plot where on one axis you have the *fraction of concordant heterozygous sites* (n_het_consistent/n_het_covered from output file) and on the other axis you have the *fraction of concordant homozygous sites* (n_hom_consistent/n_hom_covered). Note that you need to calculate these ratios yourself as described above. Based on this plot, are you able to determine which individual is likely to correspond the ERR188146 RNA-seq sample? 

## Bonus task: Repeat the PCA analysis from Task 2 using the SNPRelate Bioconductor package (2 points)
