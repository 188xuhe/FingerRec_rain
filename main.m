clc
clear
close all
image1=imread('H:\��Ŀ\keilproject\python\finger10.jpg');
image1 = double(image1);
%% ͼ��ת
image1 = flip_image(image1);
figure,imshow(image1,[0 255]);

%% pad image
image1 = pad_image(image1, 16);
figure,imshow(image1,[0 255]),title('ͼ����չ');

%% �ߴ�
[m,n] = getsize(image1);

%% �ݶ�
[gradx,grady,grad] = getgrad(image1,m,n,6);
figure,imshow(grad,[0 255]),title("�ݶ�");

%% �ָ�
[image1_seg,g]=segment_filter(image1,grad,m,n);
figure,imshow(image1_seg,[0 255]),title('ͼ��ָ�');

%% ָ�ƹ�һ��
image1_norm = normalize_image(image1,50,50);
figure,imshow(image1_norm,[0 255]),title('ͼ���һ��');

%% ָ�ƿ鷽��ͼ
image1_orient = blk_orientation_image(image1,16);
%figure,imshow(image1_orient,[0 3.14]),title('�鷽��ͼ');

%% ����ƽ��
image1_orient_smooth = smoothen_orientation_field(image1_orient);

%% ָ��Ƶ�ʳ�
imge1_fre = frequency_image(image1,image1_orient_smooth,m,n,16);

%% Ƶ�ʳ�ƽ��
image1_fre_smooth = filter_frequency_image(imge1_fre);

%% gabor��ǿ
image1_gabor = do_gabor_filtering(image1,image1_orient_smooth,image1_fre_smooth,m,n,16);     %gobor�˲���ǿͼ��
image1_gabor(g==0)=1;
figure,imshow(image1_gabor),title('gaborͼ��');

%% ϸ��
% image1_thin = bwmorph(image1_gabor,'skel',5);
image1_thin = thin4(image1_gabor);
figure,imshow(image1_thin),title('ͼ��ϸ��');

%% ȥ���̰���ë��

%% ��ȡϸ�ڵ�����







