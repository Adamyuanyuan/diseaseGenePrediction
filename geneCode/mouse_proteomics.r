##############################################################################
#    @Autuor: Adam.Wang 13210240112@fudan.edu.cn
#    @Date: 2015.2.10
#  
#    有用的数据是：##### 1. 将 Mouse_proteomics.csv 原始数据
#    通过 new_human_gene_name 进行排序，得到 mouse_proteomics, 
#    然后转化为适合RBR训练的 RBR_mouse_proteomics
#
#    @Input: input
#    @Output: outPut
##############################################################################

setwd("E:/gitspace/diseaseGenePrediction/mouse_proteomics");
mouse_proteomics_raw <- read.csv(file="Mouse_proteomics.csv",header=TRUE);
mouse_proteomics <- sortDataFromGeneName(new_gene_name_human2,mouse_proteomics_raw);
##备份
write.table(mouse_proteomics,file = "mouse_proteomics" ,col.names=FALSE,row.names=FALSE,sep=" ",quote=FALSE);
write.table(mouse_proteomics[,-1],file="RBR_mouse_proteomics",na="100000000000000000000",row.names=FALSE,col.names=FALSE,sep=",",quote=FALSE); #数据保存用于RBR训练

## 训练-linux

###~/mouse_proteomics

rbr RBR_mouse_proteomics rbr_lable_1 RBR_mouse_proteomics RBR_mouse_proteomics_result_1 -r 1
rbr RBR_mouse_proteomics rbr_lable_1 RBR_mouse_proteomics RBR_mouse_proteomics_result_2 -r 1 -w variable.importance
rbr RBR_mouse_proteomics rbr_lable_1 RBR_mouse_proteomics RBR_mouse_proteomics_result_3 -r 1 -w variable.importance
rbr RBR_mouse_proteomics rbr_lable_1 RBR_mouse_proteomics RBR_mouse_proteomics_result_4 -r 1 -w variable.importance
rbr RBR_mouse_proteomics rbr_lable_1 RBR_mouse_proteomics RBR_mouse_proteomics_result_5 -r 1 -w variable.importance
rbr RBR_mouse_proteomics rbr_lable_1 RBR_mouse_proteomics RBR_mouse_proteomics_result_6 -r 1 -w variable.importance
rm variable.importance
rbr RBR_mouse_proteomics rbr_lable_1 RBR_mouse_proteomics RBR_mouse_proteomics_result_7 -r 1
rbr RBR_mouse_proteomics rbr_lable_1 RBR_mouse_proteomics RBR_mouse_proteomics_result_8 -r 1 -w variable.importance
rbr RBR_mouse_proteomics rbr_lable_1 RBR_mouse_proteomics RBR_mouse_proteomics_result_9 -r 2 -w variable.importance
rbr RBR_mouse_proteomics rbr_lable_1 RBR_mouse_proteomics RBR_mouse_proteomics_result_10 -r 3 -w variable.importance
rbr RBR_mouse_proteomics rbr_lable_1 RBR_mouse_proteomics RBR_mouse_proteomics_result_11 -r 3 -w variable.importance
rbr RBR_mouse_proteomics rbr_lable_1 RBR_mouse_proteomics RBR_mouse_proteomics_result_12 -r 3 -w variable.importance


## 预测
## new human_body_pro_all

for(name in seq(1,12)){
	myPredictionList <- paste("RBR_mouse_proteomics_result",name,sep="_");
	sortPredictedGene("new_gene_name_human",myPredictionList,gene55,"mouse_proteomics55");
}


############################## eye_subsitiue

setwd("E:/gitspace/diseaseGenePrediction/eye_subsitiue");
eye_subsitiue_raw <- read.csv(file="RNA_human_Eye_sub_Tissue.csv",header=TRUE);
eye_subsitiue <- sortDataFromGeneName(new_gene_name_human2,eye_subsitiue_raw);
##备份
write.table(eye_subsitiue,file = "eye_subsitiue" ,col.names=FALSE,row.names=FALSE,sep=" ",quote=FALSE);
write.table(eye_subsitiue[,-1],file="RBR_eye_subsitiue",na="100000000000000000000",row.names=FALSE,col.names=FALSE,sep=",",quote=FALSE); #数据保存用于RBR训练

## 训练-linux

###~/eye_subsitiue

rbr RBR_eye_subsitiue rbr_lable_1 RBR_eye_subsitiue RBR_eye_subsitiue_result_1 -r 1
rbr RBR_eye_subsitiue rbr_lable_1 RBR_eye_subsitiue RBR_eye_subsitiue_result_2 -r 1 -w variable.importance
rbr RBR_eye_subsitiue rbr_lable_1 RBR_eye_subsitiue RBR_eye_subsitiue_result_3 -r 1 -w variable.importance
rbr RBR_eye_subsitiue rbr_lable_1 RBR_eye_subsitiue RBR_eye_subsitiue_result_4 -r 1 -w variable.importance
rbr RBR_eye_subsitiue rbr_lable_1 RBR_eye_subsitiue RBR_eye_subsitiue_result_5 -r 1 -w variable.importance
rbr RBR_eye_subsitiue rbr_lable_1 RBR_eye_subsitiue RBR_eye_subsitiue_result_6 -r 1 -w variable.importance
rm variable.importance
rbr RBR_eye_subsitiue rbr_lable_1 RBR_eye_subsitiue RBR_eye_subsitiue_result_7 -r 1
rbr RBR_eye_subsitiue rbr_lable_1 RBR_eye_subsitiue RBR_eye_subsitiue_result_8 -r 1 -w variable.importance
rbr RBR_eye_subsitiue rbr_lable_1 RBR_eye_subsitiue RBR_eye_subsitiue_result_9 -r 2 -w variable.importance
rbr RBR_eye_subsitiue rbr_lable_1 RBR_eye_subsitiue RBR_eye_subsitiue_result_10 -r 3 -w variable.importance
rbr RBR_eye_subsitiue rbr_lable_1 RBR_eye_subsitiue RBR_eye_subsitiue_result_11 -r 3 -w variable.importance
rbr RBR_eye_subsitiue rbr_lable_1 RBR_eye_subsitiue RBR_eye_subsitiue_result_12 -r 3 -w variable.importance

## 预测
## new eye_subsitiue

for(name in seq(1,12)){
	myPredictionList <- paste("RBR_eye_subsitiue_result",name,sep="_");
	sortPredictedGene("new_gene_name_human",myPredictionList,gene55,"eye_subsitiue55");
}

