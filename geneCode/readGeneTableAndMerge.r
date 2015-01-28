##############################################################################
#    @Autuor: Adam.Wang 13210240112@fudan.edu.cn
#    @Date: 2015.01.07
#  
#    read three table of eye disease and merge them	
#
#    @Input: the txt file of gene table ,they have equel gene number(14177) 
#    @Output: the txt file that merged
##############################################################################

# 14 virables first col is gene name
mouse_time <- read.table(file="mouse_time",header=FALSE,fill=TRUE);
mouse_time_data <- mouse_time[,seq(2,ncol(mouse_time))];
# 12 virables first col is gene name
eye_subtissue <- read.table(file="eye_subtissue",header=FALSE,fill=TRUE); 
eye_subtissue_data <- eye_subtissue[,seq(2,ncol(eye_subtissue))];
# 18 virables first col is gene name
human_body <- read.table(file="human_body",header=FALSE,fill=TRUE);
human_body_data <- human_body[,seq(2,ncol(human_body))];

rbr_merged_MEH <- cbind(mouse_time_data,eye_subtissue_data,human_body_data);
write.table(rbr_merged_MEH,file = "rbr_merged_MEH" ,col.names=FALSE,row.names=FALSE,sep=" ",quote=FALSE);

