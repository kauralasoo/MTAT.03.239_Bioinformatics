# Homework 6

## Task 1: Implement Gibbs sampler motif discovery
**Learning objective:** Learn how Gibbs sampling can be used to discover sequence motifs recognised by transcription factors from real world data.

Lecture slides contain two 'hint' slides, make use of them.

Example sequences from [Rosalind](http://rosalind.info/problems/ba2g/) contain up to 20 sequences. The code example from practice session will work fine on smaller data. But to use it on the real data, you need to optimise the code and possibly sampling process. Otherwise it will take too long time to run.  

To optimise:  

- You can modify source code to reduce loops  
- Optimise how data is handled, some repetitive tasks can be cached or skipped entirely.  
- The real data is annotated with scores ([https://genome.ucsc.edu/FAQ/FAQformat.html#format12](https://genome.ucsc.edu/FAQ/FAQformat.html#format12)). you can greatly reduce the search space, by choosing a subset of peaks with the largest score. 

You can validate your solution at: http://rosalind.info/problems/ba2g/

Get real data from [here](https://1drv.ms/f/s!AmCRrTXF10_MgXFZ4mpjd0btzSJd), motif length to search for is k = 18. 

Submit: 
 - your clean commented source code 
 - running time 
 - median motif for one (either PU.1 or CTCF)
   of the real datasets (can be SeqLogo) and PFM

<!--stackedit_data:
eyJoaXN0b3J5IjpbMjgwMDQ0MzBdfQ==
-->