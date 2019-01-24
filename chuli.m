function X1=chuli(X1,m,n)
%   将图像缩减一个像素大小
X1(1,:)=zeros(1,n);
X1(m,:)=zeros(1,n);
X1(:,1)=zeros(m,1);
X1(:,n)=zeros(m,1);
