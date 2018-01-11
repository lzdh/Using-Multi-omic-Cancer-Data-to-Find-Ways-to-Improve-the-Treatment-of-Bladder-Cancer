# A look at how complete the data is. If we would like to compare clusters for each data type - then we need to use subsets of each data
# for which we have the same patients across all data sets

# Explanation about patient ID
#"TCGA.BT.A20R.01A.12R.A16R.075" Note that the "A20R" part is the patient

# CNVt = copy number variation tumor, GEt = gene expression tumor, METHt = methylation tumor
# load these in with the same names
# CNVt ID = syn1571514 
# GEt ID = syn1571504
# METHt ID = syn1571509 

# Getting just the patient ID
colnames(CNVt) <- substr(colnames(CNVt), 9, 12)
colnames(GEt) <- substr(colnames(GEt), 9, 12)
colnames(METHt) <- substr(colnames(METHt), 9, 12)

# How many unique patients are in each individual dataset? Answer: ALL ie no duplicates
length(unique(colnames(GEt))) # all 96 unique
length(unique(colnames(CNVt))) # all 125 unique
length(unique(colnames(METHt))) # NEW!!!!!

# Let's just look at how many overlap 9 (this is not really necessary, just for us to have a look)
length(which(colnames(GEt) %in% colnames(CNVt))) 
length(which(colnames(CNVt) %in% colnames(GEt))) 


# Taking subsets of CNVt and GEt so that the patient data is complete across GE and CNV
GEt_2 <- GEt[,which(colnames(GEt) %in% colnames(CNVt))]
CNVt_2 <- CNVt[,which(colnames(CNVt) %in% colnames(GEt_2))]
# Now add in METH data
METHt_2 <- METHt[,which(colnames(METHt) %in% colnames(GEt_2))] 
GEt_2 <- GEt[,which(colnames(GEt) %in% colnames(METHt_2))]
CNVt_2 <- CNVt[,which(colnames(CNVt) %in% colnames(METHt_2))]