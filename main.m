clc
clear
close all
image1=imread('H:\项目\keilproject\python\finger10.jpg');
image1 = double(image1);
%% 图像翻转
image1 = flip_image(image1);
figure,imshow(image1,[0 255]);

%% pad image
image1 = pad_image(image1, 16);
figure,imshow(image1,[0 255]),title('图像扩展');

%% 尺寸
[m,n] = getsize(image1);

%% 梯度
[gradx,grady,grad] = getgrad(image1,m,n,6);
figure,imshow(grad,[0 255]),title("梯度");

%% 分割
[image1_seg,g]=segment_filter(image1,grad,m,n);
figure,imshow(image1_seg,[0 255]),title('图像分割');

%% 指纹归一化
image1_norm = normalize_image(image1,50,50);
figure,imshow(image1_norm,[0 255]),title('图像归一化');

%% 指纹块方向图
image1_orient = blk_orientation_image(image1,16);
%figure,imshow(image1_orient,[0 3.14]),title('块方向图');

%% 方向场平滑
image1_orient_smooth = smoothen_orientation_field(image1_orient);

%% 指纹频率场
imge1_fre = frequency_image(image1,image1_orient_smooth,m,n,16);

%% 频率场平滑
image1_fre_smooth = filter_frequency_image(imge1_fre);

%% gabor增强
image1_gabor = do_gabor_filtering(image1,image1_orient_smooth,image1_fre_smooth,m,n,16);     %gobor滤波增强图像
image1_gabor(g==0)=1;
figure,imshow(image1_gabor),title('gabor图像');

%% 细化
% image1_thin = bwmorph(image1_gabor,'skel',5);
image1_thin = thin4(image1_gabor);
figure,imshow(image1_thin),title('图像细化');

%% 去除短棒和毛刺

%% 求取细节点特征







