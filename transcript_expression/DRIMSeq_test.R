library("dplyr")
library("DRIMSeq")
library("SummarizedExperiment")

#Import data
dataset = readRDS("data/salmon_SummarizedExperiment_subset.rds")

#Keep naive and IFNg conditons and genes on chromosome 6
data = dataset[rowData(dataset)$chr == 6, dataset$condition_name %in% c("naive", "SL1344")]

#### Extract data from the SummarizedExperiment to make a DRIMSeq object ####
#Extract metadata
sample_data = colData(data) %>% as.data.frame() %>% dplyr::select(sample_id, condition_name)
transcript_data = rowData(data) %>% 
  as.data.frame() %>% 
  dplyr::as_tibble() %>% 
  dplyr::select(gene_id, transcript_id) %>% 
  dplyr::rename(feature_id = transcript_id)

#Extraxt counts
transcript_counts = assays(data)$counts %>% as.data.frame()
transcript_df = dplyr::mutate(transcript_counts, feature_id = row.names(transcript_counts)) %>% dplyr::as_tibble()

#Add gene ids to the transcript counts
counts_df = dplyr::left_join(transcript_data, transcript_df, by = "feature_id")


#Make a DRIMSeq object
dm_data <- dmDSdata(counts = as.data.frame(counts_df), samples = sample_data)

#Filtering (See DRIMSeq tutorial for details)
dm_data <- dmFilter(dm_data, min_samps_gene_expr = 16, min_samps_feature_expr = 8, min_gene_expr = 10, min_feature_expr = 10)

#Make a design matrix
design_full <- model.matrix(~ condition_name, data = DRIMSeq::samples(dm_data))

## To make the analysis reproducible
set.seed(123)
## Calculate precision ("This will take some time!)
dm_data <- dmPrecision(dm_data, design = design_full)

#Fit the model
dm_data <- dmFit(dm_data, design = design_full, verbose = 1)

#Test for differential transcript usage
dm_data <- dmTest(dm_data, coef = "condition_nameSL1344", verbose = 1)

#Extract results
gene_level = results(dm_data, level = "gene") %>% dplyr::arrange(pvalue)
head(gene_level)

transcript_level = results(dm_data, level = "feature") %>% dplyr::arrange(pvalue)
head(transcript_level)

#Make plots
plotProportions(dm_data, gene_id = "ENSG00000146457", group_variable = "condition_name")




