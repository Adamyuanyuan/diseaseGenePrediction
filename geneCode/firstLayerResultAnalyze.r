##############################################################################
#    @Autuor: Adam.Wang 13210240112@fudan.edu.cn
#    @Date: 2015.03.22
#  
#    analyse the first layer result of each partition
#    

#    @TODO: Use library(VennDiagram) draw the Venn diagram of each geneList
# 
#
#    @Input: geneListFile1,geneListFile2,matchedGene,topGeneNum,outPutName
#    @Output: 1. output predicted gene name file 
#             2. println matched gene
##############################################################################

analyseOfTwoGeneList <- function(geneListFile1,geneListFile2,matchedGene,topGeneNum,outPutName){
	geneList1 <- read.table(geneListFile1,header=FALSE);
	geneList2 <- read.table(geneListFile2,header=FALSE);
	resultFileName <- file(outPutName,"a"); #append file
	matchedGene <- matchedGene[,1];
	cat("---------analyse ",geneListFile1,geneListFile2,"with top ",topGeneNum,":\n",sep="");

    # get two matched gene list and print/cat them
	matchIndex1 <- match(matchedGene,geneList1[1:topGeneNum,1]);
	matchIndex1 <- na.omit(matchIndex1);
	matchName1 <- geneList1[,1][matchIndex1];
	cat(paste(geneListFile1,",top ",topGeneNum,",matched ",length(matchName1)," gene: \n",toString(matchName1),"\n",sep=""),file=resultFileName);
	cat(paste(geneListFile1,",top ",topGeneNum,",matched ",length(matchName1)," gene: \n",toString(matchName1),"\n",sep=""));

	matchIndex2 <- match(matchedGene,geneList2[1:topGeneNum,1]);
	matchIndex2 <- na.omit(matchIndex2);
	matchName2 <- geneList2[,1][matchIndex2];
	cat(paste(geneListFile2,",top ",topGeneNum,",matched ",length(matchName2)," gene: \n",toString(matchName2),"\n",sep=""),file=resultFileName);
	cat(paste(geneListFile2,",top ",topGeneNum,",matched ",length(matchName2)," gene: \n",toString(matchName2),"\n",sep=""));


    # get the list of matchName1 & matchName2
	matchIndex1_2 <- match(matchName1,matchName2);
    matchName1_2 <- matchName2[matchIndex1_2];
    matchName1_2 <- na.omit(matchName1_2);
    cat(paste("share ",length(matchName1_2)," gene: \n",toString(matchName1_2),"\n",sep=""),file=resultFileName);
	cat(paste("share ",length(matchName1_2)," gene: \n",toString(matchName1_2),"\n",sep=""));
	
	close(resultFileName);
	#return(matchName1_2);
}


# first, you should paste all file you want to analyse to a file
# filePath <- "E:\\gitspace\\diseaseGenePrediction\\firstLayer\\analyseOfAllGeneListVenn/";
# TODO: Use library(VennDiagram) draw the Venn diagram of each geneList
analyseOfAllGeneList <- function(filePath){
	setwd(filePath);
	fileNameList <- dir();
	listLength <- length(fileNameList);

	
	# 此处双重for循环不好用
	i <- 1;
	while(i <= listLength){
		geneListName <- paste("geneList",i,sep = "");
		geneListName <- read.table(fileNameList[i],header=FALSE);
		geneListName <- geneListName[1:topGeneNum,1]		
		i <- i+1;
	}

}

