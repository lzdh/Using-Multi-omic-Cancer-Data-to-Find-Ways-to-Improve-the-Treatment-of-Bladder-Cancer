#Intersection between CNV and MUT
subset <- intersect(genes.ALL,genes.CNV[,1])

#Create an array which is true only when there is an intersection
colorbar.mutation <- rep("white",300)
colorbar.mutation[which(genes.CNV[,1] %in% subset)] <- "red"

#Intersection between CNV and EXP
subset <- intersect(genes.EXP,genes.CNV[,1])

#Create an array which is true only when there is an intersection
colorbar.expression <- rep("white",300)
colorbar.expression[which(genes.CNV[,1] %in% subset)] <- "blue"

#Intersection between CNV and MET
subset <- intersect(genes.MET[,1],genes.CNV[,1])

#Create an array which is true only when there is an intersection
colorbar.methylation <- rep("white",300)
colorbar.methylation[which(genes.CNV[,1] %in% subset)] <- "green"


rowlab <- t(cbind(colorbar.mutation,colorbar.expression,colorbar.methylation))
rownames(rowlab) <- c("mutation","expression","methylation")

heatmap.3(data,trace="none",hclustfun = function(x) hclust(x,"ave"),col=redgreen(100),breaks=colors,Rowv = hc2,Colv=hc3,RowSideColors=rowlab, RowSideColorsSize=1)
