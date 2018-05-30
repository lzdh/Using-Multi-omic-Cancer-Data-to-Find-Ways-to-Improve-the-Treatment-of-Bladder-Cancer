# R script to run Bayesian Hierarchical Clustering (BHC) with the most relevant genes

# only relevant genes

genelist <- genes$gene[1:500]

subset <- sapply(genelist,grep,rownames(cnsdf))
subset <- unique(rapply(subset,function(x) head(x,1)))
cnsdf[subset,]

# set up the colours for the heatmap
colors = c(seq(-2,-0.4,length=33),seq(-0.4,0.4,length=35),seq(0.4,2,length=33))
#heatmap.2(as.matrix(cnsdf[subset,]),trace="none",hclustfun = function(x) hclust(x,"ave"),col=redgreen(100),breaks=colors)

# Find Dendrogram for patients
data <- t(as.matrix(na.omit(cnsdf[subset,])))
nDataItems <- nrow(data)
nFeatures <- ncol(data)
itemLabels <- rownames(data)

# run BHC for patients
percentiles <- FindOptimalBinning(data,itemLabels,transposeData = T,verbose = T)
discreteData <- DiscretiseData(t(data),percentiles = percentiles)
discreteData <- t(discreteData)
hc3 <- bhc(discreteData,itemLabels,verbose = T)

# Find Dendrogram for genes
data <- t(data) #this is not the transpose
nDataItems <- nrow(data)
nFeatures <- ncol(data)
itemLabels <- rownames(data)
                        
# run BHC for genes
percentiles <- FindOptimalBinning(data,itemLabels,transposeData = T,verbose = T)
discreteData <- DiscretiseData(t(data),percentiles = percentiles)
discreteData <- t(discreteData)
hc2 <- bhc(discreteData,itemLabels,verbose = T)

#heatmap.2(data,trace="none",hclustfun = function(x) hclust(x,"ave"),col=topo.colors(100),breaks=colors,Rowv = hc2,Colv=hc3)
heatmap.2(data,trace="none",hclustfun = function(x) hclust(x,"ave"),col=redgreen(100),breaks=colors,Rowv = hc2,Colv=hc3)


