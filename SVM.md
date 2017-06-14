[TOC]

### 监督学习和无监督学习
&emsp;&emsp;监督学习：常叫分类。通过已有的训练样本训练得到一个最优模型，输入的测试集利用这个模型映射为相应的输出结果，对输出结果进行简单判断实现分类。典型例子KNN、SVM。

&emsp;&emsp;无监督学习：事先没有训练样本，直接对数据进行建模。典型例子聚类。

### SVM（support vector machines，支持向量机）
&emsp;&emsp;它是一种二类分类模型，其基本模型定义为特征空间上的间隔最大的线性分类器，即向量机的学习策略是距离间隔最大化，最终可以转化为一个凸二次型的求解。

#### 1 线性分类

##### 1.1 分类标准

&emsp;&emsp;考虑两类分类问题，数据点用x表示，是一个`$w^T$`表示系数转置矩阵，而类别用y来表示，可以取1或者-1，代表不同类。线性分类器的学习目标就是要在n维中找到一个分类超平面，其方程可以表示为：
```math
w^Tx + b = 0 
```
其中 `$w^Tx = w_1x_1 + w_2x_2 + \cdots + w_nx_n$`



##### 1.2 logistic回归

&emsp;&emsp;回归：给出数据点，寻找一条直线对这些点进行拟合，拟合过程称为回归。

logistic回归的主要思想是：根据现有的分类边界建立回归公式，以此进行分类。训练分类器时就是要寻找最佳的拟合参数。Logistic回归目的是从特征学习出一个0/1分类模型，给定测试集输出的结果只有一个0/1。sigmoid函数具有类似的性质，其公式如下：
```math
f(z) = \frac{1}{1 + e^{-z}}
```
 该函数图像如下：
 
![image](E:/DataScience/picture/simmoid.jpg)

这样的话任何大于0.5的数据被分人1类，小于0.5即被归人0类。

##### 1.3 形式化

&emsp;&emsp;令`$z = w^Tx + b$`,可得如下映射：
```math
g(z) = 
\begin{cases}
1, & {z \ge 0} \\
-1, & {z < 0}
\end{cases}
```



#### 2 SVM

##### 2.1 间隔

![image](E:/DataScience/picture/pm1.png)

红色直线为超平面，可将粉红色和蓝色两类数据分开。
```math
f(x) = w^Tx + b 
```
f(x)=0为超平面，f(x)<0，对应y=-1的数据点，而f(x)>0 则对应y=1的数据点。将超平面记为`$(w,b)$`，样本任一点到`$(w,b)$`的距离为
```math
r = \frac {|w^Tx + b|} {||w||}
```
假设超平面`$(w,b)$`能将训练集正确分类，即对于`$(x_i,y_i) \in D $`，若`$y_i = +1 $`，则有`$w^Tx_i + b>0 $`，若`$y_i = -1 $`，则有`$w^Tx_i + b<0 $`。令
```math
\begin{cases}
w^Tx_i + b \ge +1, & y_i = +1 \\
w^Tx_i + b \le -1, & y_i = -1 
\end{cases}
\qquad\qquad (2.1)
```
距离超平面最近的使上式的等号成立这几个训练样本点称为“支持向量”，两个异类支持向量到超平面的距离和为`$\gamma = \frac {2}{||w||}$`，它被称为“间隔”。

![image](E:/DataScience/picture/pm2.PNG)

而我们的目的找到两个异类支持向量到超平面的距离和最大，这样的超平面才有最好的容错，即鲁棒性强。也就是要找到满足(2.1)式中约束的参数w和b，使`$\gamma$`最大。即
```math
\begin{matrix}
\min_{w,b} \quad \frac {1}{2}||w||^2 \\
s.t. \quad y_i(w^Tx_i + b) \ge 1,\quad i = 1,2,...,n
\end{matrix}
\qquad\qquad (2.2)
```
多元函数求极值：f(x,y)在点`$(x_0,y_0)$`处有偏导且有极值，则有偏导数
```math
f_x(x_0,y_0) = 0 \quad f_y(x_0,y_0) = 0
```
有条件函数求极值
```math
z = f(x,y)

s.t. \quad \varphi(x,y) = 0

```
`$\varphi(x,y) = 0 \quad \Rightarrow \quad y = \psi(x) \quad \Rightarrow \quad z = f[x,\psi(x)] $`

