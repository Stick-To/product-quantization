clear;clc;close all;
%%%%%��kmeans���������������б��ļ�����
%%%     ����ѵ������
data_=load('siftTrain.mat');
data=data_.siftTrain;
data= data./ repmat(sqrt(sum(data.^2)), size(data, 1), 1);         %%%��������һ��
dataT=data';
% dataT= dataT./ repmat(sqrt(sum(dataT.^2)), size(dataT, 1), 1);
opts=statset('MaxIter',1000);

%%     ѵ������
%%%     dataT_temp��ÿ��ѵ����������
%%%     codebook����ÿ���������������ģ�64 x 64 x 16
%%%     dist����ÿ��ÿ����������������֮��ŷʽ�����ƽ��   64 x 64 x 16
for i = 0:15
    dataT_temp=dataT(:,8*i+1:8*(i+1));
    [km_index km_centorid]=kmeans(dataT_temp,64,'Options',opts);

    codebook(:,:,i+1)=km_centorid;
    dist_temp=pdist(codebook(:,:,i+1) );
    dist_temp=squareform(dist_temp);
    dist(:,:,i+1)=dist_temp.^2;
    

end

save('dist.mat', 'dist');   %����������
save('codebook.mat', 'codebook'); % �����뱾
