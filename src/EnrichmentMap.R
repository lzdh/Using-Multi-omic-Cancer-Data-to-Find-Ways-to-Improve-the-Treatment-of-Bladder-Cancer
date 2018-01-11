##Function to generate an Enrichment Map, given an input list of human genes
##
##NOTE:  we may also wish to do this for feature sets that are not genes??
##do we want to start with just GO and KEGG analyses??  Then move on to more general cases?
##
EnrichmentMap <- function(hits, outputFile, pValueCutoff=0.05, nTop=20){
  ##----------------------------------------------------------------------
  ##-- GET THE LIBRARIES WE NEED HERE ------------------------------------
  ##----------------------------------------------------------------------
  library(GO.db)
  library(KEGG.db)
  library(HTSanalyzeR)
  library(org.Hs.eg.db)
  source("~/R/EnrichmentMaps/viewEnrichmentMap.rss.R")
  ##----------------------------------------------------------------------
  ## FIND USEFUL VALUES --------------------------------------------------
  ##----------------------------------------------------------------------
  phenotype        <- rep(1, length(hits))
  names(phenotype) <- hits
  phenotype        <- phenotype[(names(phenotype)!='')&(!is.na(names(phenotype)))]
  hits             <- hits[hits!='' & !is.na(hits)]
  ##----------------------------------------------------------------------
  ## FIND THE GENE SETS FOR KEGG AND GO ----------------------------------
  ##----------------------------------------------------------------------
  GO_BP    <- GOGeneSets(species="Hs", ontologies=c("BP"))
  GO_MF    <- GOGeneSets(species="Hs", ontologies=c("MF"))
  GO_CC    <- GOGeneSets(species="Hs", ontologies=c("CC"))
  kegg     <- KeggGeneSets("Hs")
  GeneSets <- list(GO.BiologicalProcess=GO_BP,
                   GO.MolecularFunction=GO_MF,
                   GO.CellularComponent=GO_CC,
                   KeggPathway=kegg)
  ##----------------------------------------------------------------------
  ## RUN THE ENRICHMENT ANALYSIS -----------------------------------------
  ##----------------------------------------------------------------------
  gsca <- new("GSCA", listOfGeneSetCollections=GeneSets, geneList=phenotype, hits=hits)
  gsca <- preprocess(gsca, species="Hs", initialIDs="Symbol", keepMultipleMappings=TRUE, duplicateRemoverMethod="min",  orderAbsValue=FALSE)
  gsca <- analyze(gsca, para=list(pValueCutoff=0.05, pAdjustMethod="BH", nPermutations=1,minGeneSetSize=1, exponent=1))
  gsca <-appendGSTerms(gsca, goGSCs=c("GO.BiologicalProcess", "GO.MolecularFunction","GO.CellularComponent"),
                       keggGSCs=c("KeggPathway"))
  ##----------------------------------------------------------------------
  ## MAKE SOME ADJUSTMENTS FOR THE PLOTTING ------------------------------
  ##----------------------------------------------------------------------
#  dum = viewEnrichMap.rss(gsca, resultName='HyperGeo.results', gscs="GO.BiologicalProcess",
#                          gsNameType="term",  allSig=FALSE, ntop=nTop, displayEdgeLabel=FALSE)
  ##----------------------------------------------------------------------
  ## OUTPUT THE ENRICHMENT MAPS TO FILE ----------------------------------
  ##----------------------------------------------------------------------
  pdf(outputFile) 
  viewEnrichMap.rss(gsca, resultName='HyperGeo.results', gscs="GO.BiologicalProcess",
                gsNameType="term",  allSig=FALSE, ntop=20, displayEdgeLabel=FALSE)
  viewEnrichMap.rss(gsca, resultName='HyperGeo.results', gscs="GO.MolecularFunction",
                gsNameType="term",  allSig=FALSE, ntop=20, displayEdgeLabel=FALSE)
  viewEnrichMap.rss(gsca, resultName='HyperGeo.results', gscs="GO.CellularComponent",
                gsNameType="term",  allSig=FALSE, ntop=20, displayEdgeLabel=FALSE)
  viewEnrichMap.rss(gsca, resultName='HyperGeo.results', gscs="KeggPathway",
                gsNameType="term",  allSig=FALSE, ntop=20, displayEdgeLabel=FALSE)
  dev.off()
}
##*****************************************************************************
##*****************************************************************************
##----------------------------------------------------------------------
## ----------------------------------------
##----------------------------------------------------------------------


