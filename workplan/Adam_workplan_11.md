##<center>本周工作报告_11</center>

######<center>2015.01.03</center>

######感谢王老师在过去的一年来对我们的辛辛教导，在新的一年里，希望老师家庭幸福平安，学术和事业上能有新的突破，新年快乐~

#### 一、之前的思路总结

- 分别使用Toppgene -> SVMLight -> SVMrank -> transtive SVM 针对不同的核函数进行疾病基因预测的训练，现在这几个方法都能够使用了

- 王一老师老师提出了新的方法：RBR方法，据说速度比较快，效果比较好

#### 二、本周工作

- 学习并尝试使用RBR方法：用RBR的方法训练Toppgene的数据,用真实数据实验RBR方法的效果
RBR方法需要的数据格式与SVMlight的格式不一样，比SVM多了一个文件，所以首先得转换格式，将Toppgene网站中抓下来的数据，和166个positivegene的数据进行整合，共16280行得到如下三个原始训练文件，toppgene_rbr_result_代表预测文件，然后对不同的r参数进行训练：

##### 调参

r代表 “Scaled L2 regularization parameter”。是一个需要调试的参数，可以通过以下方法进行调试：
	rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_1
	rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_2 -r 10
	rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_3 -r 100
	rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_4 -r 1000
	rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_5 -r 0.1
	rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_6 -r 0.01

然后将结果进行比较：得到：（值得一提的是，RBR的速度特别快，一般一次预测只需要二十秒就可以完成了，而SVM则需要半个小时左右。这无疑大大加速了调参进度和实验进度）

对于452个 shared_cilia_human,对应的结果为

toppgene_rbr_result_1 : 
14 25 37 42 50 60 66 73 77 81 87 91 99 105
toppgene_rbr_result_2 : 
7 14 19 27 34 39 43 47 55 65 69 72 75 76
toppgene_rbr_result_3 : 
9 18 25 28 38 48 53 56 62 65 76 80 85 90
toppgene_rbr_result_4 : 
7 18 25 30 37 47 53 57 60 67 72 78 85 94
toppgene_rbr_result_5 : 
17 33 39 46 51 57 67 71 77 82 86 87 91 96
toppgene_rbr_result_6 : 
7 14 20 25 32 38 42 45 51 60 68 69 72 75

对于42个 TTP_model_human,对应的结果为

toppgene_rbr_result_1 : 
4 6 6 6 7 8 9 11 11 12 12 12 13 16
toppgene_rbr_result_2 : 
2 4 5 5 5 6 7 9 9 10 12 12 13 13
toppgene_rbr_result_3 : 
3 3 4 5 5 5 6 6 9 13 14 16 16 16
toppgene_rbr_result_4 : 
3 3 4 5 5 5 6 7 8 11 16 16 16 16
toppgene_rbr_result_5 : 
1 3 5 6 6 6 6 9 10 11 11 11 11 11
toppgene_rbr_result_6 : 
2 4 5 5 6 6 8 8 9 11 12 12 12 14

上述结果说明，当r=1和r=0.1之间的时候效果比较好，所以分别取r=0.5 0.6 0.7 0.8 0.9 2 5 进行尝试，经过一系列的调参，综合与TTP_model_human和shared_cilia_human的对比结果，调的**r=1**
接下来使用RBR自带的 variable.importance 的方法来确定每一列的变量的**权重**，我觉得这个非常好用，可以动态的迭代，得到最合适的每一个属性的权重：

	rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_13 -r 1 -w
	rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_14 -r 1 -w variable.importance
	rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_15 -r 1 -w variable.importance
	rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_16 -r 1 -w variable.importance
	rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_17 -r 1 -w variable.importance
	rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_18 -r 1 -w variable.importance

对训练的结果进行分析（R语言），使用了一个自己写的函数，这样的话以后分析起来就很快了，结果分别保存在 matchedResult_452 和matchedResult_42 文件中：

	for(name in seq(13,18)){
		myPredictionName <- paste("toppgene_rbr_result",name,sep="_");
		sortPredictedGene("toppgene_genome_name",myPredictionName,shared_cilia_human,"452");
		sortPredictedGene("toppgene_genome_name",myPredictionName,TTP_model_human,"42");
	}
