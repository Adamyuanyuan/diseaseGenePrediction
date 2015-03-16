##############################################################################
#    @Autuor: Adam.Wang 13210240112@fudan.edu.cn
#    @Date: 2015.1.28
#  
#    AdamWang#
#
#    @Input: input
#    @Output: outPut
##############################################################################

setwd("E:/gitspace/diseaseGenePrediction")

## a function of apply of data.frame

meanDespiteZero <- function(x){
	fpkmNum <- 3;
	for(fpkm in x){
		if(0==fpkm){
			fpkmNum = fpkmNum - 1;
		}
	}
	return(sum(x)/fpkmNum)
}


## 这个函数输入一个数据框，第一列为基因名 ，将基因名相同的行各项数据求平均，返回的是没有基因名的数据，最后需要与基因名进行绑定
averageGeneNameFrame <- function(geneDataFrame){
	geneName <- geneDataFrame[,1];
	ncols <- ncol(geneDataFrame);
	data <- geneDataFrame[,1:ncols];
	data <- data[order(retina_fpkm_three[,1],decreasing=FALSE),];
	firstCol <- data[,1];
	data <- as.matrix(data);
	geneDataRows <- length(geneName)
	newData <- matrix(nrow=nrow(data),ncol=ncol(data))
	index <- duplicated(geneName);
	newDataNum <- 1;
	rowNum <- 1;
	##为了简化运算，我这里只默认有两个基因名称相同，最后在运用此函数多次即可得到结果,只要geneName 与 返回的data 长度相同，说明结果正确
	while(rowNum <= geneDataRows){
		if(!index[rowNum]){
			newData[newDataNum,] <- data[rowNum,];
			newDataNum = newDataNum + 1;
		}else{
			newData[newDataNum-1,] <- apply(data[(rowNum-1):rowNum,],2,mean);
		}
		rowNum = rowNum + 1;
	}
	print(newDataNum);
	newData <- newData[1:newDataNum,]	
	return(newData);
}

##
retina_fpkm_three <- read.table(file="newData//retina_fpkm_three",header=FALSE)
retina_fpkm_three <- as.matrix(retina_fpkm_three);
sorted_retina_fpkm_three <- retina_fpkm_three[order(retina_fpkm_three[,1],decreasing=FALSE),];
retina_fpkm_rows <- nrow(sorted_retina_fpkm_three);
retina_fpkm_cols <- ncol(sorted_retina_fpkm_three);
resultFpkmData <- matrix(nrow=retina_fpkm_rows,ncol=retina_fpkm_cols);

resultFpkmDataIndex <- 1;
for(rowNum in seq(1:retina_fpkm_rows)){
	## if (all three fpkm == 0 ){write}
	if(!(0 == as.numeric(sorted_retina_fpkm_three[rowNum,2]) && 0 == as.numeric(sorted_retina_fpkm_three[rowNum,3]) && 0 == as.numeric(sorted_retina_fpkm_three[rowNum,4]))){
		resultFpkmData[resultFpkmDataIndex,] <- sorted_retina_fpkm_three[rowNum,]
		resultFpkmDataIndex <- resultFpkmDataIndex + 1;
	}
}
resultFpkmData <- resultFpkmData[seq(1:(resultFpkmDataIndex-1)),]
write.table(resultFpkmData,file = "newData//resultFpkmData_three" ,col.names=FALSE,row.names=FALSE,sep=" ",quote=FALSE);

resultFpkmData_three <- read.table(file="newData//resultFpkmData_three",header=FALSE)

resultFpkmData_mean <- apply(resultFpkmData_three[,2:4],1,mean);
resultFpkmData_max <- apply(resultFpkmData_three[,2:4],1,max);
resultFpkmData_meanD <- apply(resultFpkmData_three[,2:4],1,meanDespiteZero);

resultFpkmData_mmm <- cbind(resultFpkmData_three,resultFpkmData_mean,resultFpkmData_max,resultFpkmData_meanD);
write.table(resultFpkmData_mmm,file = "newData//resultFpkmData_mmm" ,col.names=FALSE,row.names=FALSE,sep=" ",quote=FALSE);


new_gene_name_human <- resultFpkmData_mmm[,1]
#write.table(new_gene_name_human,file="newData//new_gene_name_human",row.names=FALSE,col.names = FALSE,sep=" ",quote=FALSE)

index <- duplicated(new_gene_name_human)
new_gene_name_human <- new_gene_name_human[!index]

new_resultFpkmData_mmm <- averageGeneNameFrame(resultFpkmData_mmm);


##cbind gene name and result
new_resultFpkmData_mmm <- cbind(as.character(new_gene_name_human),new_resultFpkmData_mmm)；
write.table(test2,file = "newData//new_resultFpkmData_mmm" ,col.names=FALSE,row.names=FALSE,sep=" ",quote=FALSE);
# write gene list
write.table(test,file="newData//new_gene_name_human",row.names=FALSE,col.names = FALSE,sep=" ",quote=FALSE);

new_resultFpkmData_mmm <- read.table(file="newData/new_resultFpkmData_mmm",header = FALSE)；
new_resultFpkmData_mmm <- new_resultFpkmData_mmm[order(new_resultFpkmData_mmm[,1],decreasing=FALSE),];

