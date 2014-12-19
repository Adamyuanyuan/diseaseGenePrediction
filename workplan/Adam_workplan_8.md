##<center>本周工作报告_8</center>

######<center>2014.11.27</center>

#### 一、之前的思路总结
接上之前的内容，我之前的工作思路大致是：

- 使用双层的相关疾病基因推荐，不过第一层使用的是SVMRank的方法将初始数据进行训练，第二层准备使用余弦定理的方法将第一层的训练结果再加入其它的结果进行计算并排序

#### 二、本周工作
1. 与大师兄论文投稿的事情，我们之前打电话问过相关负责人，对初稿的格式要求并不是很严格，投稿后7天以内会收到确认结果
2. 用SVM的Rank方法分别跑一下那几组 RNA-seq，humanbody，microarray的数据用svmRank进行训练，欲得到相对应的三组值
分别在这三台服务器上运行这些代码，选用的核函数是线性核函数，SVM分类间距是20
	
<table bordercolor="#006803" align="center" >
		<tr>
			<td> 使用的服务器 </td>
			<td> 训练的数据</td>
			<td> 结果</td>
		</tr>
		<tr>
			<td> wangfei@10.20.2.44 /wxg </td>
			<td> mouse_time</td>
			<td> 连续运行了一周还在迭代</td>
		</tr>
		<tr>
			<td> gang@12.20.2.2 </td>
			<td> eye_subtissue</td>
			<td> 连续运行了一周还在迭代</td>
		</tr>
		<tr>
			<td> wxg@12.20.2.16 </td>
			<td> body_map</td>
			<td> 连续运行了一周还在迭代</td>
		</tr>
</table>
**分析原因：**可能是因为这个训练不收敛，所以一直运行下去了，不收敛的原因是因为每个训练集的属性数量过于少了
**解决办法：** 
a. 使用其它核函数，比如使用radial basis function exp(-gamma ||a-b||^2)核函数
b. 其实这也是SVM的一个限制，就是对于属性数量比较少的训练集，SVM不容易收敛，如果都不收敛的话，只能考虑使用在第一层使用**Transductive learning**了
####三、遇到的问题
1. 我在服务器上跑得代码跑七天多，迭代了几百万次都出不来结果，后来才知道很可能的原因是因为不收敛的原因
2. 我在.44那台服务器上的程序被管理员关了，因为是不收敛的，所以影响不是很大，听说最近要重装系统，所以最近的程序不能在.44上那台服务器上跑了		

#### 四、下周计划

1. 尝试使用各种核函数进行训练，希望能够找到能够使得训练数据收敛的核函数
具体方案是：

<table bordercolor="#006803" align="center" >
		<tr>
			<td> 使用的服务器 </td>
			<td> 训练的数据</td>
		</tr>
		<tr>
			<td> wxg@12.20.2.16 -screen mouse</td>
			<td> mouse_time -r 2（radial basis核函数）</td>
		</tr>
		<tr>
			<td> gang@12.20.2.2 -screen eye</td>
			<td> eye_subtissue -r 2（radial basis核函数）</td>
		</tr>
		<tr>
			<td> wxg@12.20.2.16 -screen body</td>
			<td> body_map -r 2(radial basis核函数)</td>
		</tr>
</table>

如果上述方案还训练不出来结果，那就使用transductive learning

2. 稍微准备一下六级