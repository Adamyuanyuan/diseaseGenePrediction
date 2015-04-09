##############################################################################
#    @Autuor: Adam.Wang 13210240112@fudan.edu.cn
#    @Date: 2015.4.8
#  
#    handle mouse_time_seq data and use RBR to training it 
#
#    @Input: input
#    @Output: outPut
##############################################################################

# First: change mouse name to human name
setwd(dir = "../mouse_time_seq/ ")
mouse2HumanGeneTable <- read.table("FULL_merged_table.txt",header=TRUE);
mouse2HumanGeneMap <- mouse2HumanGeneTable[,c(1,5)];
human2MouseGeneMap[,c(1,2)] <- human2MouseGeneMap[,c(2,1)];
new_gene_name_mouse2 <- sortNameFromGeneName(new_gene_name_human2,human2MouseGeneMap);


sortNameFromGeneName <- function(geneName,rawData,isfile = FALSE){
	if(isfile){
		geneName <- read.table(geneName,header=FALSE);
		rawData <- read.table(rawData,header=FALSE);
	}
	#geneName <- read.table(geneName,header=FALSE);
	geneName <- geneName;
	#rawData <- read.table(rawData,header=FALSE);
	rawData <- as.matrix(rawData);
	matchIndex <- match(geneName[,1],rawData[,1]);
	geneNamerows <- nrow(geneName);
	rawDataCols <- ncol(rawData);
	resultData <- matrix(nrow=geneNamerows,ncol=rawDataCols);

	for(matchNum in seq(1:geneNamerows)){
		if(is.na(matchIndex[matchNum])){
			resultData[matchNum,1] <- as.character(geneName[matchNum,1]);
			resultData[matchNum,2:rawDataCols] <- NA;
		}else{
			resultData[matchNum,] <- rawData[matchIndex[matchNum],];
		}
	}
	return(resultData);
}