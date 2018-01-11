# Read in correct file
heatmap <- synGet("syn1571514") # can do download = false
heatmap@filePath
# [1] "C:/Users/Esther Wershof/Documents/.synapseCache/519/2099519/broad.mit.edu_BLCA_Genome_Wide_SNP_6.hg19.seg.hugo.whitelist_tumor"
data.heatmap <- read.delim(heatmap@filePath,header=TRUE)
require(gplots)

subset <- data.heatmap[1:1000,]
row.names(subset) <- subset$probe
subset <- subset[,-1]

# create heatmap
heatmap.2(as.matrix(subset))
heatmap.2(as.matrix(subset),trace="none")
heatmap.2(as.matrix(subset),trace="none",col=redgreen)
heatmap.2(as.matrix(subset),trace="none",col=redgreen(100))
heatmap.2(as.matrix(subset),trace="none",col=redgreen(100),hclustfun = function(x) hclust(x,"ave"))

# look at dendograms
d <- dist(t(subset))
hc1 <- hclust(d,"ave") # average distance
plot(hc1)
plot(hc1,hang = -1)
hc1 <- hclust(d,"single") # minimum distance
plot(hc1,hang = -1)
hc1 <- hclust(d,"complete") # maximum distance
plot(hc1,hang = -1)

# clustering according to another dendogram
heatmap.2(as.matrix(subset),trace="none",col=redgreen(100),hclustfun = function(x) hclust(x,"ave"),Colv = as.dendrogram(hc1))
View(data.heatmap)

# best way to zoom in on image is to export it as pdf