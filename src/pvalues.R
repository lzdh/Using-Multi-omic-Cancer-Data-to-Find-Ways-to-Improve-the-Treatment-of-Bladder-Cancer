
# perform t-test to select the genes
p <- rep(0,length(rownames(tumor)))
for (i in 1:length(rownames(tumor))) {
  p[i] <- t.test((tumor[i,]),(normal[i,]))$p.value
}

tumor$pvalues <-  p
# need to do Bonferroni correction!!!!
tumor.ordered <- tumor[order(tumor$pvalues,decreasing = F),]

# select only the data that corresponds to the 1000 genes
data <- as.matrix(na.omit(tumor.ordered[1:1000,1:(ncol(tumor.ordered)-1)]))
nDataItems <- nrow(data)
nFeatures <- ncol(data)
itemLabels <- rownames(data)

# set up to use Bayesian Hierarchical Clustering (BHC) code
percentiles <- FindOptimalBinning(data,itemLabels,transposeData = T,verbose = T)
discreteData <- DiscretiseData(t(data),percentiles = percentiles)
discreteData <- t(discreteData)
hc2 <- bhc(discreteData,itemLabels,verbose = T)
