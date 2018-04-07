%%
% 此代码仅用于生成SIFT 训练样本数据
%

clear;
close all;
clc;

siftDim = 128

allFiles = dir('test images');
siftDescriptorTrain = [];
for i = 3 : length(allFiles)
    fileName = allFiles(i).name;
    if strcmp(fileName(end-5 : end), '.dsift') == 1
        featPath = ['test images\', fileName];
        fid = fopen(featPath, 'rb');
        featNum = fread(fid, 1, 'int32'); % 文件中SIFT特征的数目
        SiftFeat = zeros(siftDim, featNum); 
        paraFeat = zeros(4, featNum);
        for j = 1 : featNum % 逐个读取SIFT特征
            SiftFeat(:, j) = fread(fid, siftDim, 'uchar'); %先读入128维描述子
%             SiftFeat(:, j) = SiftFeat(:, j) ./ repmat(sqrt(sum(SiftFeat(:, j).^2)), size(SiftFeat(:, j), 1), 1);

            paraFeat(:, j) = fread(fid, 4, 'float32');     %再读入[x, y, scale, orientation]信息
        end
        fclose(fid);
        

        siftDescriptorTrain = [siftDescriptorTrain, SiftFeat];
    end
end

P = randperm(size(siftDescriptorTrain, 2));
siftTrain = siftDescriptorTrain(:, P(1:20000));
save('siftTrain.mat', 'siftTrain'); % 保留20K个SIFT描述子用于训练

