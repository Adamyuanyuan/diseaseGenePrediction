#<center>工作报告_15</center>

######<center>2015.3.23</center>

### 一、对 firstLayer 的数据结果进行分析

##### 1. 分析这些每个view所得结果之间的关系

我写了一个分析脚本（firstLayerResultAnalyze.r），里面包含了两个函数，用于分析一个目录中的所有的文件中的基因，它们在前100到前1400个基因中拥有共同基因的数量，并且将这些基因输出

执行脚本前，先将要分析的文件数据放入 E:\gitspace\diseaseGenePrediction\firstLayer\analyseOfAllGeneList 文件夹下，其中 Human_body_seq 的三组数据我选的是Human_body_seq_max的数据，因为max的效果更好一些，目录中的文件为：
 
	sortedName_RBR_Human_body_seq_max_result_12 (Human_body_seq 中三烈求max的结果，求mean和meanD的结果没有进行分析)
	sortedName_RBR_human_body_pro_all_result_12 (human_body_pro_all 的结果，即从[网址humanproteomemap](http://www.humanproteomemap.org/index.php)上下下来的所有17个属性的分析结果，之前还有部分属性的训练结果页没有加入分析)
	sortedName_RBR_mouse_proteomics_result_12 (mouse_proteomics的结果)
	sortedName_RBR_eye_subsitiue_result_12 (eye_subsitiue的结果)

分析结果已经出来了，目前还没有画维恩图，分析是对每两个view进行求交集，发现，基本上相同的基因占了所有基因的一半，因为结果比较多，在此我把结果以附件的形式发给您

详细代码请看这里[firstLayerResultAnalyze.r](https://github.com/Adamyuanyuan/diseaseGenePrediction/blob/master/geneCode/firstLayerResultAnalyze.r)
分析结果请见附件
