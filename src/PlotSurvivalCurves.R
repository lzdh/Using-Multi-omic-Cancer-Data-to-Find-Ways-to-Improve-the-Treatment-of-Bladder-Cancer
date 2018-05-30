## R script is courtesy of Dr Richard S Savage

## Script to plot nice Kaplan Meier curves

##Function to plot survival curves for the output of a ISDF run
##NOTE:  we assume here that the timeToEvent is given in months
##
PlotSurvivalCurves <- function(titleString, clusterIDs, died, timeToEvent, itemNames, nMinItems=5){
  ##----------------------------------------------------------------------
  ## SOURCE SOME FUNCTIONS, LIBRARIES ------------------------------------
  ##----------------------------------------------------------------------
  library(survival)
  ##----------------------------------------------------------------------
  ## LABEL THE died, timeToEvent VECTORS ---------------------------------
  ##----------------------------------------------------------------------
  names(died)        <- itemNames
  names(timeToEvent) <- itemNames
  ##----------------------------------------------------------------------
  ## REMOVE ITEMS FOR WHICH WE HAVE INCOMPLETE OUTCOME INFORMATION -------
  ##----------------------------------------------------------------------
  keep        <- which(is.finite(died) & is.finite(timeToEvent))
  clusterIDs  <- clusterIDs[keep]
  died        <- died[keep]
  timeToEvent <- timeToEvent[keep]
  ##----------------------------------------------------------------------
  ## REMOVE SMALL CLUSTERS -----------------------------------------------
  ##----------------------------------------------------------------------
  uniqueIDs <- unique(clusterIDs)
  nClusters <- length(uniqueIDs)
  for (i in 1:nClusters){
    index <- which(clusterIDs==uniqueIDs[i])
    if (length(index)<nMinItems)
      clusterIDs <- clusterIDs[-index]
  }
  ##----------------------------------------------------------------------
  ## FIND USEFUL VALUES --------------------------------------------------
  ##----------------------------------------------------------------------
  itemNames      <- names(clusterIDs)
  uniqueIDs      <- unique(clusterIDs)
  nClusters      <- length(uniqueIDs)
  clusterLabels  <- vector("character", nClusters)
  for (i in 1:nClusters)
    clusterLabels[i] <- paste("Cluster", uniqueIDs[i], " (", sum(clusterIDs==uniqueIDs[i]), " items)", sep="") 
  ##----------------------------------------------------------------------
  ## EXTRACT THE RELEVANT OUTCOME VALUES ---------------------------------
  ##----------------------------------------------------------------------
  died        <- died[itemNames]
  timeToEvent <- timeToEvent[itemNames]
  ##----------------------------------------------------------------------
  ## GENERATE KAPLAN-MEIER SURVIVAL CURVES -------------------------------
  ##----------------------------------------------------------------------
  chiSquared     <- NULL
  survivalObject <- Surv(timeToEvent, died)
  survivalFit    <- survfit(survivalObject~clusterIDs)
  ##FOR 2+ CLUSTERS, COMPUTE A P-VALUE (NULL: ALL CURVES COME FROM THE SAME UNDERLYING DISTRIBUTION)
  if (nClusters>1){
    survivalDiff <- survdiff(survivalObject~clusterIDs, rho=0)#rho=1 gives Gehan-Wilcoxon test w. Peto & Peto mod
    chiSquared   <- pchisq(survivalDiff$chisq, length(survivalDiff$n)-1, lower.tail=FALSE)
  }
  ##GENERATE THE PLOT  
  plot(survivalFit, lty = 1:nClusters, conf.int=FALSE, col=palette())
  titleString = paste(titleString, " (pValue=", format(chiSquared, scientific=TRUE, digits=3), ")", sep="")
  title(titleString, xlab="number of months from diagnosis", ylab="Survival probability")
  legend("bottomright", clusterLabels, lty = 1:nClusters, box.lwd=2, cex=0.75, col=palette())
}
##*****************************************************************************
##*****************************************************************************
##----------------------------------------------------------------------
## ----------------------------------------
##----------------------------------------------------------------------
