#<center>工作报告_13</center>

######<center>2015.01.25</center>


### 一、确定训练数据与对比数据

##### 1. 确定替换 Human_body 的最后一列为最新的 retina的 FPKM

在RNA-seq-data文件夹中是3个human retina RNA-seq的replicates,取出文件genes.fpkm_tracking中的FPKM一列，求平均，结果存入human_body_new/retina_fpkm.xlsx, 把结果加入文件Human body map RNA-Seq最后一列，因为董超文件中已经加好，所以我就替换掉，存入 human_body_new/human_body_new_data
需要写一个函数来将数据通过基因名称调整位置，函数名称为：sortDataFromGeneName.r


###### 1. 使用Toppnet 的各种方法生成预选基因（用此结果来生成negative index，或者生成其它rbr的输入数据）

1_1. 6-step Markov （Neighborhood distance = 1） 识别11918个基因
结果
其中：

- mouse eye human 分别代表单独的三个原始数据进行训练
- merged_MEH 代表同时使用三个视图 merged_EH eye和human视图
- random 代表概率随机下的数量，可以作为一个参考

训练时间：rbr对一个数据集训练的时间基本上在20s以内，比svm快了两个数量级，所以我每次实验调参了很多次，结果是比较精确确的

因为每种视图我都做了六组实验，所以结果是比较正确的：**可以看出，
- 单独使用human数据效果最好(超越TTP的方法)
- 单独使用eye和human数据，或者三个数据一起使用的话，结果在normal之上
- 但是同时使用后两个数据，结果反而比较差
- 实验过程中，如果将基因之间的属性设置为相关，则结果会非常差**

###### 2. 重新使用Toppgene训练，这次删除 Human Ph mouse Ph , Pubmed, Disease 这几个属性，下载，存为 toppgene/toppgeneResult_1.csv


###### 3. 确定目标集合

1. 之前使用的训练基因有166个，现在已经更新到200多个了，所以我可以用200多个-166个作为预测集
这200多个基因从[200个基因网址](https://sph.uth.edu/retnet/sym-dis.htm)下载，存为 retnet/retnetGeneName_Raw (找到了660个基因)
其中删去这几个基因 ：原因是Lily说这几个基因不太好

[不好的基因网址](https://sph.uth.edu/retnet/sum-dis.htm#A-genes) Other retinopathy, mitochondrial	none	KSS, LHON, MT-ATP6, MT-TH, MT-TL1, MT-TP, MT-TS2



###### 2. 使用RBR训练的结果在42个基因中的结果

| tools| top 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 | 1000 | 1100 | 1200 | 1300 | 1400 |
|-------|---|---|---|---|---|----|----|----|----|----|----|----|----|----|----|
| MEH   | 0 | 4 | 6 | 9 | 10 | 11 | 11 | 11 | 12 | 12 | 13 | 13 | 13 | 13 |
| mouse | 3 | 5 | 7 | 9 | 9 | 9  | 10 | 11 | 12 | 12 | 14 | 15 | 15 | 16 |
| human | 6 | 7 | 8 | 9 | 9 | 9  | 10 | 10 | 12 | 13 | 13 | 13 | 14 | 14 |
| eye   | 0 | 3 | 4 | 4 | 4  | 4  | 4  | 4  | 5  | 5  | 5  | 5  | 7  | 7  |
| EH    | 0 | 4 | 6 | 7 | 9  | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 11 |
| crx   | 2 | 3 | 5 | 5 | 8  | 8  | 8  | 8  | 11 | 11 | 13 | 13 | 14 | 14 |
|TTP	| 1       | 1   | 2   | 3   | 3   | 3   | 3   | 3   | 3   | 3    | 5    | 5    | 6    | 8    |
|ToppGene| 7       | 7   | 7   | 10  | 11  | 13  | 14  | 14  | 16  | 17   | 17   | 17   | 20   | 22   |
