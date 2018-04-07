clear;clc;close all;
x_image_path='.\test images\';
y_image_path='.\test images\';
x_image_name='ukbench00052.jpg';
y_image_name='ukbench00053.jpg';
code_path='.\';
local_path='.\';
dist_path='.\';

indlas=strfind(x_image_name,'.');
x_head_name=x_image_name(1:indlas-1);
indlas=strfind(y_image_name,'.');
y_head_name=y_image_name(1:indlas-1);

%% 载入图像编码
x_code_name=strcat(code_path,x_head_name);
x_code_name=strcat(x_code_name,'.mat');
y_code_name=strcat(code_path,y_head_name);
y_code_name=strcat(y_code_name,'.mat');
x_code_=load(x_code_name);
y_code_=load(y_code_name);
x_code=x_code_.code;
y_code=y_code_.code;

%%%载入坐标
x_local_name=strcat(x_head_name,'_local');
y_local_name=strcat(y_head_name,'_local');
x_local_name=strcat(x_local_name,'.mat');
y_local_name=strcat(y_local_name,'.mat');
x_local_=load(x_local_name);
x_local=x_local_.local;
x_local_axis=x_local(1:2,:);
y_local_=load(y_local_name);
y_local=y_local_.local;
y_local_axis=y_local(1:2,:);

%%%载入距离矩阵
dist_name=strcat(dist_path,'dist.mat');
dist_=load(dist_name);
dist=dist_.dist;

%%%图像拼接
x_image=imread(strcat(x_image_path,x_image_name));
y_image=imread(strcat(y_image_path,y_image_name));
sz_x_image=size(x_image);
sz_y_image=size(y_image);
xy_image=[x_image y_image];
imshow(xy_image)
hold on
sz_x_code=size(x_code);
sz_y_code=size(y_code);


%% 查询
for i=1:sz_x_code(2)
    dist_match=zeros(1,sz_y_code(2));
    for j=1:sz_y_code(2)
        for k=1:16   
            dist_match(1,j)=dist_match(1,j)+dist(x_code(k,i),y_code(k,j),k);      %%%查询距离矩阵计算距离
        end
        
    end    
    dist_match=dist_match.^(1/2);
    [nearest1 index]=min(dist_match);                                                   %%% 找到最近临
    dist_match(index)=10e100;
    [nearest2 index2]=min(dist_match);                                                  %%% 找到次近邻
    ratio=nearest1/nearest2;

    if ratio<0.8                                                                                      %%% 如果满足距离条件
        beginn=[x_local_axis(1,i),y_local_axis(1,index)+sz_x_image(2)];
        endd=[x_local_axis(2,i),y_local_axis(2,index)];
        plot(beginn,endd,'g');                                                                      %%%连线
        
    end
    if i>15                                                                 %%%测试前15个特征
        break
    end
end
