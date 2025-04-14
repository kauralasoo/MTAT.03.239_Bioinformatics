library(ggplot2)
library(dplyr)
library(coloc)

ra_meta = readr::read_tsv("~/Downloads/RA_chr2_meta.tsv", col_names = F)
header = readr::read_tsv("~/Downloads/meta_analysis_mvp_ukbb_summary_stats_M13_RHEUMA_meta_out.tsv", n_max = 5)
colnames(ra_meta) = colnames(header)

onek1k = readr::read_tsv("~/Downloads/QTD000612.cc.tsv.gz")

ctla_sumstats = dplyr::filter(onek1k, molecular_trait_id == "ENSG00000163599") %>% 
  dplyr::select(-rsid) %>%
  dplyr::distinct()
write.table(ctla_sumstats, "colocalisation/CTLA4_coloc/CTLA_sumstats.tsv", quote = F, sep = "\t", row.names = F)

region_start = 202868828
region_end = 204867570

ra_region = dplyr::transmute(ra_meta, '#CHR', POS, REF, ALT, SNP, beta = all_inv_var_meta_beta, se = all_inv_var_meta_sebeta, p = all_inv_var_meta_p, mlogp = all_inv_var_meta_mlogp) %>%
  dplyr::filter(POS > region_start & POS < region_end) %>%
  dplyr::mutate(variant = paste("chr2", POS, REF, ALT, sep = "_"))
write.table(ra_region, "colocalisation/CTLA4_coloc/RA_sumstats.tsv", quote = F, sep = "\t", row.names = F)

#keep shared variants
ra_shared = dplyr::semi_join(ra_region, onek1k, by = "variant")
ggplot(ra_shared, aes(x = POS, y = mlogp)) + geom_point()

eqtl_dataset = list(snp = ctla_sumstats$variant, beta = ctla_sumstats$beta, varbeta = ctla_sumstats$se^2, type = "quant", sdY = 1)
gwas_dataset = list(snp = ra_region$variant, beta = ra_region$beta, varbeta = ra_region$se^2, type = "cc")

#Check dataset
coloc::check_dataset(eqtl_dataset)
coloc::check_dataset(gwas_dataset)

coloc.abf(eqtl_dataset, gwas_dataset, p12 = 1e-6)


