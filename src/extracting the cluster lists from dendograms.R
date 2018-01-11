# Trial to cut up dendogram and then do Kaplan-Meier

# Open and run Giovanni's BHC code including the file "selectgen.R"

# Use hc3 (dendogram for patients in "selectgen.R")

install.packages("dendextend")
library(dendextend)

groups.3 <- cutree(hc3,3) # cutting hc3 into three clusters

patientID <- colnames(cnsdf) # create a character vector with the patients ID from the data used in G's code: cnsdf (fourth CNV dataset)
cluster <- rep(0,length(patientID)) # create a vector of 0's of length the number of patients n

data.clusters <- data.frame(patientID, cluster) # create dataframe
data.clusters <- data.clusters[-1,] # remove first row
data.clusters$cluster <- groups.3 # feed in the cluster information

cluster1 <- data.clusters[which(data.clusters$cluster == 1),] # get the members of cluster 1
cluster2 <- data.clusters[which(data.clusters$cluster == 2),] # get the members of cluster 2
cluster3 <- data.clusters[which(data.clusters$cluster == 3),] # get the members of cluster 3
