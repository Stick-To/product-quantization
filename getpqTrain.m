%%
% �˴������������SIFT ѵ����������
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
        featNum = fread(fid, 1, 'int32'); % �ļ���SIFT��������Ŀ
        SiftFeat = zeros(siftDim, featNum); 
        paraFeat = zeros(4, featNum);
        for j = 1 : featNum % �����ȡSIFT����
            SiftFeat(:, j) = fread(fid, siftDim, 'uchar'); %�ȶ���128ά������
%             SiftFeat(:, j) = SiftFeat(:, j) ./ repmat(sqrt(sum(SiftFeat(:, j).^2)), size(SiftFeat(:, j), 1), 1);

            paraFeat(:, j) = fread(fid, 4, 'float32');     %�ٶ���[x, y, scale, orientation]��Ϣ
        end
        fclose(fid);
        

        siftDescriptorTrain = [siftDescriptorTrain, SiftFeat];
    end
end

P = randperm(size(siftDescriptorTrain, 2));
siftTrain = siftDescriptorTrain(:, P(1:20000));
save('siftTrain.mat', 'siftTrain'); % ����20K��SIFT����������ѵ��

