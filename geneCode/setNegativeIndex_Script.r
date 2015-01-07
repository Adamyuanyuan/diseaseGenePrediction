##############################################################
#@Autuor: Adam.Wang 13210240112@fudan.edu.cn
#@Date: 2014-12-19		
#  
#	random set negative index for svmLight and svmRank
#
#@Input: fileName
#@Output:  geneNumber of file(file lines)
###############################################################
randowSetNegativeIndex <- function(fileName){
	geneOfSvm = read.table(fileName,fill=TRUE);
	geneOfSvm = as.matrix(geneOfSvm);
	#get positive label
	positive_index = which(1==geneOfSvm[,1]);
	positive_length = length(positive_index);
	unlabel = which(0==geneOfSvm[,1]);
	#random select 3 folds negative labels
	negative_index = sample(unlabel, 3*positive_length, replace=FALSE);

	geneOfSvm[negative_index, 1] = -1;
	transductive_index = which(0==geneOfSvm[,1]);

	#view of mouse time series data
	geneOfSvm_train = file(paste(fileName,"train",sep="_"), "w");

	geneRowNum = nrow(geneOfSvm);
	for(i in 1:geneRowNum){
		cat(geneOfSvm[i,], file=geneOfSvm_train);
		cat("\n", file=geneOfSvm_train);
	}
	close(geneOfSvm_train);
	return(geneRowNum);
}
