##<center>本周工作报告_7</center>

######<center>2014.11.20</center>

#### 一、之前的思路总结

接上之前的内容，我之前的工作思路大致是：

1. 使用RankSVM来训练Toppgene网站的数据
2. 通过Toppgene网站的数据来确定用RankSVM需要的一些参数

#### 二、本周工作
1. 看了一下余弦定理在新闻分类中的应用，因为这个东西是用于很多大互联网公司的，没有找到被发表的论文，只是网上有一些技术博客会写到，我觉得这个技术可能可以作为我以后研究的创新点
2. 我本周的工作就是用SVM的Rank方法分别跑一下那几组 RNA-seq，humanbody，microarray的数据用svmRank进行训练，欲得到相对应的三组值；

	2.1. 首先将这些数据转换成svmRank支持的格式，需要对所有的数据统一增加两个属性，还是比较耗费时间的，有的是用R语言转的，有的R语言转换不来，只能用excle快一些，用linux的awk方法的话写起来太慢了,分别存为mouse_time_svmRank.txt,eye_subtissue_svmRank.txt,body_map_svmRank.txt 文件，并传入相应的服务器进行训练:训练方案是：

<table bordercolor="#006803" align="center" >
		<tr>
			<td> 使用的服务器 </td>
			<td> 训练的数据</td>
		</tr>
		<tr>
			<td> wangfei@10.20.2.44 /wxg </td>
			<td> mouse_time</td>
		</tr>
		<tr>
			<td> gang@12.20.2.2 </td>
			<td> eye_subtissue</td>
		</tr>
		<tr>
			<td> wxg@12.20.2.16 </td>
			<td> body_map</td>
		</tr> 
</table>

	2.2 在服务器上运行这些代码，代码已经跑了两天了，还没有出来结果

####遇到的问题
1. 我在服务器上跑得代码跑一天多，迭代了十几万次都出不来结果，不知道为什么
2. 如果我电脑端有时候在晚上会自动更新重启，这样的话服务器端的进程也就被关掉了，这个问题后来被我解决了，把我的进程放在一个screen的虚拟shell下，就不怕断电的问题了
示例代码如下，使用nohup使得进程在后台运行：

		nohup svm_rank_learn -c 20 mouse_time_svmrank.txt mouse_time_model_1 &
		svm_rank_classify mouse_time_svmrank.txt mouse_time_model_1 mouse_time_svmrank_predictions_1.txt
		

#### 四、下周计划

1. 接下来的时间以修改并投出大师兄的论文为主，30日截稿
2. 我的东西还是要做的，希望能三台服务器并行同时训练，找出最好的训练方法和结果
