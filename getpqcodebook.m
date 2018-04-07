clear;clc;close all;
%%%%%若kmeans迭代出错重新运行本文件即可
%%%     载入训练数据
data_=load('siftTrain.mat');
data=data_.siftTrain;
data= data./ repmat(sqrt(sum(data.^2)), size(data, 1), 1);         %%%二范数归一化
dataT=data';
% dataT= dataT./ repmat(sqrt(sum(dataT.^2)), size(dataT, 1), 1);
opts=statset('MaxIter',1000);

%%     训练数据
%%%     dataT_temp是每次训练的子向量
%%%     codebook保存每个子向量聚类中心，64 x 64 x 16
%%%     dist保存每个每个子向量聚类中心之间欧式距离的平方   64 x 64 x 16
for i = 0:15
    dataT_temp=dataT(:,8*i+1:8*(i+1));
    [km_index km_centorid]=kmeans(dataT_temp,64,'Options',opts);

    codebook(:,:,i+1)=km_centorid;
    dist_temp=pdist(codebook(:,:,i+1) );
    dist_temp=squareform(dist_temp);
    dist(:,:,i+1)=dist_temp.^2;
    

end

save('dist.mat', 'dist');   %保存距离矩阵
save('codebook.mat', 'codebook'); % 保存码本