将结果进行对比，可以发现，在经过几次迭代之后，结果已经收敛了，就可以得到最佳的预测值
在452个对比基因文件（第十八个结果虽然比第17个结果还稍差，但我认为并不能说迭代之后效果越来越差，只能说明我们的检测方法不够精确）
toppgene_rbr_result_17 : 
14 25 37 43 50 59 65 73 78 81 90 94 98 106
toppgene_rbr_result_18 : 
14 29 37 42 51 63 67 71 75 83 87 91 95 102
在42个对比基因文件
toppgene_rbr_result_17 : 
4 6 6 6 7 8 9 11 12 12 12 12 13 16
toppgene_rbr_result_18 : 
4 6 6 6 9 10 10 11 11 11 12 12 14 16

######权重结果：
RBR通过一套自适应迭代的方法可以迭代出每个属性的权重，结果如下：

| 2.64e-05 | 4.16217e-05 | 4.1084e-05 | 8.66273e-05 | 5.72301e-05 | 4.27841e-05 | 3.16328e-05 | 9.06745e-05 | 3.4932e-05 | 3.31665e-05 | 3.76462e-05 | 3.56875e-05 | 3.68022e-05 | 0.000112281 |

#####与其它方法的比较：
452个shared_cilia_human基因

| tools                 | top 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 | 1000 | 1100 | 1200 | 1300 | 1400 |
|-----------------------|---------|-----|-----|-----|-----|-----|-----|-----|-----|------|------|------|------|------|
| TTP                   | 4       | 7   | 10  | 13  | 15  | 16  | 20  | 24  | 29  | 36   | 42   | 53   | 57   | 61   |
| ToppGene的方法        | 10      | 26  | 38  | 48  | 61  | 69  | 82  | 86  | 92  | 97   | 103  | 106  | 110  | 118  |
| transductive_sorted_1 | 7       | 10  | 15  | 17  | 21  | 25  | 30  | 34  | 35  | 37   | 42   | 46   | 51   | 56   |
| SVMRranksorted3       | 13      | 24  | 36  | 40  | 48  | 52  | 56  | 61  | 67  | 72   | 85   | 91   | 94   | 96   |
| RBR                   | 14      | 25  | 37  | 43  | 50  | 59  | 65  | 73  | 78  | 81   | 90   | 94   | 98   | 106  |

42个TTP_model_human基因

| tools                  | top 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 | 1000 | 1100 | 1200 | 1300 | 1400 |
|------------------------|---------|-----|-----|-----|-----|-----|-----|-----|-----|------|------|------|------|------|
| TTP                    | 1       | 1   | 2   | 3   | 3   | 3   | 3   | 3   | 3   | 3    | 5    | 5    | 6    | 8    |
| ToppGene               | 7       | 7   | 7   | 10  | 11  | 13  | 14  | 14  | 16  | 17   | 17   | 17   | 20   | 22   |
| ToppGeneSVMsorted2     | 4       | 4   | 6   | 7   | 7   | 7   | 7   | 7   | 7   | 7    | 7    | 8    | 10   | 10   |
| TopGeneSVMRranksorted3 | 2       | 3   | 4   | 4   | 4   | 4   | 6   | 6   | 8   | 9    | 10   | 10   | 10   | 12   |
| RBR                    | 4       | 6   | 6   | 6   | 7   | 8   | 9   | 11  | 12  | 12   | 12   | 12   | 13   | 16   |

可以看出来，对于Toppgene网站自己的数据来说，RBR的效果比单纯的SVMRank和transductive好一些，但不如Toppgene网站自己的方法，它的优势就是速度快

#### 三、接下来方案

RBR的方法确实比SVM好一些，也快很多，所以我想：

1. 将所有的数据标准化，老师，其它论文中都有把所有数据进行标准化过，我们需要标准化吗？
2. 然后用RBR训练出结果
3. 迭代寻找更有效的负样本
