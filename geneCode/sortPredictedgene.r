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
	myPredictionList <- paste("toppgene_rbr_result",name,sep="_");
	sortPredictedGene("toppgene_genome_name",myPredictionList,shared_cilia_human,"452");
	sortPredictedGene("toppgene_genome_name",myPredictionList,TTP_model_human,"42");
}

for(name in seq(1,6)){
	myPredictionList <- paste("merged_MEH_rbr_result",name,sep="_");
	sortPredictedGene("gene_name_human",myPredictionList,shared_cilia_human,"MEH452");
	sortPredictedGene("gene_name_human",myPredictionList,TTP_model_human,"MEH42");		
}

for(name in seq(7,12)){
	myPredictionList <- paste("merged_MEH_rbr_result",name,sep="_");
	sortPredictedGene("gene_name_human",myPredictionList,shared_cilia_human,"MEH452");
	sortPredictedGene("gene_name_human",myPredictionList,TTP_model_human,"MEH42");	
}

for(name in seq(1,6)){
	myPredictionList <- paste("merged_MEH_rbr_result_m",name,sep="_");
	sortPredictedGene("gene_name_human",myPredictionList,shared_cilia_human,"mouse452");
	sortPredictedGene("gene_name_human",myPredictionList,TTP_model_human,"mouse42");
}

sortPredictedGene("gene_name_human","merged_MEH_rbr_result_1",shared_cilia_human,"452--")

for(name in seq(1,5)){
	myPredictionList <- paste("merged_MEH_rbr_result_human",name,sep="_");
	sortPredictedGene("gene_name_human",myPredictionList,shared_cilia_human,"human452");
	sortPredictedGene("gene_name_human",myPredictionList,TTP_model_human,"human42");
}

for(name in seq(1,5)){
	myPredictionList <- paste("merged_MEH_rbr_result_eye",name,sep="_");
	sortPredictedGene("gene_name_human",myPredictionList,shared_cilia_human,"eye452");
	sortPredictedGene("gene_name_human",myPredictionList,TTP_model_human,"eye42");
}

for(name in seq(1,6)){
	myPredictionList <- paste("merged_EH_rbr_result",name,sep="_");
	sortPredictedGene("gene_name_human",myPredictionList,shared_cilia_human,"EH452");
	sortPredictedGene("gene_name_human",myPredictionList,TTP_model_human,"EH452");
}

#the gene number that in 14177 gene and 452 gene
gene_name_human <- read.table("gene_name_human",header=FALSE);

match_index3 <- match(shared_cilia_human[,1],gene_name_human[,1]);
match_index3 <- na.omit(match_index3);
sharedGeneNum<- length(match_index3);

# crx 
for(name in seq(1,6)){
	myPredictionList <- paste("crx_rbr_result",name,sep="_");
	sortPredictedGene("gene_name_human",myPredictionList,shared_cilia_human,"crx452");
	sortPredictedGene("gene_name_human",myPredictionList,TTP_model_human,"crx42");
}

# protein_score

