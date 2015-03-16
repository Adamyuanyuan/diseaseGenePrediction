##############################################################################
#    @Autuor: Adam.Wang 13210240112@fudan.edu.cn
#    @Date: 2015.1.17
#  
#    make these data have same list of same gene to use merching learning method	
#
#    @Input: 1. @geneName: (file of )gene name list
#			 2. @rawData (file of )data frame, the first col is gene name
#            3. isfile 
#    @Output: @resultData: file of data frame that sorted by gene name list
##############################################################################

sortDataFromGeneName <- function(geneName,rawData,isfile = FALSE){
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
	mode(resultData[,-1]) <- "numeric"
	return(resultData);
}


## 用new_human_gene_name 进行排序，得到 human_body_pro
human_body_pro <- sortDataFromGeneName(new_gene_name_human2,HPM_gene_raw_Adult);


##
test <- sortDataFromGeneName(gene_name_human,"geneTest")

for(matchNum in seq(1:5)){
		if(is.na(matchIndex[matchNum])){
			resultData[3,1] <- geneName[3,1];
			resultData[matchNum,2:rawDataCols] <- NA;
		}else{
			resultData[matchNum,] <- rawData[matchIndex[matchNum],];
		}
	}

