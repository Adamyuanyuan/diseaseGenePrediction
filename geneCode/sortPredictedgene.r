##############################################################################
#    @Autuor: Adam.Wang 13210240112@fudan.edu.cn
#    @Date: 2015.01.03
#  
#    bind geneName and predictions, the number of gene names and predictions must
#    be equal,shared_cilia_human and was in R memory,so
#    need load("rbr.RData"); before run this R script.
#
#    @Input: geneName,predictions,matchedGene,matchedResultName
#    @Output: 1. output predicted gene name file 
#             2. println matched gene number on screen
##############################################################################
sortPredictedGene <- function(geneName,predictionName,matchedGene,matchedResultName){
	geneName <- read.table(geneName,header=FALSE);
	predictions <- read.table(predictionName,header=FALSE);
	geneNamwPredicitons <- cbind(geneName,predictions);
	geneNameSorted <- geneNamwPredicitons[order(geneNamwPredicitons[,2],decreasing=T),];
	geneNameSortedOutput <- paste("sortedName",predictionName,sep="_");
	write.table(geneNameSorted,file = geneNameSortedOutput ,col.names=FALSE,row.names=FALSE,sep=" ",quote=FALSE);

	topGeneNum <- matrix(1:14,nrow=1);
	i <- 1;
	matchedGene <- matchedGene[,1];
	for(topGene in seq(100,1400,100)){
		match_index1 <- match(matchedGene,geneNameSorted[1:topGene,1]);
		match_index1 <- na.omit(match_index1);
		topGeneNum[i]<- length(match_index1);
		i <- i+1;
	}
	topGeneNum
	resultFileName <- file(paste("matchedResult",matchedResultName,sep="_"),"a"); #append file
	cat(paste(predictionName,": \n",sep=" "),file=resultFileName);
	cat(topGeneNum,file=resultFileName);
    cat("\n",file=resultFileName);
    close(resultFileName);	
}

## use example : sortPredictedGene("toppgene_genome_name","toppgene_rbr_result_1",shared_cilia_human,"452") | (,,TTP_model_human,"42")

## shared_cilia_human <- read.table("shared_cilia_human",header=FALSE);
## TTP_model_human <- read.table("TTP_model_human",header=FALSE);
for(name in seq(7,12)){
	myPredictionName <- paste("toppgene_rbr_result",name,sep="_");
	sortPredictedGene("toppgene_genome_name",myPredictionName,shared_cilia_human,"452");
	sortPredictedGene("toppgene_genome_name",myPredictionName,TTP_model_human,"42");
}

for(name in seq(1,6)){
	myPredictionName <- paste("toppgene_rbr_result",name,sep="_");
	sortPredictedGene("toppgene_genome_name",myPredictionName,TTP_model_human,"42");
}
