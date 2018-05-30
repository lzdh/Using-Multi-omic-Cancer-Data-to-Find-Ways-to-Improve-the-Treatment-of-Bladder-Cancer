# load the necessary libraries
require(gplots)

# Read in correct file
heatmap <- synGet("syn1571514") # can do download = false
data.heatmap <- read.delim(heatmap@filePath,header=TRUE)

# pick the first 1000 observations 
subset <- data.heatmap[1:1000,]
row.names(subset) <- subset$probe
subset <- subset[,-1]

# create heatmap and play with what to display
heatmap.2(as.matrix(subset))
heatmap.2(as.matrix(subset),trace="none")
heatmap.2(as.matrix(subset),trace="none",col=redgreen)
heatmap.2(as.matrix(subset),trace="none",col=redgreen(100))
heatmap.2(as.matrix(subset),trace="none",col=redgreen(100),hclustfun = function(x) hclust(x,"ave"))

# look at dendograms we get from hierarchical clustering
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