```math
{\frac {dz}{dx}}|_{x=x_0} = f_x + f_y {\frac{dy}{dx}}|_{x=x_0} = 0 \qquad \qquad (2.3)
```
隐函数求导
```math
{\frac{dy}{dx}}|_{x=x_0} = - \frac {\varphi_x}{\varphi_y}
```
代入（2.3）得
```math
 {\frac {dz}{dx}}|_{x=x_0} = f_x - f_y \frac {\varphi_x}{\varphi_y} = 0 
```
设`$ \frac {f_y}{\varphi_y} = -\lambda$`,上述的 必要条件就变为
```math
\begin{cases}
f_x(x_0,y_0) + \lambda \varphi_x(x_0,y_0) = 0,\\
f_y(x_0,y_0) + \lambda \varphi_y(x_0,y_0) = 0,\\
\varphi(x_0,y_0) = 0
\end{cases}
```
引入辅助函数
```math
L(x,y,\lambda) = f(x,y) + \lambda \varphi(x,y)
```
此为拉格朗日函数 `$\lambda$` 称为拉格朗日乘子。取极值时有偏导数
```math
L_x(x_0,y_0) = L_y(x_0,y_0) = 0
```

##### 2.2 对偶问题

&emsp;&emsp;对(2.2)构造拉格朗日函数
```math
L(w,b,\lambda) = \frac {1}{2}||w||^2 + \sum_{i=1}^n \lambda_i(1 - y_i(w^Tx_i + b)) \qquad \qquad (2.4)

g_i(w) = 1 - y_i(w^Tx_i + b)
```
其要满足KKT条件
```math
\left.
\begin{array}{l}
\quad\lambda_i \ge 0 \\
g_i(w) \le 0
\end{array}
\right\}
\quad \Rightarrow \quad
\lambda_ig_i(w) \le 0

\max_\lambda L(w,b,\lambda) = \frac {1}{2}||w||^2

\min_{w,b}\frac {1}{2}||w||^2 = \min_{w,b} \max_\lambda L(w,b,\lambda)
```
![image](E:/DataScience/picture/KKT1.jpg)
![image](E:/DataScience/picture/KKT2.jpg)
```math
\begin{cases}
\frac {\partial L}{\partial x} = 0, \\
\frac {\partial L}{\partial y} = 0
\end{cases}
\quad \Rightarrow \quad
\begin{cases}
w = \sum_{i=1}^n \lambda_iy_ix_i, \\
0 = \sum_{i=1}^n \lambda_iy_i
\end{cases}
\quad \quad \quad(2.5)
```
w和x都是n\*1的列向量。||w||是2-范数（欧几里得范数，常用计算向量长度）。`$||w||_2 = (\sum_{i=1}^n |w_i|^2)^{\frac{1}{2}} = (s_w)^{\frac{1}{2}}$`。

范数和矩阵求导
```math
\frac{\partial {||w||_2}^2}{\partial w} = \frac{\partial s_w}{\partial w} =
\begin{bmatrix}
\frac{\partial s_w}{\partial w_1} \\
\frac{\partial s_w}{\partial w_2} \\
\vdots \\
\frac{\partial s_w}{\partial w_n}
\end{bmatrix}
= 2w

\frac{\partial w^T}{\partial w} = 
\begin{bmatrix}
\frac{\partial w_1}{\partial w_1} & \frac{\partial w_2}{\partial w_1} & \cdots & \frac{\partial w_n}{\partial w_1} \\
\frac{\partial w_1}{\partial w_2} & \frac{\partial w_2}{\partial w_2} & \cdots & \frac{\partial w_n}{\partial w_2} \\
\vdots & \vdots & \ddots & \vdots \\
\frac{\partial w_1}{\partial w_n} & \frac{\partial w_2}{\partial w_n} & \cdots & \frac{\partial w_n}{\partial w_n}
\end{bmatrix}
=
\begin{bmatrix}
1 & 0 & \cdots & 0 \\
0 & 1 & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & 1
\end{bmatrix}
```
从矩阵求导可得出列向量n\*1的转置对自身求导为一个n\*n的单位矩阵。将（2.5）代入（2.5）得L
```math
L(w,b,\lambda) = \frac{1}{2}\sum_{i,j=1}^n\lambda_i\lambda_jy_iy_jx_i^Tx_j - \sum_{i,j=1}^n\lambda_i\lambda_jy_iy_jx_i^Tx_j - b\sum_{i=1}^n\lambda_iy_i + \sum_{i=1}^n\lambda_i 

= \sum_{i=1}^n\lambda_i - \frac{1}{2}\sum_{i,j=1}^n\lambda_i\lambda_jy_iy_jx_i^Tx_j

s.t. \quad \sum_{i=1}^n\lambda_iy_i = 0,

\lambda_i \ge 0, \quad i=1,2,...,n
```
解出`$\lambda$`后，求出w与b即可得到模型

`$\qquad f(x) = w^Tx + b = \sum_{i=1}^n\lambda_iy_ix_i^Tx + b$`

##### 2.3 SMO（序列最小优化算法）












