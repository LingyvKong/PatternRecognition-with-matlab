# PatternRecognition-with-matlab

使用matlab从0构建模式识别算法



**声明：** 本仓库中的所有代码及博客中的原理均为原创。`转载和使用请注明出处。`

代码仓库地址：https://github.com/LingyvKong/PatternRecognition-with-matlab

博客地址：https://kppkkp.ml/

## 一、包含的内容

1. 贝叶斯分类
  - 使用最大似然法进行参数估计
  - 使用直方图和parzen窗（均匀核+高斯核）进行非参数估计
  - 对测试集分类
  - 画出决策面
2. fisher线性判别

  - 求出决策面方程
  - 对测试集分类
  - 画出决策面
  - 画出投影直线

3. 感知器

  - 动画展示训练过程
  - 对测试集分类

4. Otsu阈值分割

  - 显示原始图像及其灰度分布
  - 显示Otsu二值化结果
  - 将Otsu结果使用5*5的均值滤波后的结果

5. PCA人脸识别

  - 显示PCA的特征脸
  - 显示一张脸使用特征脸还原的结果
  - 使用最小距离进行人脸识别，显示准确率

## 二、运行方法

1. 贝叶斯分类

   MATLAB中直接运行`\Bayes\exp1.m`脚本文件

   运行时间可能需要几分钟。默认为`GIRLdatas`数据集。如需查看其它数据集，请自行更改路径和数据集名称。

2. fisher线性判别

   MATLAB中直接运行`\fisher\exp2.m`脚本文件

   运行时间可能需要几分钟。

3. 感知器

   MATLAB中直接运行`\perception\exp3.m`脚本文件

4. MSE

   MATLAB中直接运行`\perception\exp3_1_mse.m`脚本文件

5. Otsu

   MATLAB中直接运行`\PCA\Otsu.m`脚本文件

6. PCA人脸识别

   - 先运行`\PCA\exp4.m`，可以得到特征脸及还原示例
   - 再运行`\PCA\face_recognized.m`进行人脸识别。
   - 注：`\PCA\bigFai.m`的效果等同于`\PCA\exp4.m`,但是在相同配置下，后者只需5秒，前者需要7分钟。



**程序全部通过 MATLAB R2016b 验证，如无法运行欢迎提交issue**