## delete genes that contain ‘-’ such as A1BG-AS1
contain_index <- grep(pattern = "-",new_resultFpkmData_mmm[,1]);
new2_resultFpkmData_mmm <- new_resultFpkmData_mmm[-contain_index,]
new_gene_name_human <- new2_resultFpkmData_mmm[,1];
write.table(new2_resultFpkmData_mmm,file = "newData//new_resultFpkmData_mmm" ,col.names=FALSE,row.names=FALSE,sep=" ",quote=FALSE);
write.table(new2_resultFpkmData_mmm[,1],file="newData//new_gene_name_human",row.names=FALSE,col.names = FALSE,sep=" ",quote=FALSE);




## 判断166个基因与58个基因在不在new_gene_name_human中
gene166 <- read.table(file="newData/positive_name_human",header = FALSE);
gene58 <- read.table(file="newData/subedResultGene",header = FALSE);

matchIndex166 <- match(gene166[,1],new_gene_name_human);

matchIndex58 <- match(gene58[,1],new_gene_name_human);


### average

resultFpkmData_three <- read.table(file="newData//resultFpkmData_three",header=FALSE)

###test
0==sorted_retina_fpkm_three[1,2] && 0==sorted_retina_fpkm_three[1,3] && 0==sorted_retina_fpkm_three[1,4]
0 == as.numeric(sorted_retina_fpkm_three[1,2]) && 0 == as.numeric(sorted_retina_fpkm_three[1,2]) && 0 == as.numeric(sorted_retina_fpkm_three[1,2])

# 测试第一个名称相同的基因位置
for(i in seq(1:10000)){
	if(index[i]){
		print(i);
		break;
	}
}

# 用 aggregate 函数处理Human body map RNA-Seq.csv 数据
Human_body_raw <- read.csv(file="newData/Human_body_no_retina.csv",header = TRUE)
Human_body_raw2 <- Human_body_raw[,-1]
Human_body_merged <- aggregate(Human_body_raw2[,-1],list(Human_body_raw2$gene_id),mean);
write.csv(Human_body_merged,file="newData//Human_body_merged.csv",row.names=FALSE);
write.table(Human_body_merged,file="newData//Human_body_merged_noheader",row.names=FALSE,col.names=FALSE,sep=" ",quote=FALSE);

# 用 new_gene_name_human 对处理后的 Human_body_merged 根据第一列 Group.1 进行排序
Human_body_merged_sorted <- sortDataFromGeneName(new_gene_name_human2,"newData//Human_body_merged_noheader");
write.table(Human_body_merged_sorted,file="newData//Human_body_merged_sorted",row.names=FALSE,col.names=FALSE,sep=" ",quote=FALSE);

# 将human_body 数据合并：

Human_body_seq_mean <- cbind(Human_body_merged_sorted,new_resultFpkmData_mmm[,2]);
write.table(Human_body_seq_mean,file="newData//Human_body_seq_mean",row.names=FALSE,col.names=FALSE,sep=" ",quote=FALSE); #数据保存用于备份
write.table(Human_body_seq_mean[,-1],file="newData//RBR_Human_body_seq_mean",na="100000000000000000000",row.names=FALSE,col.names=FALSE,sep=",",quote=FALSE); #数据保存用于RBR训练


Human_body_seq_max <- cbind(Human_body_merged_sorted,new_resultFpkmData_mmm[,3]);
write.table(Human_body_seq_max,file="newData//Human_body_seq_max",row.names=FALSE,col.names=FALSE,sep=" ",quote=FALSE); #数据保存用于备份
write.table(Human_body_seq_max[,-1],file="newData//RBR_Human_body_seq_max",na="100000000000000000000",row.names=FALSE,col.names=FALSE,sep=",",quote=FALSE); #数据保存用于RBR训练

Human_body_seq_meanDespiteZero <- cbind(Human_body_merged_sorted,new_resultFpkmData_mmm[,4]);
write.table(Human_body_seq_meanDespiteZero,file="newData//Human_body_seq_meanDespiteZero",row.names=FALSE,col.names=FALSE,sep=" ",quote=FALSE); #数据保存用于RBR训练
write.table(Human_body_seq_meanDespiteZero[,-1],file="newData//RBR_Human_body_seq_meanDespiteZero",na="100000000000000000000",row.names=FALSE,col.names=FALSE,sep=",",quote=FALSE); #数据保存用于RBR训练

# 生成lable数据： rbr_lable_1 共有165个1

matchIndex166_2 <- match(new_gene_name_human,gene166[,1])
rbr_lable_1 <- ifelse(is.na(matchIndex166_2),0,1)
write.table(rbr_lable_1,file="newData/rbr_lable_1",col.names=FALSE,row.names=FALSE,sep=" ",quote=FALSE)








##下面的方法不行
new_gene_name_human2 <- read.table(file="newData/new_gene_name_human",header = FALSE)
rownames(Human_body_raw) <- Human_body_raw[,1]
data_res = Human_body_raw[new_gene_name_human2[,1],]
##上面的方法不行

test2 <- read.table(file="newData/Human_body_no_retina.csv",header = TRUE)
write.table(test2[-1,],file = "newData//test2" ,col.names=FALSE,row.names=FALSE,sep=" ",quote=FALSE);
test3 <- read.table(file="newData/test2",header = TRUE)
test <- aggregate(data,by=list(data$V2),FUN=mean);

test4 <- aggregate(test3[,-1],list(test3$V2),mean);
