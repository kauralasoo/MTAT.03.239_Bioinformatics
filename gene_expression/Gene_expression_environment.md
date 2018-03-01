
# Gene expression analysis

## Tutorials

 - [Multiple testing](http://genomicsclass.github.io/book/pages/multiple_testing.html) 
 - [R Bioconductor cheat sheet](https://github.com/mikelove/bioc-refcard)
 - [SummarizedExperiment](https://bioconductor.org/packages/release/bioc/vignettes/SummarizedExperiment/inst/doc/SummarizedExperiment.html) tutorial

## Setting up the R environment
For this week's practice session, you will need latest version of R together with RStudio and the following packages:

 - SummarizedExperiment
 - DESeq2
 - dplyr
 - gplots

This software should work on all operating systems, but for simplicity, you can also use Bioconductor [docker images](https://www.bioconductor.org/help/docker/).

First, pull the correct docker image. We are going to use `bioconductor/release_core2`:
	
	docker pull bioconductor/release_core2

Next, we can run the RStudio server:
	
	docker run -p 8787:8787 bioconductor/devel_base2

And finally, you can connect to RStudio by opening the following URL in your favourite browser:
	
	http://127.0.0.1:8787
The user name and password are both `rstudio`.

## Installing packages
You can install Bioconductor packages using the `biocLite` command:

	source("https://bioconductor.org/biocLite.R")
	biocLite("SummarizedExperiment")
	biocLite("DESeq2")
If it asks to update other packages, you can choose 'no' for now. For other packages in CRAN, you can just use the install.packages() command:
	
	install.packages("dplyr")
	install.packages("gplots")

## Downloading the datasets
First, download the dataset. (HINT: You can do this in the Terminal tab in RStudio or from the command line if you are using your own computer):

	wget https://www.dropbox.com/s/j52l5kdrxpaho30/RNA_SummarizedExperiment.rds

<!--stackedit_data:
eyJoaXN0b3J5IjpbMTUxNTc5MDIyNV19
-->