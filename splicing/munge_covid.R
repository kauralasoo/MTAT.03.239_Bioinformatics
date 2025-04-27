library("dplyr")
covid_df = readr::read_tsv("splicing/GCST011071_buildGRCh38.tsv")
covid_singal = dplyr::filter(covid_df, chromosome == 12, 
                             base_pair_location > 112919388-200000 & base_pair_location < 112919388+200000) %>%
  dplyr::mutate(variant = paste(paste0("chr", chromosome), base_pair_location, other_allele, effect_allele, sep = "_")) %>%
  dplyr::rename(rsid = variant_id)
write.table(covid_singal, "splicing/COVID-19_infection_GCST011071.tsv", sep = "\t", row.names = F, quote = F)
