***********************************************************************

To execute the code run main.m
This code provides a modified implementation of the following:
1. MIDER: Network Inference with Mutual Information Distance and Entropy Reduction
(https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0096732f)
2. Gene regulatory network inference using PLS-based methods (PLSNET)
(https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-016-1398-6)
3. A probabilistic graphical model for system-wide analysis of gene regulatory networks
(https://academic.oup.com/bioinformatics/article-abstract/36/10/3192/5756207?redirectedFrom=fulltext)
Note that this folder does not conatin the full implementation of the codes.
Full implmentation of MIDER and PLSNET are publicly avaliable and can be downloaded from the respctive links above.


****************************  INPUT  ******************************
The code prompts for the following input

1. Input file: If you want to test one of the datasets in the paper, then type a number from 1 to 5. 
Otherwise, if you want to test your own data type 6. 
In the later case, your data file must be stored in the data directory as a CSV file with the name data.csv.
The CSV file should contian the gene expression data with gene names as header.

2. Method: The second input corresponds to the algorithm that you want to execute. 
If you want to execute plsnet once, enter 1.
If you wnat to execute plsnet multiple times and compute the frequencies enter 2.
If you want to execute MIDER enter 3.
If you want to execute MIDER and also verify the GRN using LBP, press 4.

3. Fraction : Enter the fraction of edges that you want to be considered in the final GRN.
PLSNET reurns all the edges, while MIDER implicitly computes a threshold and reutrns only a subset of edges.
For MIDER, the value of the threhold further discards the edges.

4. For running plsnet multiple times, we need additional parameter, which is the number of times you want to execute PLSNET.

****************************  OUTPUT  ******************************

The output files are stored in the output folder
1. The file Genes.txt stores the list of the genes
2. The file GRN.txt is the adjacency matrix of the graph regulatory network (For method 1,2,4 and 5 only)
3. The file frequencies.txt contains the frequencies of genes (For method 2 only)

********************************************************************
