##############################################################################
#    @Autuor: Adam.Wang 13210240112@fudan.edu.cn
#    @Date: 2015.1.30
#  
#    input a geneList and remove duplicate gene
#
#    @Input: geneListName : file of gene name list
#			 outFileName : file of output
#    @Output: outList : write a file of merged gene outFileName
#						return(outList) is merged gene
##############################################################################

duplicateRemoval <- function(geneListName,outFileName){
	geneList <- read.table(file=geneListName,header=FALSE);
	geneList <- geneList[order(geneList[,1],decreasing=FALSE),];
	index <- duplicated(geneList);
	outList <- geneList[!index];
	print(length(outList));
	write.table(outList,file=outFileName,col.names=FALSE,row.names=FALSE,sep=" ",quote=FALSE);
	return(outList);
}


##use of this function
retNetGene <- duplicateRemoval("retnet//retnetGeneName_318.txt","newData//retNetGene");


## small function, input is two list, and return(bigList - smallList)
subtractionOfGene <- function(bigList,smallList){
	matchIndex <- match(bigList,smallList);
	nameNum <- length(matchIndex);
	subedList <- matrix(nrow=nameNum,ncol=1);
	subedListNum <- 1;
	for(i in seq(1:nameNum)){
		if(is.na(matchIndex[i])){
			subedList[subedListNum,1] <- as.character(bigList[i]);
			subedListNum = subedListNum + 1;
		}
	}
	print(subedListNum-1);
	subedList <- subedList[1:subedListNum-1,]
	return(subedList);
}
##use
subedList <- subtractionOfGene(bigList,smallList);
subedResultGene <- subtractionOfGene(subedList,needDelGene);
write.table(subedList,file="newData//subedGene",col.names=FALSE,row.names=FALSE,sep=" ",quote=FALSE);
write.table(subedResultGene,file="newData//subedResultGene",col.names=FALSE,row.names=FALSE,sep=" ",quote=FALSE);


