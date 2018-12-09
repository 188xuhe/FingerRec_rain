function [image_seg,g] = segment_filter(image,grad,m,n)
%SEGMENT_FILTER �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%% �ݶ�ͼ���ֵ��
image=double(image);
grad=grad/max(grad(:));
se = strel('square',16);
grad_open = imopen(grad,se);
grad_close = imclose(grad_open,se);
figure,imshow(grad_close),title('���ز���');

grad = grad_close;

hp=imhist(grad);
hp(1)=0;
T=otsuthresh(hp);%�ɶԱȿ���graythresh
g=imbinarize(grad,T);
g(1:8,:)=0;
g(:,1:8)=0;
g(m-7:m,:)=0;
g(:,n-7:n)=0;
figure,imshow(g),title('�ָ�����');
%% ͼ��ָ�
image_seg=image .* g;

%% 
% image_seg=image_g+255*(1-g);
% figure,imshow(image_seg,[0 255]),title('�������');
end

