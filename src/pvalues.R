p <- rep(0,length(rownames(tumor)))
for (i in 1:length(rownames(tumor))) {
  p[i] <- t.test((tumor[i,]),(normal[i,]))$p.value
}

tumor$pvalues <-  p
tumor.ordered <- tumor[order(tumor$pvalues,decreasing = F),]


data <- as.matrix(na.omit(tumor.ordered[1:1000,1:(ncol(tumor.ordered)-1)]))
nDataItems <- nrow(data)
nFeatures <- ncol(data)
itemLabels <- rownames(data)

percentiles <- FindOptimalBinning(data,itemLabels,transposeData = T,verbose = T)
discreteData <- DiscretiseData(t(data),percentiles = percentiles)
discreteData <- t(discreteData)
hc2 <- bhc(discreteData,itemLabels,verbose = T)
