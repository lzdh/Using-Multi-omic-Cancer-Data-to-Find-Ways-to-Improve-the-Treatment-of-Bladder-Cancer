# You can find "Clustering patients.csv" on the googledrive under data" - not available here
clusteringtable <- read.csv("Clustering patients.csv", TRUE, ",")
clusteringtable <- clusteringtable[1:95,1:4]

# create an empty table with columns listing the patients and rows listing the patients (like an adjacency matrix)
matrixc <- data.frame(matrix(ncol = nrow(clusteringtable), nrow = nrow(clusteringtable)))

for (i in 1: nrow(matrixc)){
  colnames(matrixc)[i] <- as.character(clusteringtable$patient_id[i])
  rownames(matrixc)[i] <- as.character(clusteringtable$patient_id[i])
}

# We define a "distance" function between any two patients. The distance is 0 if they fall in the same cluster in all three datatypes,
# 1 if they fall into different clusters for 1 datatype etc.

for (i in 1:nrow(matrixc)){
  for (j in 1:nrow(matrixc)){
matrixc[i,j] <-3

if (clusteringtable$meth_clusters[i]==clusteringtable$meth_clusters[j]){
  matrixc[i,j] <- matrixc[i,j] - 1
}

if (clusteringtable$CNV_clusters[i]==clusteringtable$CNV_clusters[j]){
  matrixc[i,j] <- matrixc[i,j] - 1
}

if (clusteringtable$GE_clusters[i]==clusteringtable$GE_clusters[j]){
  matrixc[i,j] <- matrixc[i,j] - 1
}
}
}
View(matrixc)

# Create a dendogram to show this 
 d <- dist(as.matrix(matrixc))   # find distance matrix 
 hc <- hclust(d, "average")                # apply hirarchical clustering 
 plot(hc, hang = -1)                       # plot the dendrogram



# This is me just mucking around with trying to make a nice graph from the dendogram info can be found here:
# http://gastonsanchez.com/blog/how-to/2014/06/29/Graph-from-dendrogram.html
library(ape)

# convert 'hclust' to 'phylo' object
phylo_tree = as.phylo(hc)

# get edges
graph_edges = phylo_tree$edge

# library igraph
library(igraph)

# get graph from edge list
graph_net = graph.edgelist(graph_edges)

# plot graph
plot(graph_net)



