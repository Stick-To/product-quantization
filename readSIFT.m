function [SITF local]=readSIFT(fid)
siftDim = 128;
featNum = fread(fid, 1, 'int32'); % �ļ���SIFT��������Ŀ
SiftFeat = zeros(siftDim, featNum); 
paraFeat = zeros(4, featNum);
for j = 1 : featNum % �����ȡSIFT����
    SITF(:, j) = fread(fid, siftDim, 'uchar'); %�ȶ���128ά������
    local(:, j) = fread(fid, 4, 'float32');     %�ٶ���[x, y, scale, orientation]��Ϣ
end
