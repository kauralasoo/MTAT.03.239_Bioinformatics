# Homework 7 - Colocalisation and statistical fine mapping

## Task 1. Understanding the basics of fine mapping (1.5 points)
Using the flow cytometry fine mapping [tutorial](https://github.com/kauralasoo/flow_cytomtery_genetics/blob/master/analysis/fine_mapping/fine_mapping_example.md) and gene expression data from the naive macrophages, perform fine mapping on the CD14 gene expression data. You can downoload the  normalised expression data that from [Zenodo](https://zenodo.org/record/2571453#.XpSCQFMza-4) (salmonella_cqn_matrix.txt.gz file). You basically just need to replace the protein fluorescent intensity values used in the tutorial with normalised gene expression values for CD14 gene that you can download from Zenodo. Compare the the 95% credible set to the one obtained from protein expression (fuorescent intensity) data in this tutorial. 
1. How big are to two credible sets? How many variants are present in both credible sets? 
2. Do you think it is likely that the CD14 gene and protein expression are regulated by the same causal genetic varaint? Why or why not? How strong to you think the fine mapping evidence is? What other evidence can you take into account (think [HW6](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/blob/master/homeworks/2020/HW6.md), Task 2).

## Task 2. What is the effect of sample size on fine mapping accuracy? (1.5 points)
For this task, first download the CEDAR gene expression and genotype data from [here](https://drive.google.com/drive/folders/1PveWl7nJQlyYp_n2kY79qOx4LrwS9GcV?usp=sharing). Next, follow the [ARHGEF3 tutorial](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/blob/master/fine_mapping/CEDAR_finemapping_example.md) to get a basic working example. 

1. Use the ARHGEF3 locus from the CEDAR dataset to test how sample size affects fine mapping accuracy. To to this, start decreasing the sample size by 25 indivuduals and observe how the size of the credible set as well as the posterior inclusion probabilities (PIPs) change.
2. Look up the ARHGEF3 fine-mapped variant from the [Open Targets Genetics Portal](https://genetics.opentargets.org/). In which cell types and tissues can you see the eQTL? What are other traits most strongly associated with this variant? Do these signals also colocalise with the ARHGEF3 eQTL? How strong is the evidence for colocalisation? (Hint: this example was shown in the lecture). You might also find the [documentation](https://genetics-docs.opentargets.org/our-approach/colocalisation-analysis) for the Open Targets Genetics portal useful. The eQTL data in the Open Targets Genetics Portal comes from the [eQTL Catalogue](https://www.biorxiv.org/content/10.1101/2020.01.29.924266v1) that we have developed here in Tartu together with our collegues at the European Bioinformatics Institute.

## Task 3. Perform fine mapping for the lactase (LCT) gene in the illeum tissue (2 points)
In Task 1 of [Homework 4](https://github.com/kauralasoo/MTAT.03.239_Bioinformatics/blob/master/homeworks/2020/HW4.md) you compared the frequenies of [rs4988235](https://www.snpedia.com/index.php/Rs4988235) genetic variant accross populations. As mentioned in Homework 4, rs4988235 is associated with the ability to drink milk in Europeans populations and is thought to act by increasing the expression of the LCT gene in the correct tissue. Modify the fine mapping example in the ARHGEF3 tutorial to perform fine mapping for the lactase (LCT) gene in the [ileum](https://en.wikipedia.org/wiki/Ileum) tissue (which should probably be close to the correct tissue in which to study LCT expression). Note that since the LCT gene has two probes on the microarray used by the CEDAR study, you should perform fine mapping separately for both probes (Hint: for one probe the analysis will probably fail and you will not find any credible sets).
1. How many variants are part of the 95% credible set? What is the the highest PIP value observed across all variants?
2. Is the rs4988235 variant part of the credible set?
3. Increase the credible set coverage to 99%. How many variants are now in the credible set? Is rs4988235 one of them?
4. Based on these results, can we concluded that the LCT eQTL observed in ileum tissue is responsible for the lactose persistence phenotype? 
5. Open Targets Genetics Portal has GWAS results for the UK Biobank questionaire item ["Never/rarely have milk | milk type used"](https://genetics.opentargets.org/study/NEALE2_1418_6) that has a significant association near the LCT gene. Which eQTLs (genes) does this association colocalise with? In which cell types and tissues? Is LCT one of them?




