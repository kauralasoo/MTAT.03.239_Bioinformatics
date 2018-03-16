library("SummarizedExperiment")
library("DESeq2")
library("dplyr")

#Import gene expression
counts = as.matrix(read.table("data/RNA_count_matrix.txt.gz"))
cqns = as.matrix(read.table("data/RNA_cqn_matrix.txt.gz"))

#Import metadata
gene_metadata = read.table("data/RNA_gene_metadata.txt.gz", stringsAsFactors = FALSE, header = TRUE) %>%
  dplyr::rename(gene_strand = strand, gene_start = start, gene_end = end)
rownames(gene_metadata) = gene_metadata$gene_id

sample_metadata = read.table("data/RNA_sample_metadata.txt.gz", stringsAsFactors = FALSE, header = TRUE)
rownames(sample_metadata) = sample_metadata$gene_id

#Construct SummarizedExperiment object
se = SummarizedExperiment(
  assays = list(counts = counts, cqn = cqns), 
  colData = sample_metadata, 
  rowData = gene_metadata)
saveRDS(se, "data/RNA_SummarizedExperiment.rds")

#### Export full dataset for funcExplorer
#Reorder columns
sample_metadata$condition_name = factor(sample_metadata$condition_name, levels = c("naive", "IFNg", "SL1344", "IFNg_SL1344"))
data = dplyr::arrange(sample_metadata, condition_name)
se_ordered = se[,data$sample_id]

#Keep protein coding genes only
protein_coding = dplyr::filter(gene_metadata, gene_biotype == "protein_coding")
se_filtered = se_ordered[protein_coding$gene_id, ]

ordered_cqn = assays(se_filtered)$cqn
write.table(ordered_cqn, "data/RNA_full_cqn_matrix.txt", sep = "\t", quote = FALSE)

#Subsample smaller dataset for funcExplorer
set.seed(1)
random8 = unique(colData(se)$donor) %>% sample(8)
se_subset = se_filtered[,se_filtered$donor %in% random8]
subset_cqn = assays(se_subset)$cqn
write.table(subset_cqn, "data/RNA_32samples.txt", sep = "\t", quote = FALSE)


#Sample random 8 donors
se = readRDS("data/RNA_SummarizedExperiment.rds")
set.seed(1)
random8 = unique(colData(se)$donor) %>% sample(8)
subset_se = se[,se$donor %in% random8]



#Switch two samples
old_col_data = colData(subset_se)
new_col_data = dplyr::mutate(as.data.frame(old_col_data), sample_id = ifelse(sample_id == "yuze_A", "yuze_B1", sample_id)) %>%
  dplyr::mutate(sample_id = ifelse(sample_id == "yuze_B", "yuze_A", sample_id)) %>%
  dplyr::mutate(sample_id = ifelse(sample_id == "yuze_B1", "yuze_B", sample_id))

#rename count matrix
new_counts = assays(subset_se)$counts
colnames(new_counts) = new_col_data$sample_id

#Make a new se
new_se = SummarizedExperiment(
  assays = list(counts = new_counts), 
  colData = old_col_data[new_col_data$sample_id,], 
  rowData = rowData(subset_se))
saveRDS(new_se, "data/RNA_SummarizedExperiment_swapped.rds")
new_se = readRDS("data/RNA_SummarizedExperiment_swapped.rds.gz")

#Make PCA
dds = DESeqDataSet(new_se, design = ~condition_name)
vds = vst(dds)
plotPCA(vds, intgroup=c("condition_name"))

highly_expressed = names(sort(rowMeans(assay(vds)), decreasing = TRUE)[1:500])
vds = vds[highly_expressed,]

pca = prcomp(t(assay(vds)), center = TRUE, scale. = TRUE)
pca_matrix = dplyr::mutate(as.data.frame(pca$x), sample_id = rownames(pca$x)) %>%
  dplyr::left_join(as.data.frame(colData(vds)))
ggplot(pca_matrix, aes(x = PC1, y = PC2, color = condition_name, label = sample_id)) + geom_text() + geom_point()

cor_matrix = cor(assay(vds), method = "spearman")
gplots::heatmap.2(cor_matrix)




#Take a subset of the Salmon quants
dataset = readRDS("data/salmonella_salmon_Ensembl_87.rds")

#Select 8 donors
set.seed(1)
donors_subset = colData(dataset)$donor %>% unique() %>% sample(8)
data_subset = dataset[,dataset$donor %in% donors_subset]
saveRDS(data_subset, "data/salmon_SummarizedExperiment_subset.rds")



eigengene = read.table("~/Downloads/RNA_full_cqn_matrix_eigengene (1).tsv", sep = "\t", header = TRUE)
ecm_cluster = dplyr::filter(eigengene, ID == "1126")
ecm_df = tidyr::gather(ecm_cluster, "sample_id", "eigengene", aipt_A:zuta_D)

df = dplyr::left_join(sample_metadata, ecm_df, by = "sample_id") %>% dplyr::filter(condition_name == "naive")



