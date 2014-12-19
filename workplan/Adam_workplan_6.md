##<center>本周工作报告_6</center>

######<center>2014.11.12</center>

#### 一、之前的思路总结

接上之前的内容，我之前的工作思路大致是：使用RankSVM来训练Toppgene网站的数据，效果还是挺不错的

#### 二、本周工作
首先确定了一下我接下来要做的工作，就是：

1. 用SVM的Rank方法分别跑一下那几组 RNA-seq，humanbody，microarray的数据用svmRank进行训练，得到相对应的三组值；
2. 然后将三组数据的结果与proteomics and Crx相结合，再用svm_light进行学习，得到最终的confidence，这个confidence就是用来评价基因与视网膜疾病的相关程度。

**那么问题来了**

- 问题1： 因为方法1得到的这三组值是一个相对的值，只表示他们内部的排序，并没有实际的意义，也就是说这三列并没有其相关性，不知道可以不可以用svm训练
- 问题2： 记得大师兄以前有个问题待我解决，就是你把一些数据加到svm模型中间去，效果反而没有不加那些数据的效果好，对于这个问题，我把它转化成了另外一个问题，**就是当利用第二层SVM的时候，相对于每一列的数据按重要性给它们加一个权重**

**我的想法**

- 我有一个初步的想法，之前看过一个关于解决**“网页搜索问题”**中**如何确定网页之间相关性**，一个比较经典的方法，就是利用**余弦定理**来解决网页之间的相关性(当时具体的内容记不太清了)，我觉得我们这个第二层模型与确定网页之间相关性还是有一定类似的东西，所以以后可以考虑使用余弦定理的方法来考虑基因之间的相关性，用余弦定理的方法有个好处，就是**可以通过训练的方法来调整每一个属性的权值**。当然，我首先要做的事情就是将之前的的想法实现

#### 三、本周工作
在正式使用svmrank进行训练之前，我必须得先找出比较好的参数来进行训练，所以我这一周主要是实验用RankSVM的参数，用哪个好，主要确定的参数有：

1. 确定用哪个核函数好一些，用线性的？还是多项式的？还是径向基函数之类的？
	为了试各种核函数，我这一周把 .2，.16，.44的三个服务器的CPU都给一直在占用着，我看也没其它人在用，就发现，
	- 用默认的线性的核函数，效果就像之前的一样，跑起来速度也快
	- 用径向基函数作为核函数，效果比线性的核函数更差
	- 用高阶多项式的核函数，我用两天服务器，一个是高阶的，一个是二阶的，第一次跑了三天，没有结果，第二次重新跑，到现在跑了两天了，也还没有跑出来结果
	- 用sigmoid 核函数，也没有跑出来结果，只能说太慢了，自己的核函数，我也不知道哪个核函数好，不会写
	**所以不出意外的话，我还是会用线性的核函数，速度快，高阶多项式核函数和sigmoid迭代速度太慢了**
附一行示例代码：用二阶多项式进行训练，marge 为20
		```javascript
		svm_rank_learn -t 1 -d 2 -c 20 toppgene_svmrank_train.txt toppgene_model_t1d2
		svm_rank_classify toppgene_svmrank_test.txt toppgene_model_t1d2 toppgene_svmrank_predictions_t1.txt
		```
2. 确定trade-off between training error and margin 默认是0.01，我分别用了 20 ，50的参数，分别训练了几组，结果发现效果差不了不多，相比之下，marge为20的时候效果稍微好了一些，所以以后就用c=20.具体代码还有结果，我都存在电脑的“处理记录.txt”文件中

#### 四、下周计划

1. 下周组会我讲，正好看一下关于**“余弦定理”**与**“SVMRank”**的东西，下次组会了跟大家探讨一下，其实我对SVMRank的原理不是很懂，虽然在用
2. 仔细看一下大师兄之前是如何处理svm_learn的结果的，那些代码比较复杂，之前也没沉下心去看懂