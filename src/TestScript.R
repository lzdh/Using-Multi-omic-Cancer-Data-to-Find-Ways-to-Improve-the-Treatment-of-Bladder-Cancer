## Script courtesy of Dr. Richard S Savage

##Script to test out the generation of enrichment maps
##
##----------------------------------------------------------------------
## SOURCE THE REQUIRED FUNCTIONS ---------------------------------------
##----------------------------------------------------------------------
source("~/R/EnrichmentMaps/EnrichmentMap.R")
##----------------------------------------------------------------------
## DEFINE A SET OF GENES WITH WHICH TO TEST THE CODE -------------------
##----------------------------------------------------------------------
hits <- c("APLF", "MST1L","PRIM2","TMOD3", "SPOCK2", "OTP", "TBX4", "ZNF274", "WRAP73", "C7orf50", "TAL1", "BAI1", "WDR88",
          "PBX1", "SMYD3", "HEATR2", "PPP3CC", "RERE", "MAD1L1", "GNRH2", "CRCP","BAIAP2L1","FAM193A","WIZ","RTKN","UBE2G1",
          "TMCO3", "GMDS", "HDAC4", "CAMKK2", "ZBTB38", "SKI", "TBCD", "ACOT7")
          
          
##----------------------------------------------------------------------
## READ IN THE DATA, CLUSTERING PARTITION ------------------------------
##----------------------------------------------------------------------
##for a given cluster, we wish to identify subsets of selected features
##specifically, those that are over-expressed
##(also under-expressed?)
##does it make any sense to combine these??  i.e. just screen out genes that aren't acting unusually??
##this would make our life a bit more simple :-)
##and I think it makes sense in terms of the analysis...

##to identify unusual genes in a cluster, use median values and compare to quantiles??
##discretise the data into 3 bins; find genes that have more than a certain proportion of non-zero values...




##----------------------------------------------------------------------
## RUN THE ENRICHMENT MAP CODE -----------------------------------------
##----------------------------------------------------------------------
outputFile <- "~/R/EnrichmentMaps/testOutput.pdf"
EnrichmentMap(hits, outputFile, pValueCutoff=0.001, nTop=25)
##*****************************************************************************
##*****************************************************************************
##----------------------------------------------------------------------
## ----------------------------------------
##----------------------------------------------------------------------




