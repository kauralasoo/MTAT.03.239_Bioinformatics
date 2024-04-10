library("dplyr")
library("tibble")
library("readr")

#Import gene expression data from Zenodo
ge_matrix = read.table("~/Downloads/salmonella_cqn_matrix.txt.gz", sep = "\t")
sample_metadata = readr::read_table("~/Downloads/salmonella_sample_metadata.txt.gz")

#Extract CD14 gene and make it into a data_frame
gene_row = ge_matrix["ENSG00000170458",]

#Transpose
gene_col = t(gene_row)

#Make into a tibble
gene_df = tibble::tibble(CD14_gene_exp = gene_col[,1], sample_id = names(gene_row))

#Keep relevant metadata columns
selected_metadata = sample_metadata %>%
  dplyr::select(sample_id, genotype_id, condition_name)

#join gene expression with metadata and select naive condition
filtered_expression = dplyr::left_join(gene_df, selected_metadata, by = "sample_id") %>%
  dplyr::filter(condition_name == "naive")
