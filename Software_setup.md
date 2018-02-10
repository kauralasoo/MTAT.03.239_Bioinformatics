# Setting up the software for environments for the Bioinformatics course

Bioinformatics software can be notoriously difficult to install. To make your life easier, we are going to perform all data analysis tasks using [docker](https://www.docker.com/) containers. You are, of course, free to install all of the software in your own environment, but in this case we will not be able to provide any support when software issues do arise. Importantly, many bioinformatics tools do not run on Windows.

## Useful tutorials

 - [command-line bootcamp](http://rik.smith-unna.com/command_line_bootcamp/)
 - [Enough Docker to be Dangerous](http://seankross.com/2017/09/17/Enough-Docker-to-be-Dangerous.html)
 - [Conda environments](https://conda.io/docs/user-guide/tasks/manage-environments.html%29)
 - [NBIS Reproducible Research Course](http://nbis-reproducible-research.readthedocs.io/en/latest/) (conda, Snakemake, Docker, Jupyter, etc)
 - [Snakemake tutorial](https://snakemake.readthedocs.io/en/stable/tutorial/tutorial.html)

## Setting up docker
Your first task is to install docker. I recommend you to follow this excellent [tutorial](http://seankross.com/2017/09/17/Enough-Docker-to-be-Dangerous.html) to get familiar with the basic functionality of docker, including how to download images, how to start and stop containers and how to copy files between your own environment and the docker container.

Instead of Ubuntu 14.04 used in the tutorial, we will be using Ubunt 16.04:

    docker pull ubuntu:16.04

## Install commonly used utilities
The vanilla ubuntu image is missing some important utilites. Let's install them 

    apt-get update
    apt-get install wget
    apt-get install bzip2

## Installing anaconda
[Anaconda](https://www.anaconda.com/download) is an all-in-one package manager, environment manager and Python distribution as well as a collection of hundreds of open source packages. Anaconda makes it easy to run multiple different version of Python in parallel. Furthermore, [bioconda](https://bioconda.github.io/) that is built on top of the anaconda package manager, makes it easy to install many different bioinformatics software packages, including those that are not written in Python.

First, let's switch to root users home directory:

    cd root
Now, let's download anaconda installation script (this file is 525 MB!):

	wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh
Finally, we can [install](https://docs.anaconda.com/anaconda/install/linux) Anaconda:

	bash Anaconda3-5.0.1-Linux-x86_64.sh

Anaconda should now be installed and you are ready to create and manage conda environments. See the full documentation  [here](https://conda.io/docs/user-guide/tasks/manage-environments.html).
	
First let's make sure, that the PATH environment variable is up to date:

	source .bashrc
Then, let's create our first conda environment with python 3.6:

	conda create -n py3.6 python=3.6
Now, let's activate this environment:

	source activate py3.6

## Set up bioconda

	conda config --add channels defaults
	conda config --add channels conda-forge
	conda config --add channels bioconda
	
## Installing Snakemake
[Snakemake](http://snakemake.readthedocs.io/en/latest/) is a tool to define and execute reproducible bioinformatics workflows [ADD LINK TO PAPER]. It greatly simplifies running multiple analysis steps on a large number of input files (biological samples). We will be using Snakemake throughout the course to gradually build more and more complex workflows.

Once conda is installed, installing snakemake is easy:

	conda install snakemake


## Installing STAR RNA-seq aligner
STAR is a program to align RNA sequencing reads to a reference genome.
	
	conda install STAR

## Installing featureCounts
[featureCounts](http://subread.sourceforge.net/) is a tool for counting the number of RNA-seq reads that overlap gene annotations. A popular alternative is HTSeq-count, but both of the tools should provide reasonably similar results.

	conda install subread

## Installing samtools

	conda install samtools





<!--stackedit_data:
eyJoaXN0b3J5IjpbLTg0MTc3Njk0NV19
-->