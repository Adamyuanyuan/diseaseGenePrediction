#<center>工作报告_13</center>

######<center>2015.2.7</center>


### 一、确定训练数据与对比数据

##### 1. 确定新的全基因列表，确定替换 Human_body 的最后一列为最新的 retina的 FPKM

- 把结果加入文件Human body map RNA-Seq最后一列，因为董超文件中已经加好，所以我就替换掉，存入 human_body_new/human_body_new_data
需要写一个函数来将数据通过基因名称调整位置，函数名称为：sortDataFromGeneName.r

- Human RNA-seq 3 replicates (remove all FPKM=0) ------> new gene name list ------> new_gene_name_human

1. 在RNA-seq-data文件夹中是3个human retina RNA-seq的replicates, 取出文件genes.fpkm_tracking中的FPKM一列，存入human_body_new/retina_fpkm.xlsx, 数据处理后存入 newData/retina_fpkm_three ，共24788列 
2. 将retina_fpkm_three 去除 3个 fpkm 均为0的情况，存入resultFpkmData_three，共20133列
3. resultFpkmData_three 分别求 mean,max和meanDespiteZero(自己写的函数，目的是如果fpkm为零，有可能是实验操作失误所导致，所以不算在求平均内)，数据cbind到resultFpkmData_three后面三列 -----> resultFpkmData_mmm ，共20133列
4. 然后对resultFpkmData_mmm如果基因名有重复的情况的话对其求平均，得到最终结果 new_resultFpkmData_mmm 和 new_gene_name_human， 这组基因名将作为其它数据的校准

用R语言将其remove all FPKM=0，代码保存在 mergeFpkmDataAnddelete.r ，并且如果文件名相同的话求平均

resultFpkmData_three 分别求 mean,max和meanDespiteZero(自己写的函数，目的是如果遇到为零的话，有可能是实验操作失误，所以不算在求平均内)
5. 将得到的基因名列表中,将名称中有-的基因去掉，这是 non-coding RNA, 不翻译成蛋白的，所以结果就是：new_resultFpkmData_mmm 和 new_gene_name_human. 共19643个基因，这组基因名也将成为我所有试验的参照基因名

##### 2. 确定预测集基因列表

将retnet网站下载下来的基因去重之后，有231个，去掉作为训练集的166个基因，再去掉需要删除的7个基因，得到预测集基因列表，共58个，存入newData/subedResultGene 文件

再判断166个基因与58个基因在不在 new_gene_name_human 中（ MFRP ）
发现，在166个基因中，有一个基因不在里面
在58个基因中，有3个基因不在其中(ARMS2 ,EMC1 ,KIZ)

用同样的方法判断其是不是在之前的14177个基因中
发现，166个基因全在里面
58个基因中，有29个基因不在其中，所以就是用新基因列表

### 二、 确定新的Human_body seq 数据并用RBR进行训练并判断结果 

所有数据均在newData 文件夹下：

Human_body_merged_sorted 与 new_resultFpkmData_mmm 的每一列进行合并，生成三份 Human body 数据

Human_body_seq_mean Human_body_seq_max Human_body_seq_meanDespiteZero

并生成lable 属性数据 rbr_lable_1

然后用 RBR进行训练，代码在 useRBRtoHuman_body_seq.sh

##### 1. Human_body_seq_mean进行训练并分析结果(效果显然比toppgene好了很多)

然后用改进之后的对比方法进行对比，结果如下：
(其中：100-1400 代表 seq(100,1400,100) 1000-20000代表 seq(1000,20000,1000))
下面数据结果分别是：1-6：代表第一种方案的调参后的结果
                    7-12：代表第二种方案的调参后的结果 
