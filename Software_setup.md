# Setting up the software for environments for the Bioinformatics course

Bioinformatics software can be notoriously difficult to install. To make your life easier, we are going to perform all data analysis tasks using [docker](https://www.docker.com/) containers. You are, of course, free to install all of the software in your own environment, but in this case we will not be able to provide any support when software issues do arise. Importantly, many bioinformatics tools do not run on Windows.

## Setting up docker
Your first task is to install docker. I recommend you to follow this excellent [tutorial](http://seankross.com/2017/09/17/Enough-Docker-to-be-Dangerous.html) to get familiar with the basic functionality of docker, including how to download images, how to start and stop containers and how to copy files between your own environment and the docker container.

## Installing anaconda
[Anaconda](https://www.anaconda.com/download) is an all-in-one package manager, environment manager and Python distribution as well as a collection of hundreds of open source packages. Anaconda makes it easy to run multiple different version of Python in parallel. Furthermore, [bioconda](https://bioconda.github.io/) that is built on top of the anaconda package manager, makes it easy to install many different bioinformatics software packages, including those that are not written in Python.

## Installing Snakemake
Snakemake is a workflow engine for running bio

## Installing STAR RNA-seq aligner
STAR is a program to align RNA sequencing reads to a reference genome.

## Installing featureCounts
featureCounts is a tool for counting the number of RNA-seq reads that overlap gene annotations. A popular alternative is HTSeq-count, but both of the tools should provide reasonably similar results.




<!--stackedit_data:
eyJoaXN0b3J5IjpbLTg2NjM3MTA4Ml19
-->