clear;clc;close all;
sift_path='.\test images\';
sift_path_list = dir(strcat(sift_path,'*.dsift'));
sift_num = length(sift_path_list)
dist_=load('dist.mat');
codebook_=load('codebook.mat');
dist=dist_.dist;
codebook=codebook_.codebook;

%% 计算每幅图子向量与对应码本之间距离，生成每幅图的编码
 for i = 0:sift_num-1
         sift_name = sift_path_list(i+1).name;
         indlas=strfind(sift_name,'.');
         sift_head_name=sift_name(1:indlas-1);
         fprintf('%d  %s\n',i+1,sift_head_name);
         sift_path_name=strcat(sift_path,sift_name);
         fid = fopen(sift_path_name, 'rb');
         [sift local]=readSIFT(fid);                                        %%%读取SIFT特征和SIFT对应的坐标
         fclose(fid);

 sift=sift ./ repmat(sqrt(sum(sift.^2)), size(sift, 1), 1);  
         siftT=sift';
% siftT=siftT ./ repmat(sqrt(sum(siftT.^2)), size(siftT, 1), 1);  
         sz=size(sift);
         code=zeros(16,sz(2));
         for j=0:15
            siftT_temp=siftT(:,8*j+1:8*(j+1));

            dist2=pdist2(siftT_temp,codebook(:,:,j+1));    %%%计算距离   
            [minn indexx]=min(dist2');                                                 %%%找到最小距离的编码

           code(j+1,:)=indexx;
         end
         save(strcat(sift_head_name,'.mat'),'code');                            %%%保存图像的编码
         local_name=strcat(sift_head_name,'_local');                         %%%保存SIFT对应的坐标
         save(strcat(local_name,'.mat'),'local'); 
 end