可以发现，经过自适应调参后，数据结果稍微比之前好了一点点，但是差距并不是很明显：

	RBR_Human_body_seq_mean_result_1 100-1400: 
	4 4 5 5 6 7 8 8 8 9 9 10 10 10
	RBR_Human_body_seq_mean_result_1 1000-20000: 
	9 12 18 24 28 30 31 33 35 35 38 38 42 47 49 51 53 54 55 55
	RBR_Human_body_seq_mean_result_2 100-1400: 
	4 4 5 5 6 7 7 7 7 8 10 11 12 12
	RBR_Human_body_seq_mean_result_2 1000-20000: 
	8 15 18 21 24 29 33 34 37 38 44 46 49 49 49 51 52 54 55 55
	RBR_Human_body_seq_mean_result_3 100-1400: 
	4 4 5 5 6 7 7 7 8 10 10 10 11 11
	RBR_Human_body_seq_mean_result_3 1000-20000: 
	10 15 18 21 25 30 32 34 37 40 42 45 49 49 49 50 51 55 55 55
	RBR_Human_body_seq_mean_result_4 100-1400: 
	4 4 5 5 6 7 7 7 8 10 10 11 11 11
	RBR_Human_body_seq_mean_result_4 1000-20000: 
	10 15 18 21 25 30 32 34 37 40 43 46 49 49 49 50 52 54 55 55
	RBR_Human_body_seq_mean_result_5 100-1400: 
	4 4 5 5 5 6 7 7 8 10 11 11 11 11
	RBR_Human_body_seq_mean_result_5 1000-20000: 
	10 15 18 20 25 30 31 33 37 41 43 46 48 49 49 50 52 54 55 55
	RBR_Human_body_seq_mean_result_6 100-1400: 
	4 4 5 5 6 6 7 7 8 10 11 11 11 11
	RBR_Human_body_seq_mean_result_6 1000-20000: 
	10 15 18 20 25 30 31 33 37 41 44 46 48 49 49 51 52 54 55 55
	RBR_Human_body_seq_mean_result_7 100-1400: 
	4 4 5 5 6 7 8 8 8 9 10 10 10 10
	RBR_Human_body_seq_mean_result_7 1000-20000: 
	9 12 17 24 28 30 32 33 35 35 38 38 43 47 50 51 53 54 55 55
	RBR_Human_body_seq_mean_result_8 100-1400: 
	4 4 5 5 6 7 7 7 7 8 10 12 12 12
	RBR_Human_body_seq_mean_result_8 1000-20000: 
	8 15 18 21 24 29 33 34 37 38 44 46 49 49 49 50 52 54 55 55
	RBR_Human_body_seq_mean_result_9 100-1400: 
	4 4 5 5 6 7 7 7 7 9 9 10 12 12
	RBR_Human_body_seq_mean_result_9 1000-20000: 
	9 15 18 21 23 29 32 34 36 40 41 45 48 49 49 50 52 55 55 55
	RBR_Human_body_seq_mean_result_10 100-1400: 
	4 4 5 5 7 7 7 7 9 9 11 11 11 11
	RBR_Human_body_seq_mean_result_10 1000-20000: 
	9 14 18 21 22 28 32 35 36 40 42 47 49 49 49 50 52 55 55 55
	RBR_Human_body_seq_mean_result_11 100-1400: 
	4 4 5 5 7 7 7 7 9 9 11 11 11 11
	RBR_Human_body_seq_mean_result_11 1000-20000: 
	9 14 17 21 22 28 32 35 36 39 43 48 49 49 49 50 52 55 55 55
	RBR_Human_body_seq_mean_result_12 100-1400: 
	4 4 5 5 7 7 7 7 9 10 11 11 11 11
	RBR_Human_body_seq_mean_result_12 1000-20000: 
	10 14 17 21 23 28 32 33 36 39 43 47 49 49 49 50 52 54 55 55

#####2. Human_body_seq_max进行训练并分析结果

结果与mean不相上下，要看怎么分析了
RBR_Human_body_seq_max_result_12 100-1400: 
4 4 4 6 7 7 7 7 8 8 8 10 12 13
RBR_Human_body_seq_max_result_12 1000-20000: 
8 14 18 20 26 32 33 35 37 38 43 45 48 48 49 51 54 54 55 55

#####3. Human_body_seq_meanDespiteZero 进行训练并分析结果

结果与mean不相上下
RBR_Human_body_seq_meanDespiteZero_result_12 100-1400: 
3 4 5 5 7 7 7 7 9 9 10 11 11 11
RBR_Human_body_seq_meanDespiteZero_result_12 1000-20000: 
9 14 17 21 23 28 32 34 36 39 43 47 49 49 49 50 51 54 55 55
**对照Human_body_seq 的三种情况，其实结果差不多，max的结果稍好些，因为实验本身误差的原因，我认为 max 与 meanDespiteZero 相比于mean更能解释通，所以我更倾向于 max 与 meanDespiteZero，老师您怎么看？**

### 三. 使用Toppgene训练新的基因集并分析

输入 positive 为 ： toppgene/positive_name_human_165 toppgene/new_gene_name_human (19643个)
其中 Toppgene 不能处理数据量特别大的情况，所以分别输入两次，第一次输入10000个基因，第二次输入9643个基因 ,第三次输入9000-11000的基因进行对比

1. Test set (8531 / 10000) 
这次删除 Human Ph mouse Ph , Pubmed, Disease 这几个属性，下载，存为 toppgene/toppgeneResult_1.csv /
2. Test set (9158 / 9643)
这次删除 Human Ph mouse Ph , Pubmed, Disease 这几个属性，下载，存为 toppgene/toppgeneResult_2.csv
3. Test set (1306 / 2001)
这次删除 Human Ph mouse Ph , Pubmed, Disease 这几个属性，下载，存为 toppgene/toppgeneResult_3.csv

后来发现这样结果还是不够准确的，后来通过输入对应geneId(gene_name_toppene_17687)的方法完美解决了这个问题，存为toppgene/toppgeneResult_all_1.csv,基因排序列表存入toppgene/toppgene_name_sorted

用 matchGeneNumofPredictedGene.r 函数进行判断，结果存入
发现 Toppgene在前1400个的效果太差了，为：
2 2 2 2 2 2 2 2 2 2 2 2 2 2
我不敢相信自己的眼睛，以为是代码的问题，一步一步检查了一下没有发现问题，所以后来又把从1000到18000每隔1000为一个单位进行判断，得到：
2  5 10 14 21 24 32 35 38 44 48 52 52 53 54 55 55 55

可以看出，Toppgene在前7000个geng的结果比Human_body_seq差，到后面慢慢超越了

####三、接下来的计划

1. mouse_time_seq, human_proteomic_body_map, crx_proteomics 数据的处理及分析，老师你看对我以下的数据有什么建议

mouse_time_seq/Mouse_FPKM_embro_baby ----> mouse_time_seq/mouse_time_seq 

HPM_gene_level_epxression_matrix_Kim_et_al_052914 ----> human_body_map_proteomic 
(上面的数据是我下载的，人体的大部分器官都有)

2. 想一个方法将这些不同的view整合，使得他们的效果更好

目前想的是双层训练的方法，或者 余弦定理的方法

3. 将结果通过其它方法进一步改进

比如有规则地选取negative gene lable




