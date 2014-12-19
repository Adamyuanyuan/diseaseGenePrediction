##<center>本周工作报告_9</center>

######<center>2014.12.10</center>

#### 一、之前的思路总结
接上之前的内容，我之前的工作思路大致是：

- 分别使用Toppgene -> SVMLight -> SVMrank -> transtive SVM 针对不同的核函数进行疾病基因预测的训练

- 使用双层的相关疾病基因推荐，不过第一层使用的是SVMRank的方法将初始数据进行训练，第二层准备使用余弦定理的方法将第一层的训练结果再加入其它的结果进行计算并排序

- SVMRank 使用不同的核函数对部分数据都有迭代不出来的问题

#### 二、本周工作

- 使用svmRank对RNA-seq，humanbody，microarray的数据用svmRank进行训练
尝试使用各种核函数进行训练，希望能够找到能够使得训练数据收敛的核函数
(具体方案见工作记录：)
对结果进行了分析并总结：

<table bordercolor="#006803" align="center" >
		<tr>
			<td> 使用的服务器 </td>
			<td> 训练的数据</td>
			<td> 最优核函数</td>
			<td> 迭代次数</td>
			<td> 训练结果</td>
		</tr>
		<tr>
			<td> wxg@12.20.2.2 -screen mouse</td>
			<td> mouse_time </td>
			<td> -r 0（线性核函数）</td>
			<td> 80</td>
			<td> 约118小时</td>
		</tr>
		<tr>
			<td> gang@12.20.2.2 -screen eye</td>
			<td> eye_subtissue </td>
			<td> -r 2（radial basis核函数）</td>
			<td> 8</td>
			<td> 45分钟</td>
		</tr>
		<tr>
			<td> wxg@12.20.2.16 -screen body</td>
			<td> body_map </td>
			<td> -r 2（radial basis核函数）</td>
			<td> 超时</td>
			<td> 线性与radial均迭代超时</td>
		</tr>
</table>
**分析原因：**用SVM的方法好像不管用，速度也有些慢，可能transductive的方法更好一些
所以之后我还是准备在第一层使用transductive的方法，但是对negative的基因进行一定的优化

