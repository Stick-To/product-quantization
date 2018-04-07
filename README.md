# product-quantization
product quantization image processing algorithm with matlab

乘积量化
getpqTrain.m   获取训练数据，保存为siftTrain.mat
getpqcodebook.m  训练数据，码本保存为codebook.mat，距离矩阵保存为dist.mat，若kmeans迭代出错重新运行本文件即可										
productq.m       乘积量化，每幅图像对应编码保存为.mat，对应坐标保存为_local.mat
pqmatching.m    匹配        

