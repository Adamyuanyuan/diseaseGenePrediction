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
sortPredictedGene <- function(geneNameFile,predictionNameFile,matchedGene,matchedResultName){
	geneName <- read.table(geneNameFile,header=FALSE);
	predictions <- read.table(predictionNameFile,header=FALSE);
	geneNamwPredicitons <- cbind(geneName,predictions);
	geneNameSorted <- geneNamwPredicitons[order(geneNamwPredicitons[,2],decreasing=T),];

	geneNameSortedOutput <- paste("sortedName",predictionNameFile,sep="_");
	write.table(geneNameSorted,file = geneNameSortedOutput ,col.names=FALSE,row.names=FALSE,sep=" ",quote=FALSE);

	resultFileName <- file(paste("matchedResult",matchedResultName,sep="_"),"a"); #append file

	topGeneNum1 <- matrix(1:14,nrow=1);
	i <- 1;
	matchedGene <- matchedGene[,1];
	for(topGene1 in seq(100,1400,100)){
		match_index1 <- match(matchedGene,geneNameSorted[1:topGene1,1]);
		match_index1 <- na.omit(match_index1);
		topGeneNum1[i]<- length(match_index1);
		i <- i+1;
	}
	print(topGeneNum1);

	cat(paste(predictionNameFile,"100-1400: \n",sep=" "),file=resultFileName);
	cat(topGeneNum1,file=resultFileName);
    cat("\n",file=resultFileName);

    topGeneNum2 <- matrix(1:20,nrow=1);
	j <- 1;
	for(topGene2 in seq(1000,20000,1000)){
		match_index2 <- match(matchedGene,geneNameSorted[1:topGene2,1]);
		match_index2 <- na.omit(match_index2);
		topGeneNum2[j]<- length(match_index2);
		j <- j+1;
	}
	print(topGeneNum2);

	cat(paste(predictionNameFile,"1000-20000: \n",sep=" "),file=resultFileName);
	cat(topGeneNum2,file=resultFileName);
    cat("\n",file=resultFileName);

    close(resultFileName);	
}


## use example : sortPredictedGene("toppgene_genome_name","toppgene_rbr_result_1",shared_cilia_human,"452") | (,,TTP_model_human,"42")

## new human_body_pro_all
setwd("E:/gitspace/diseaseGenePrediction/human_body_pro/all");
for(name in seq(1,12)){
	myPredictionList <- paste("RBR_human_body_pro_all_result",name,sep="_");
	sortPredictedGene("new_gene_name_human",myPredictionList,gene55,"body_human_pro_all55");
}

## new human_body_pro
setwd("E:/gitspace/diseaseGenePrediction/human_body_pro");
for(name in seq(1,12)){
	myPredictionList <- paste("RBR_human_body_pro_result",name,sep="_");
	sortPredictedGene("new_gene_name_human",myPredictionList,gene55,"body_human_pro55");
}

## new human_body_seq_mean
setwd("E:/gitspace/diseaseGenePrediction/human_body_seq/human_body_seq_mean")
for(name in seq(1,12)){
	myPredictionList <- paste("RBR_Human_body_seq_mean_result",name,sep="_");
	sortPredictedGene("new_gene_name_human",myPredictionList,gene55,"body_human_seq_mean55");
}

## new human_body_seq_max
setwd("E:/gitspace/diseaseGenePrediction/human_body_seq/human_body_seq_max")
for(name in seq(1,12)){
	myPredictionList <- paste("RBR_Human_body_seq_max_result",name,sep="_");
	sortPredictedGene("new_gene_name_human",myPredictionList,gene55,"body_human_seq_max55");
}

## new human_body_seq_meanD
setwd("E:/gitspace/diseaseGenePrediction/human_body_seq/human_body_seq_meanD")
for(name in seq(1,12)){
	myPredictionList <- paste("RBR_Human_body_seq_meanDespiteZero_result",name,sep="_");
	sortPredictedGene("new_gene_name_human",myPredictionList,gene55,"body_human_seq_meanD55");
}


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

##############################################################################
#    @Autuor: Adam.Wang 13210240112@fudan.edu.cn
#    @Date: 2015.2.6	
#  
#    通过已知的排序后的基因列表sortedName与目标列表进行matchedGene匹配
#
#    @Input: geneNameSorted  matchedGene 都是可以组成数据框的列表
#    @Output: outPut
##############################################################################
matchGeneNumofPredictedGene <- function(geneSortedName,matchedGene,matchedResultName){
	geneSorted <- read.table(geneSortedName,header=FALSE);	
	topGeneNum <- matrix(1:14,nrow=1);
	i <- 1;
	matchedGene <- matchedGene[,1];
	for(topGene in seq(100,1400,100)){
		match_index1 <- match(matchedGene,geneSorted[1:topGene,1]);
		match_index1 <- na.omit(match_index1);
		topGeneNum[i]<- length(match_index1);
		i <- i+1;
	}
	print(topGeneNum)
	resultFileName <- file(paste("matchedResult",matchedResultName,sep="_"),"a"); #append file
	cat(paste(geneSortedName,": \n",sep=" "),file=resultFileName);
	cat(topGeneNum,file=resultFileName);
    cat("\n",file=resultFileName);
    close(resultFileName);	
}

###use
matchGeneNumofPredictedGene("toppgene/toppgene_name_sorted",gene58,"55")；

for(topGene in seq(1000,18000,1000)){
	match_index1 <- match(matchedGene,geneSorted[1:topGene,1]);
	match_index1 <- na.omit(match_index1);
	topGeneNum[i]<- length(match_index1);
	i <- i+1;
}
print(topGeneNum)

