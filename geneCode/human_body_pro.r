##############################################################################
#    @Autuor: Adam.Wang 13210240112@fudan.edu.cn
#    @Date: 2015.2.8
#  
#    有用的数据是：HPM_peptide_level_expression_matrix_Kim_et_al_052914.csv 
#    通过 new_human_gene_name 进行排序，得到 human_body_pro, 
#    然后转化为适合RBR训练的 RBR_human_body_pro
#
#    @Input: input
#    @Output: outPut
##############################################################################

setwd("E:/gitspace/diseaseGenePrediction/human_body_pro");
HPM_gene_raw <- read.csv(file="HPM_gene_level_epxression_matrix_Kim_et_al_052914.csv",header=TRUE);
# 只使用17个Adult的组织protein数据进行训练
HPM_gene_raw_Adult <- HPM_gene_raw[,c(1,8:24)];
human_body_pro <- sortDataFromGeneName(new_gene_name_human2,HPM_gene_raw_Adult);
##备份
write.table(human_body_pro,file = "human_body_pro" ,col.names=FALSE,row.names=FALSE,sep=" ",quote=FALSE);
write.table(human_body_pro[,-1],file="RBR_human_body_pro",na="100000000000000000000",row.names=FALSE,col.names=FALSE,sep=",",quote=FALSE); #数据保存用于RBR训练

# 使用所有的组织protein数据进行训练

HPM_gene_raw_all <-  HPM_gene_raw;
human_body_pro_all <- sortDataFromGeneName(new_gene_name_human2,HPM_gene_raw_all);
##备份
write.table(human_body_pro_all,file = "human_body_pro_all" ,col.names=FALSE,row.names=FALSE,sep=" ",quote=FALSE);
##训练
write.table(human_body_pro_all[,-1],file="RBR_human_body_pro_all",na="100000000000000000000",row.names=FALSE,col.names=FALSE,sep=",",quote=FALSE); #数据保存用于RBR训练
