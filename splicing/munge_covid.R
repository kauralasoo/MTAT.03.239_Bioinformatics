library("dplyr")
covid_df = readr::read_tsv("splicing/GCST011071_buildGRCh38.tsv")
covid_singal = dplyr::filter(covid_df, chromosome == 12, 
                             base_pair_location > 112919388-200000 & base_pair_location < 112919388+200000) %>%
  dplyr::mutate(variant = paste(paste0("chr", chromosome), base_pair_location, other_allele, effect_allele, sep = "_")) %>%
  dplyr::rename(rsid = variant_id)
write.table(covid_singal, "splicing/COVID-19_infection_GCST011071.tsv", sep = "\t", row.names = F, quote = F)

#Import GEUVADIS leafcutter QTLs
GEUV_df = readr::read_tsv("splicing/QTD000114.cc.tsv.gz")
oas1 = dplyr::filter(GEUV_df, gene_id == "ENSG00000089127") %>%
  dplyr::filter(position > 112919388-200000 & position < 112919388+200000)
write.table(oas1, "splicing/GEUVADIS_OAS1_sQTLs.tsv", sep = "\t", row.names = F, quote = F)

#Visualise the thee signals for testing
ggplot(oas1, aes(x = position, y = -log(pvalue, 10))) + geom_point() + facet_grid(molecular_trait_object_id~1)
