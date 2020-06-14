GuidingNet
=========
GuidingNet is a method to reveal transcriptional cofactor and predict binding for DNA methyltransferase by network regularization.

vPECA Source code
================
GuidingNet  
Version 1.0 Last updated: June 2, 2020

Reference
=
Lixin Ren, Caixia Gao, Zhana Duren and Yong Wang. GuidingNet: revealing transcriptional cofactor and predicting binding for DNA methyltransferase by network regularization. (bioRxiv, https://biorxiv.org/cgi/content/short/2020.06.02.129445v1)

Method
=
We develop a network regularized logistic regression model, GuidingNet, to predict DNA methyltransferases’ (DNMTs) genome-wide binding by integrating gene expression, chromatin accessibility, sequence, and protein-protein interaction data. GuidingNet accurately predicted methylation experimental data validated DNMTs’ binding, outperformed single data source based and sparsity regularized methods, and performed well in within and across tissue prediction for several DNMTs in human and mouse. Importantly, GuidingNet can reveal transcription co-factors assisting DNMTs for methylation establishment. This provides biological understanding in the DNMTs' binding specificity in different tissues and demonstrate the advantage of network regularization. In addition, GuidingNet achieves good performance for chromatin regulators’ binding other than DNMTs and serves as a useful method for studying chromatin regulator binding and function.

Processing data
=
GuidingNet model takes the context specific and non-specific genomic data as input. The input include chromatin openness, expression, sequence, and protein-protein interaction data. For expression (RNA-seq) and chromatin openness data (ATAC-seq or DNase-seq) , first we processed raw reads into an expression matrix with row genes and column samples. And chromatin accessibility data as a matrix with element by sample dimensions. TF binding strength are calculated from motif scan algorithm. TF expression specificity score is calculated from gene across tissues expression data. GC content is the percentage of guanine (G) and cytosine (C) in a DNA region. PPI and co-expression network are extracted from protein-protein interaction and gene across tissues expression data respectively. The training labels are from ChIP-seq data.

Running GuidingNet
=
The main program is in GuidingNet.r file. Please run the script and get the result from the folder called Output. Output includes the following two parts: 1) The ROC curve and AUC value of DNMT binding prediction, 2) A key TF network is related to DNMT binding in corresponding tissue or cell line.

Requirements
=
R