# first, you should paste all file you want to analyse to a file
# filePath <- "E:\\gitspace\\diseaseGenePrediction\\firstLayer\\analyseOfAllGeneList";
# Use library(VennDiagram) draw the Venn diagram of each geneList
# install.packages("gregmisc")
# library(VennDiagram)
useVennAnalyseAllGeneList <- function(filePath){
	setwd(filePath);
	fileNameList <- dir();
	listLength <- length(fileNameList);


	geneList1 <- read.table(fileNameList[1],header=FALSE);
	geneList2 <- read.table(fileNameList[2],header=FALSE);
	geneList3 <- read.table(fileNameList[3],header=FALSE);
	geneList4 <- read.table(fileNameList[4],header=FALSE);

	geneList1 <- geneList1[1:1400,1];
	geneList2 <- geneList2[1:1400,1];
	geneList3 <- geneList3[1:1400,1];
	geneList4 <- geneList4[1:1400,1];

	matchIndex1 <- match(matchedGene,geneList1[1:topGeneNum]);
	matchIndex1 <- na.omit(matchIndex1);
	matchName1 <- geneList1[matchIndex1];

	matchIndex2 <- match(matchedGene,geneList2[1:topGeneNum]);
	matchIndex2 <- na.omit(matchIndex2);
	matchName2 <- geneList2[matchIndex2];

	matchIndex3 <- match(matchedGene,geneList3[1:topGeneNum]);
	matchIndex3 <- na.omit(matchIndex3);
	matchName3 <- geneList3[matchIndex3];

	matchIndex4 <- match(matchedGene,geneList4[1:topGeneNum]);
	matchIndex4 <- na.omit(matchIndex4);
	matchName4 <- geneList4[matchIndex4];

	T1<-venn.diagram(list(eye_subsitiue=matchName1,human_body_pro_all=matchName2,Human_body_seq_max=matchName3,mouse_proteomics=matchName4),
		filename=NULL,lwd=1,lty=2,col=c('red','green','blue','yellow'),fill=c('red','green','blue','yellow'),cat.col=c('red','green','blue','yellow'),rotation.degree=90);

	grid.draw(T1);

	T2<-venn.diagram(list(eye_subsitiue=geneList1,human_body_pro_all=geneList2,Human_body_seq_max=geneList3,mouse_proteomics=geneList4),
		filename=NULL,lwd=1,lty=2,col=c('red','green','blue','yellow'),fill=c('red','green','blue','yellow'),cat.col=c('red','green','blue','yellow'),rotation.degree=90);

	grid.draw(T2);



	# 此处双重for循环不好用
	combn(listLength,3)
	i <- 2;
	while(i <= listLength){
		combnResult <- combn(listLength,i);

		j <- i + 1;
		while(j <= listLength){

			cat("========analyse",fileNameList[i],fileNameList[j],"\n",sep=" ");
			outPutName <- paste("analyseResult",i,j,sep="_");
			for(topNum in c(100,500,1400)){
				useVennAnalyseOfTwoGeneList(fileNameList[i],fileNameList[j],gene55,topNum,outPutName);
			}
			j <- j+1;
		}
		i <- i+1;
	}

}



## Use
test <- analyseOfTwoGeneList("sortedName_RBR_human_body_pro_result_12","sortedName_RBR_human_body_pro_result_11",gene55,100);

setwd(dir = "all/");
test2 <- analyseOfTwoGeneList("sortedName_RBR_human_body_pro_all_result_12","sortedName_RBR_human_body_pro_all_result_6",gene55,1400);

##debuging
# debug of analyseOfTwoGeneList(~);
topGeneNum <- 100;
geneListFile1 <- "sortedName_RBR_eye_subsitiue_result_12";
geneListFile2 <- "sortedName_RBR_human_body_pro_all_result_12";
geneList1 <- read.table(geneListFile1,header=FALSE);
geneList2 <- read.table(2,header=FALSE);
matchIndex1 <- match(matchedGene,geneList1[1:topGeneNum,1]);
matchIndex1 <- na.omit(matchIndex1);
matchName1 <- geneList1[,1][matchIndex1];
cat(paste(geneListFile1,",top ",topGeneNum,",matched ",length(matchName1)," gene: \n",toString(matchName1),sep=""));

matchIndex2 <- match(matchedGene,geneList2[1:topGeneNum,1]);
matchIndex2 <- na.omit(matchIndex2);
matchName2 <- geneList2[,1][matchIndex2];
cat(paste(geneListFile2,",top ",topGeneNum,",matched ",length(matchName2)," gene: \n",toString(matchName2),sep=""));

matchIndex1_2 <- match(matchName1,matchName2);
matchName1_2 <- matchName2[matchIndex1_2];
matchName1_2 <- na.omit(matchName1_2);
cat(paste("they have the same ",length(matchName1_2)," gene: ",toString(matchName1_2),sep=""));


# debug of analyseOfAllGeneList(~);
filePath <- "E:\\gitspace\\diseaseGenePrediction\\firstLayer\\analyseOfAllGeneList";
analyseOfAllGeneList(filePath)
for(fileName in fileNameList){

	print(fileName);
}

while(i <= listLength){

	j <- i + 1;
	while(j <= listLength){
		cat(i,j,"\n",sep=" ");
		j <- j+1;
	}
	i <- i+1;
}

	for(i,i<5,i++){
		i;
	}


i <- 1;
	while(i <= listLength){
		j <- i + 1;
		while(j <= listLength){

			cat("========analyse",fileNameList[i],fileNameList[j],"\n",sep="_");
			outPutName <- paste("analyseResult",i,j,sep=" ");
			for(topNum in seq(100,1400,100)){
				print(outPutName)
			}
			j <- j+1;
		}
		i <- i+1;
	}
