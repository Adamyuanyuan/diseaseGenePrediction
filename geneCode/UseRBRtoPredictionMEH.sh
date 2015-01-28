#!bin/bash

### R write table to rbr format
write.table(crx,file="crx_rbr_data",sep=",",na="100000000000000000000",row.names=FALSE,col.names=FALSE)
### Use RBR to predict our data 1
rbr rbr_merged_MEH rbr_merged_label_1 rbr_merged_MEH merged_MEH_rbr_result_1 -r 1
rbr rbr_merged_MEH rbr_merged_label_1 rbr_merged_MEH merged_MEH_rbr_result_2 -r 1 -w variable.importance
rbr rbr_merged_MEH rbr_merged_label_1 rbr_merged_MEH merged_MEH_rbr_result_3 -r 2 -w variable.importance
rbr rbr_merged_MEH rbr_merged_label_1 rbr_merged_MEH merged_MEH_rbr_result_4 -r 3 -w variable.importance
rbr rbr_merged_MEH rbr_merged_label_1 rbr_merged_MEH merged_MEH_rbr_result_5 -r 3 -w variable.importance
rbr rbr_merged_MEH rbr_merged_label_1 rbr_merged_MEH merged_MEH_rbr_result_6 -r 3 -w variable.importance

### Use RBR to predict our data 2
rbr rbr_merged_MEH rbr_merged_label_1 rbr_merged_MEH merged_MEH_rbr_result_7 -r 1
rbr rbr_merged_MEH rbr_merged_label_1 rbr_merged_MEH merged_MEH_rbr_result_8 -r 1 -w variable.importance
rbr rbr_merged_MEH rbr_merged_label_1 rbr_merged_MEH merged_MEH_rbr_result_9 -r 1 -w variable.importance
rbr rbr_merged_MEH rbr_merged_label_1 rbr_merged_MEH merged_MEH_rbr_result_10 -r 1 -w variable.importance
rbr rbr_merged_MEH rbr_merged_label_1 rbr_merged_MEH merged_MEH_rbr_result_11 -r 1 -w variable.importance
rbr rbr_merged_MEH rbr_merged_label_1 rbr_merged_MEH merged_MEH_rbr_result_12 -r 1 -w variable.importance
rbr rbr_merged_MEH rbr_merged_label_1 rbr_merged_MEH merged_MEH_rbr_result_13 -r 1 -w variable.importance

### mouse_time_data
rbr mouse_time_data rbr_merged_label_1 mouse_time_data merged_MEH_rbr_result_mouse_1 -r 1
rbr mouse_time_data rbr_merged_label_1 mouse_time_data merged_MEH_rbr_result_mouse_2 -r 2 -w variable.importance;rbr mouse_time_data rbr_merged_label_1 mouse_time_data merged_MEH_rbr_result_mouse_3 -r 3 -w variable.importance;rbr mouse_time_data rbr_merged_label_1 mouse_time_data merged_MEH_rbr_result_mouse_4 -r 3 -w variable.importance;rbr mouse_time_data rbr_merged_label_1 mouse_time_data merged_MEH_rbr_result_mouse_5 -r 3 -w variable.importance

###human_body)data

rbr human_body_rbr_data rbr_merged_label_1 human_body_rbr_data merged_MEH_rbr_result_human_1 -r 1
rbr human_body_rbr_data rbr_merged_label_1 human_body_rbr_data merged_MEH_rbr_result_human_2 -r 2 -w variable.importance;rbr human_body_rbr_data rbr_merged_label_1 human_body_rbr_data merged_MEH_rbr_result_human_3 -r 3 -w variable.importance;rbr human_body_rbr_data rbr_merged_label_1 human_body_rbr_data merged_MEH_rbr_result_human_4 -r 3 -w variable.importance;rbr human_body_rbr_data rbr_merged_label_1 human_body_rbr_data merged_MEH_rbr_result_human_5 -r 3 -w variable.importance

###eye_subtissue_data

rbr eye_subtissue_rbr_data rbr_merged_label_1 eye_subtissue_rbr_data merged_MEH_rbr_result_eye_1 -r 1
rbr eye_subtissue_rbr_data rbr_merged_label_1 eye_subtissue_rbr_data merged_MEH_rbr_result_eye_2 -r 2 -w variable.importance;rbr eye_subtissue_rbr_data rbr_merged_label_1 eye_subtissue_rbr_data merged_MEH_rbr_result_eye_3 -r 3 -w variable.importance;rbr eye_subtissue_rbr_data rbr_merged_label_1 eye_subtissue_rbr_data merged_MEH_rbr_result_eye_4 -r 3 -w variable.importance;rbr eye_subtissue_rbr_data rbr_merged_label_1 eye_subtissue_rbr_data merged_MEH_rbr_result_eye_5 -r 3 -w variable.importance


### no mouse_time_data
rbr rbr_merged_EH rbr_merged_label_1 rbr_merged_EH merged_EH_rbr_result_1 -r 1
rbr rbr_merged_EH rbr_merged_label_1 rbr_merged_EH merged_EH_rbr_result_2 -r 1 -w variable.importance
rbr rbr_merged_EH rbr_merged_label_1 rbr_merged_EH merged_EH_rbr_result_3 -r 2 -w variable.importance
rbr rbr_merged_EH rbr_merged_label_1 rbr_merged_EH merged_EH_rbr_result_4 -r 3 -w variable.importance
rbr rbr_merged_EH rbr_merged_label_1 rbr_merged_EH merged_EH_rbr_result_5 -r 3 -w variable.importance
rbr rbr_merged_EH rbr_merged_label_1 rbr_merged_EH merged_EH_rbr_result_6 -r 3 -w variable.importance

### crx_rbr_data 

rbr crx_rbr_data rbr_merged_label_1 crx_rbr_data crx_rbr_result_1 -r 1
rbr crx_rbr_data rbr_merged_label_1 crx_rbr_data crx_rbr_result_2 -r 1 -w variable.importance
rbr crx_rbr_data rbr_merged_label_1 crx_rbr_data crx_rbr_result_3 -r 1 -w variable.importance
rbr crx_rbr_data rbr_merged_label_1 crx_rbr_data crx_rbr_result_4 -r 1 -w variable.importance
rbr crx_rbr_data rbr_merged_label_1 crx_rbr_data crx_rbr_result_5 -r 1 -w variable.importance
rbr crx_rbr_data rbr_merged_label_1 crx_rbr_data crx_rbr_result_6 -r 1 -w variable.importance

### protein_score_data

rbr protein_score_rbr_data rbr_merged_label_1 protein_score_rbr_data protein_score_result_1 -r 1
rbr protein_score_rbr_data rbr_merged_label_1 protein_score_rbr_data protein_score_result_2 -r 1 -w variable.importance
rbr protein_score_rbr_data rbr_merged_label_1 protein_score_rbr_data protein_score_result_3 -r 1 -w variable.importance
rbr protein_score_rbr_data rbr_merged_label_1 protein_score_rbr_data protein_score_result_4 -r 1 -w variable.importance
rbr protein_score_rbr_data rbr_merged_label_1 protein_score_rbr_data protein_score_result_5 -r 1 -w variable.importance
rbr protein_score_rbr_data rbr_merged_label_1 protein_score_rbr_data protein_score_result_6 -r 1 -w variable.importance

