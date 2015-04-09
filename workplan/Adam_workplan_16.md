#<center>工作报告_16</center>

######<center>2015.4.9</center>

### 一、对 firstLayer 的数据进行整合方法一：直接整合
代码在 newFirstLayerMerge.r 中
##### 1. 将5个view直接整合
以下的数据都在 /newFirstLayerMerge/merge1 文件夹下
按照以下顺序将原始数据进行合并将： 
mouse_time_seq mouse_proteomics human_body_pro_all human_body_seq_max eye_subsitiue --> merged_5
其中第一个数据的结果是最差的，

###### 1. 5个view

结果如下：

	RBR_merged_5_result_1 100-1400: 
	2 4 4 5 5 7 7 7 9 11 13 14 15 15
	RBR_merged_5_result_1 1000-20000: 
	11 18 21 23 26 29 30 32 33 36 38 42 44 49 51 54 54 55 55 55

效果介于5个view中最好的结果与最差的结果之间，接近最好的结果