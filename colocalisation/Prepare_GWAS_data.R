library("devtools")
library("dplyr")
load_all("../seqUtils/")

#Import old and new variant coordinates
GRCh38_variants = importVariantInformation("../macrophage-gxe-study/genotypes/SL1344/imputed_20151005/imputed.86_samples.variant_information.txt.gz")
GRCh37_variants = importVariantInformation("../macrophage-gxe-study/genotypes/SL1344/imputed_20151005/GRCh37/imputed.86_samples.variant_information.GRCh37.vcf.gz")

#Import RA GWAS data around the TRAF1 locus
qtl_df = data_frame(gene_id = "ENSG00000056558", snp_id = "rs10985070", trait = "RA")
gwas_ranges = constructVariantRanges(qtl_df, GRCh37_variants, cis_dist = 2e5)

gwas_summaries = tabixFetchGWASSummary(gwas_ranges, 
                summary_path = "~/datasets/Inflammatory_GWAS/Rheumatoid_Arthritis_Okada_2014_Nature_GWAS_meta.sorted.txt.gz")[[1]] %>%
  summaryReplaceSnpId(GRCh37_variants) %>% 
  summaryReplaceCoordinates(GRCh38_variants)
write.table(gwas_summaries, "colocalisation/RA_GWAS_TRAF1_locus.txt", sep = "\t", quote = FALSE, row.names = FALSE)


#Import Alzheimer's GWAS data around the PTK2B locus
qtl_df = data_frame(gene_id = "ENSG00000120899", snp_id = "rs28834970", trait = "AD")
gwas_ranges = constructVariantRanges(qtl_df, GRCh37_variants, cis_dist = 2e5)

gwas_summaries = tabixFetchGWASSummary(gwas_ranges, 
       summary_path = "~/datasets/Inflammatory_GWAS/Alzheimers_disease_Lambert_2013_NatGen_GWAS_meta_stage1.sorted.txt.gz")[[1]] %>%
  summaryReplaceSnpId(GRCh37_variants) %>% 
  summaryReplaceCoordinates(GRCh38_variants)
write.table(gwas_summaries, "colocalisation/AD_GWAS_PTK2B_locus.txt", sep = "\t", quote = FALSE, row.names = FALSE)


#Import Ulcerative colitis GWAS data around the ICOSLG locus
qtl_df = data_frame(gene_id = "ENSG00000160223", snp_id = "rs6518352", trait = "UC")
gwas_ranges = constructVariantRanges(qtl_df, GRCh37_variants, cis_dist = 2e5)

gwas_summaries = tabixFetchGWASSummary(gwas_ranges, 
             summary_path = "~/datasets/Inflammatory_GWAS/Inflammatory_bowel_disease_UC_Liu_2015_NatGen_Immunochip.sorted.txt.gz")[[1]] %>%
  summaryReplaceSnpId(GRCh37_variants) %>% 
  summaryReplaceCoordinates(GRCh38_variants)
write.table(gwas_summaries, "colocalisation/UC_GWAS_ICOSLG_locus.txt", sep = "\t", quote = FALSE, row.names = FALSE)
