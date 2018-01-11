#data <- synGet('syn1661523')
#localFilePath <- data@filePath
localFilePath <- "<Path>/BLCA.sig_genes.txt"
genes <- read.delim(localFilePath,header=T,row.names=1)

#data <- synGet('syn1571514')
#localFilePath <-data@filePath
localFilePath <- "<Path>/broad.mit.edu_BLCA_Genome_Wide_SNP_6.hg19.seg.hugo.whitelist_tumor"
cnsdf <- read.delim(localFilePath,header=T,row.names=1)
