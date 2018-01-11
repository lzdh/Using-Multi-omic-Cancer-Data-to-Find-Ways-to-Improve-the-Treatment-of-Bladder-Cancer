# R script for survival analysis
setwd("C:/Users/Esther Wershof/Dropbox/Group project")
library(survival)

# import relevant file
ge <- read.csv("ClinicalDataAndClusteringAllDataTypes.csv", header=TRUE)
ge <- ge[1:87,]

# Remove very small clusters of size <= 5, this leaves 5 clusters

for (i in 1: max(ge$GE_CLUSTER)){
  if (length(which(ge$GE_CLUSTER ==i)) <=5){
    ge <- ge[-c(which(ge$GE_CLUSTER == i)),]
  }
}
# create survival object (days to last follow-up, vital status)
s <- Surv(ge$days_to_last_followup, ge$vital_status)

# get the Kaplan Meier curves for the relevant clusters
km <- survfit(s~GE_CLUSTER, data = ge)

# log rank test (H0: ALL CURVES COME FROM THE SAME DISTRIBUTION)
survivalDiff <- survdiff(s~GE_CLUSTER, rho = 0, data = ge) # rho = 0 gives no weight to any of the values
chiSquared   <- pchisq(survivalDiff$chisq, 4, lower.tail=FALSE) # second entry is number of clusters-1

# plot the KM curves with legend and title
par(mar=c(5,5,2,3))
plot(km, xlab = "Days", ylab = "Survival Probability", col = c("red", "blue", "chocolate", "lightpink","darkgreen"),
     lwd = 4, font = 2, cex.lab = 1.9, cex.axis = 2)
legend("topright", c("C1", "C2", "C6", "C7", "C10"), lty = 1,lwd= 4,
       col = c("red", "blue", "chocolate", "lightpink", "darkgreen"), bty = "n", text.font=2,cex=1.5)
titleString = paste("Survival Probability of GE clusters", 
                    " (pValue=", format(chiSquared, scientific=TRUE, digits=3), ")",sep="")
title(titleString)

# pairwise comparison, input values i and j to be the two cluster numbers you want to compare
i = 7 
j = 10
gecomp <- ge[c(which(ge$GE_CLUSTER == i), which(ge$GE_CLUSTER == j)),]
scomp <- Surv(gecomp$days_to_last_followup, gecomp$vital_status)
# 
# # get the Kaplan Meier curves for the relevant clusters
# kmcomp <- survfit(scomp~GE_CLUSTER, data = gecomp)

# log rank test (H0: ALL CURVES COME FROM THE SAME DISTRIBUTION)
survivalDiff <- survdiff(scomp~GE_CLUSTER, rho = 0, data = gecomp) # rho = 0 gives no weight to any of the values
chiSquared   <- pchisq(survivalDiff$chisq, 4, lower.tail=FALSE) # second entry is number of clusters-1
survivalDiff

# aggregate comparison (Cluster 3 looks quite diferent to the rest). Input j as the cluster which you wish to compare to all the others
j=3
for (i in 1: nrow(ge)){
  if (ge$GE_CLUSTER[i] == j){
    ge$X[i] = j
  }
  else {ge$X[i] = j+1}
}

km <- survfit(s~X, data = ge)

# log rank test (H0: ALL CURVES COME FROM THE SAME DISTRIBUTION)
survivalDiff <- survdiff(s~X, rho = 0, data = ge) # rho = 0 gives no weight to any of the values
chiSquared   <- pchisq(survivalDiff$chisq, 4, lower.tail=FALSE) # second entry is number of clusters-1
survivalDiff