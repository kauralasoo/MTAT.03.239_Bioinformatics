# Homework 6

## Task 1: Implement Gibbs sampler motif discovery
**Learning objective:** Learn how Gibbs sampling can be used to discover sequence motifs recognised by transcription factors from real world data.

Lecture slides contain two 'hint' slides, make use of them.

Example sequences from rosalind contain up to 20 sequences. The code example from practice session will work fine on smaller data. But to use it on the real data, you need to optimise the code and possibly sampling process.  
To optimise:  
* You can modify source code to reduce loops  
* optimise how data is handled, some repetitive tasks can be cached or skipped entirely.  
* real data is annotated with scores ([https://genome.ucsc.edu/FAQ/FAQformat.html#format12](https://genome.ucsc.edu/FAQ/FAQformat.html#format12)), you can greatly reduce the search space, by choosing some top of more trustworthy peaks.
You can validate your solution at: http://rosalind.info/problems/ba2g/

Get real data from [here](https://1drv.ms/f/s!AmCRrTXF10_MgXFZ4mpjd0btzSJd), motif length to search for is k = 18 

Submit: 
 - your clean commented source code 
 - running time 
 - median motif for one
   of the real datasets (can be SeqLogo) and PFM

<!--stackedit_data:
eyJoaXN0b3J5IjpbNzE4NTg2MDEzXX0=
-->