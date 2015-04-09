#<center>工作报告_14</center>

######<center>2015.2.7</center>

### 一、mouse_time_seq 数据的处理及分析预测

##### 1. 将 Mouse_FPKM_embro_baby 原始数据转换为 mouse_time_seq 数据


以下的数据都在 /mouse_time_seq 文件夹下，代码保存在 mouse_time_seq.r 中：

由于首先得把mouse的数据与Human的数据一一对应起来，这是一个非常麻烦的过程也肯定会有误差的，方案有好多种，我看了几个网站都不太好使用。
为了尽可能小得减少误差，我决定进行以下的步骤来对应：

数据处理算法思路：

1. 将 new_human_gene_name 通过 http://biodbnet.abcc.ncifcrf.gov/db/dbOrtho.php 网站，分为三组转换为 new_Human2mouse19643 ，其中部分Human基因可能会对应多个mouse基因；
2. 对于没有直接对应到的基因，通过代码，直接将大写转换为小写；
3. 通过代码 ，将 new_Human2mouse 转换为 new_mouse2Human ,在这里，可以存在多个mouse name对应一个human name;
4. 然后通过这个 new_mouse2Human 表，将 Mouse_FPKM_embro_baby 原始数据中的 mouse symbol 转换为 human symbol，如果没有出现则说明不在那19763个基因中，就删掉，转换为 Mouse2Human_FPKM_embro_baby;
5. 这个 Mouse2Human_FPKM_embro_baby 中会存在human name 重复的项，然后将重复的项求均值;
6. 然后将 Mouse2Human_FPKM_embro_baby 通过 new_human_gene_name 进行匹配排序，如果这个基因不存在，则置为NA, 这样的话误差就比较小了;

老师这个算法我到目前为止还没有开始实现，您觉得可行吗？
以上方法是有漏洞的，所以决定不用，但我找到了大师兄的转换数据，现在只要直接转换就可以了

-------------------------------------------------------------------------
以上方法是有误的，不够严谨，先解决方案如下：
new_gene_name_human 通过 FULL_merged_table.txt 转换成new_gene_name_mouse,
然后通过这个对应的小鼠的基因列表排序来得到 mouse_time_seq 数据和  RBR_mouse_time_seq数据

--------------------------------------------------------------------------

##### 2. 将 RBR_mouse_time_seq 用RBR进行训练并分析
使用 sortPredictedGene.r 进行分析
结果如下：
	RBR_mouse_time_seq_result_12 100-1400: 
	1 3 4 4 4 4 4 4 5 7 7 7 8 8
	RBR_mouse_time_seq_result_12 1000-20000: 
	7 9 11 12 14 17 19 21 26 31 33 37 40 41 43 43 49 51 52 55


### 二、 human_body_pro 数据的处理及分析预测

以下的数据都在 /human_body_pro 文件夹下，代码保存在 human_body_pro.r 中：

##### 1. 将网站关于HPM的原始数据转换为 RBR_human_body_pro 数据

数据可以从 [网址humanproteomemap](http://www.humanproteomemap.org/download.php) 进行下载

有用的数据是：HPM_peptide_level_expression_matrix_Kim_et_al_052914.csv ----> 通过 new_human_gene_name 进行排序，得到 human_body_pro, 然后转化为适合RBR训练的 RBR_human_body_pro

##### 2. 将 RBR_human_body_pro 用RBR进行训练并分析

以上数据中只有 human body map 的Adult的数据，This includes 17 adult tissues

训练结果在 E:\gitspace\diseaseGenePrediction\human_body_pro 下,共2组12份结果,分别命名为：RBR_human_body_pro_result_1-RBR_human_body_pro_result_12

结果如下：
	RBR_human_body_pro_result_12 100-1400: 
	5 7 8 9 9 9 9 9 11 11 11 12 12 13
	RBR_human_body_pro_result_12 1000-20000: 
	11 15 17 23 24 25 30 35 37 39 41 42 43 47 49 50 50 50 50 55

##### 3. 将 RBR_human_body_pro_all 用RBR进行训练并分析
以上数据中是 human body map 的所有的数据，This includes 17 adult tissues, 6 primary hematopoietic cells and 7 fetal tissues.

结果如下：

	RBR_human_body_pro_all_result_12 100-1400: 
	5 6 8 8 9 10 11 11 11 12 13 14 15 16
	RBR_human_body_pro_all_result_12 1000-20000: 
	12 18 22 25 26 26 30 33 35 40 43 47 49 53 55 55 55 55 55 55
结果比用 Human_body_seq 稍好

### 三、 mouse_proteomics 数据的处理及分析预测
以下的数据都在 /mouse_proteomics 文件夹下，代码保存在 mouse_proteomics.r 中：
问题： **大师兄在训练的时候是这组六列数据再加上crx的数据，那个crx的数据是从哪里找来的呢？**
##### 1. 将 Mouse_proteomics.csv 原始数据转换为 mouse_proteomics 数据
 将 Mouse_proteomics.csv 原始数据通过 new_human_gene_name 进行排序，得到 mouse_proteomics, 然后转化为适合RBR训练的 RBR_mouse_proteomics

##### 2. 将 RBR_mouse_proteomics 用 RBR 进行训练并分析
将数据进行分析，结果如下(效果略差)：
	RBR_mouse_proteomics_result_6 100-1400: 
	2 2 4 4 4 6 7 8 8 8 10 10 11 11
	RBR_mouse_proteomics_result_6 1000-20000: 
	8 12 15 16 19 25 29 32 35 38 39 39 39 42 45 46 47 51 53 55

### 四、 eye_subsitiue 数据的处理及分析预测
以下的数据都在 /eye_subsitiue 文件夹下，代码也保存在 mouse_proteomics.r 中：

##### 1. 将 RNA_human_Eye_sub_Tissue.csv 原始数据转换为 eye_subsitiue 数据
 将 RNA_human_Eye_sub_Tissue.csv 原始数据通过 new_human_gene_name 进行排序，得到 eye_subsitiue, 然后转化为适合RBR训练的 RBR_eye_subsitiue

##### 2. 将 RBR_eye_subsitiue 用RBR进行训练并分析
将数据进行分析，结果如下：
	RBR_eye_subsitiue_result_12 100-1400: 
	4 4 4 4 5 7 8 9 9 9 9 10 10 11
	RBR_eye_subsitiue_result_12 1000-20000: 
	9 11 14 19 23 29 30 31 33 34 36 39 39 41 43 43 44 48 50 55