- 重新用优化过的transductive learning 的方法来训练Toppgene的数据，并将结果进行比较
训练比较代码分别放在E:\workspace\transtuctive_mul.R 文件中，比较结果整合在了topGeneResult.xlsx文件中。比较结果如下：

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;border-color:#999;}
.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#999;color:#444;background-color:#F7FDFA;}
.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#999;color:#fff;background-color:#26ADE4;}
.tg .tg-vn4c{background-color:#D2E4FC}
</style>
<table class="tg">
  <tr>
    <th class="tg-031e">452 gene</th>
    <th class="tg-031e">tools</th>
    <th class="tg-031e">top 100</th>
    <th class="tg-031e">200</th>
    <th class="tg-031e">300</th>
    <th class="tg-031e">400</th>
    <th class="tg-031e">500</th>
    <th class="tg-031e">600</th>
    <th class="tg-031e">700</th>
    <th class="tg-031e">800</th>
    <th class="tg-031e">900</th>
    <th class="tg-031e">1000</th>
    <th class="tg-031e">1100</th>
    <th class="tg-031e">1200</th>
    <th class="tg-031e">1300</th>
    <th class="tg-031e">1400</th>
  </tr>
  <tr>
    <td class="tg-vn4c"></td>
    <td class="tg-vn4c">TTP</td>
    <td class="tg-vn4c">4</td>
    <td class="tg-vn4c">7</td>
    <td class="tg-vn4c">10</td>
    <td class="tg-vn4c">13</td>
    <td class="tg-vn4c">15</td>
    <td class="tg-vn4c">16</td>
    <td class="tg-vn4c">20</td>
    <td class="tg-vn4c">24</td>
    <td class="tg-vn4c">29</td>
    <td class="tg-vn4c">36</td>
    <td class="tg-vn4c">42</td>
    <td class="tg-vn4c">53</td>
    <td class="tg-vn4c">57</td>
    <td class="tg-vn4c">61</td>
  </tr>
  <tr>
    <td class="tg-031e"></td>
    <td class="tg-031e">ToppGene的方法</td>
    <td class="tg-031e">10</td>
    <td class="tg-031e">26</td>
    <td class="tg-031e">38</td>
    <td class="tg-031e">48</td>
    <td class="tg-031e">61</td>
    <td class="tg-031e">69</td>
    <td class="tg-031e">82</td>
    <td class="tg-031e">86</td>
    <td class="tg-031e">92</td>
    <td class="tg-031e">97</td>
    <td class="tg-031e">103</td>
    <td class="tg-031e">106</td>
    <td class="tg-031e">110</td>
    <td class="tg-031e">118</td>
  </tr>
  <tr>
    <td class="tg-vn4c"></td>
    <td class="tg-vn4c">transductive_sorted_1</td>
    <td class="tg-vn4c">7</td>
    <td class="tg-vn4c">10</td>
    <td class="tg-vn4c">15</td>
    <td class="tg-vn4c">17</td>
    <td class="tg-vn4c">21</td>
    <td class="tg-vn4c">25</td>
    <td class="tg-vn4c">30</td>
    <td class="tg-vn4c">34</td>
    <td class="tg-vn4c">35</td>
    <td class="tg-vn4c">37</td>
    <td class="tg-vn4c">42</td>
    <td class="tg-vn4c">46</td>
    <td class="tg-vn4c">51</td>
    <td class="tg-vn4c">56</td>
  </tr>
  <tr>
    <td class="tg-031e"></td>
    <td class="tg-031e">transductive_sorted_2</td>
    <td class="tg-031e">1</td>
    <td class="tg-031e">1</td>
    <td class="tg-031e">2</td>
    <td class="tg-031e">2</td>
    <td class="tg-031e">4</td>
    <td class="tg-031e">6</td>
    <td class="tg-031e">6</td>
    <td class="tg-031e">8</td>
    <td class="tg-031e">8</td>
    <td class="tg-031e">11</td>
    <td class="tg-031e">12</td>
    <td class="tg-031e">14</td>
    <td class="tg-031e">16</td>
    <td class="tg-031e">19</td>
  </tr>
  <tr>
    <td class="tg-vn4c"></td>
    <td class="tg-vn4c">SVMRranksorted3</td>
    <td class="tg-vn4c">13</td>
    <td class="tg-vn4c">24</td>
    <td class="tg-vn4c">36</td>
    <td class="tg-vn4c">40</td>
    <td class="tg-vn4c">48</td>
    <td class="tg-vn4c">52</td>
    <td class="tg-vn4c">56</td>
    <td class="tg-vn4c">61</td>
    <td class="tg-vn4c">67</td>
    <td class="tg-vn4c">72</td>
    <td class="tg-vn4c">85</td>
    <td class="tg-vn4c">91</td>
    <td class="tg-vn4c">94</td>
    <td class="tg-vn4c">96</td>
  </tr>
  <tr>
    <td class="tg-031e"></td>
    <td class="tg-031e">SVMRranksorted4</td>
    <td class="tg-031e">1</td>
    <td class="tg-031e">2</td>
    <td class="tg-031e">3</td>
    <td class="tg-031e">4</td>
    <td class="tg-031e">6</td>
    <td class="tg-031e">9</td>
    <td class="tg-031e">10</td>
    <td class="tg-031e">12</td>
    <td class="tg-031e">12</td>
    <td class="tg-031e">15</td>
    <td class="tg-031e">15</td>
    <td class="tg-031e">17</td>
    <td class="tg-031e">17</td>
    <td class="tg-031e">17</td>
  </tr>
</table>

可以看出：transductive Toppgene的效果跟TTP的效果差不多，Toppgene的方法对Toppgene的数据是最好的，其次是svmRank，最后是transductive 的方法，但是transductive的方法并不是随机的，还是有一定区分作用的。

####三、遇到的问题
1. 找不到基因名字的对应，这个通过手动查询大师兄服务器上的文件就解决了
2. SVMRank效果好于transductive的方法，但是速度为什么那么慢，是不是我软件没有装好，解决方法，回头试一下libSVM等其它的svm的方法	

#### 四、以后计划

1. 优化并解决RankSVM迭代不收敛并且速度慢的问题（查看其它支持SVMRank软件）

2. 尝试不同的negativegene选择对训练结果的影响