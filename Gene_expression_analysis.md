
# Gene expression analysis

## Tutorials

 - [Multiple testing](http://genomicsclass.github.io/book/pages/multiple_testing.html) 
 - [R Bioconductor cheat sheet](https://github.com/mikelove/bioc-refcard)
 - [SummarizedExperiment](https://bioconductor.org/packages/release/bioc/vignettes/SummarizedExperiment/inst/doc/SummarizedExperiment.html) tutorial

## Setting up the command-line environment
For this week's practice session, you will need latest version of R together with RStudio and the following packages:

 - SummarizedExperiment
 - DESeq2
 - dplyr

This software should work on all operating systems, but for simplicity, you can also use Bioconductor [docker images](https://www.bioconductor.org/help/docker/).

First, pull the correct docker image. We are going to use `bioconductor/release_core2`:
	
	docker pull bioconductor/release_core2


The key advantage of using the [SummarizedExperiment](https://bioconductor.org/packages/release/bioc/vignettes/SummarizedExperiment/inst/doc/SummarizedExperiment.html) class to store your gene expression data is that you can easily perform coordinated subsetting of the data.

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEwMTAzNTY0NDNdfQ==
-->