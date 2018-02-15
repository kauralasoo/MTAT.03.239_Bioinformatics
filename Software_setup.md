# Setting up the command-line environment

Bioinformatics software can be notoriously difficult to install. To make your life easier, we are going to perform all data analysis tasks using [docker](https://www.docker.com/) containers. You are, of course, free to install all of the software in your own environment, but in this case we will not be able to provide any support when software issues do arise. Importantly, many bioinformatics tools do not run on Windows.

## Useful tutorials

 - [command-line bootcamp](http://rik.smith-unna.com/command_line_bootcamp/)
 - [Enough Docker to be Dangerous](http://seankross.com/2017/09/17/Enough-Docker-to-be-Dangerous.html)
 - [Conda environments](https://conda.io/docs/user-guide/tasks/manage-environments.html%29)
 - [NBIS Reproducible Research Course](http://nbis-reproducible-research.readthedocs.io/en/latest/) (conda, Snakemake, Docker, Jupyter, etc)
 - [Snakemake tutorial](https://snakemake.readthedocs.io/en/stable/tutorial/tutorial.html)
 - [Snakemake tutorial slides](http://slides.com/johanneskoester/snakemake-tutorial-2016#/)

## Setting up docker
Your first task is to install docker. I recommend  to follow this excellent [tutorial](http://seankross.com/2017/09/17/Enough-Docker-to-be-Dangerous.html) to get familiar with the basic functionality of docker, including how to download images, how to start and stop containers and how to copy files between your own environment and the docker container.

Instead of Ubuntu 14.04 used in the tutorial, we will be using Ubunt 16.04:

    docker pull ubuntu:16.04

**All of the following commands in this worksheet should be run within the docker container.** You can start the container with the following command:
	
	docker run -ti ubuntu:16.04

Alternatively, you can mount local directories directly into the docker container. The advantage of this approach is that you can access the same files from your own environment as well as within the docker image.

	docker run -ti -v /Users/alasoo/igv/:/data:rw ubuntu:16.04 bash

## Install commonly used utilities
The vanilla ubuntu image is missing some important utilities such as wget (for downloading files), bzip2 (for uncompressing them) and less (for viewing them). 
Let's install them:

    apt-get update
    apt-get install wget
    apt-get install bzip2
    apt-get install less
    apt-get install graphviz

## Installing anaconda
[Anaconda](https://www.anaconda.com/download) is an all-in-one package manager, environment manager and Python distribution as well as a collection of hundreds of open source packages. Anaconda makes it easy to run multiple different version of Python in parallel. Furthermore, [bioconda](https://bioconda.github.io/) that is built on top of the anaconda package manager, makes it easy to install many different bioinformatics software packages, including those that are not written in Python.

To perform the next steps, you need to start the docker container following the [tutorial](http://seankross.com/2017/09/17/Enough-Docker-to-be-Dangerous.html) linked above. Now, let's switch to root user's home directory:

    cd root
Then, let's download anaconda installation script (this file is 525 MB!):

	wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh
Finally, we can [install](https://docs.anaconda.com/anaconda/install/linux) Anaconda:

	bash Anaconda3-5.0.1-Linux-x86_64.sh

Anaconda should now be installed and you are ready to create and manage conda [environments](https://conda.io/docs/user-guide/tasks/manage-environments.html). However, before we can start, we need to make sure that that the PATH environment variable is up to date:

	source .bashrc
Now, let's create our first conda environment with python 3.6:

	conda create -n py3.6 python=3.6
Now, let's activate this environment:

	source activate py3.6
Remember that you need to activate the environment every time you restart the docker container, because all of the software installed below will be in that environment. To learn more about the environments, have a look at the conda [tutorial](https://conda.io/docs/user-guide/tasks/manage-environments.html).

## Set up bioconda
[Bioconda](https://bioconda.github.io/) is a channel for the conda package manager specializing in bioinformatics software. You can set up bioconda using the following commands:

	conda config --add channels defaults
	conda config --add channels conda-forge
	conda config --add channels bioconda
	
## Installing Snakemake
[Snakemake](http://snakemake.readthedocs.io/en/latest/) is a tool to define and execute reproducible [bioinformatics workflows](https://academic.oup.com/bib/article/18/3/530/2562749). It greatly simplifies running multiple analysis steps on a large number of input files (biological samples). We will be using Snakemake throughout the course to gradually build more and more complex workflows.

Once conda is installed, installing snakemake is easy:

	conda install snakemake


## Installing HISAT2 RNA-seq aligner
HISAT2 is a program to align RNA sequencing reads to a reference genome.
	
	conda install hisat2

## Installing featureCounts
[featureCounts](http://subread.sourceforge.net/) is a tool for counting the number of RNA-seq reads that overlap gene annotations. A popular alternative is [HTSeq-count](https://htseq.readthedocs.io), but both of the tools should provide reasonably similar results.

	conda install subread

## Installing samtools

	conda install samtools





<!--stackedit_data:
eyJoaXN0b3J5IjpbMjY2NjI1MDhdfQ==
-->