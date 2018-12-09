function [image_seg,g] = segment_filter(image,grad,m,n)
%SEGMENT_FILTER 此处显示有关此函数的摘要
%   此处显示详细说明
%% 梯度图像二值化
image=double(image);
grad=grad/max(grad(:));
se = strel('square',16);
grad_open = imopen(grad,se);
grad_close = imclose(grad_open,se);
figure,imshow(grad_close),title('开关操作');

grad = grad_close;

hp=imhist(grad);
hp(1)=0;
T=otsuthresh(hp);%可对比考虑graythresh
g=imbinarize(grad,T);
g(1:8,:)=0;
g(:,1:8)=0;
g(m-7:m,:)=0;
g(:,n-7:n)=0;
figure,imshow(g),title('分割区域');
%% 图像分割
image_seg=image .* g;

%% 
% image_seg=image_g+255*(1-g);
% figure,imshow(image_seg,[0 255]),title('清除背景');
end

