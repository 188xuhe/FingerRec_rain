clc
close all
M=0;var=0;
I2=imread('G:\ZKFinger SDK 5.0.0.20_20170424\ActiveX\samples\Delphi\Fingerprint.bmp');
[m,n] = size(I2);
I = double(I2);
%图像归一化
for x=1:m
 for y=1:n
  M=M+I(x,y);
 end
end
M1=M/(m*n);
for x=1:m
 for y=1:n
  var=var+(I(x,y)-M1)^2;
 end
end
var1=var/(m*n);
for x=1:m
 for y=1:n
  if I(x,y)>=M1
   I(x,y)=150+sqrt(2000*(I(x,y)-M1)/var1);
  else
   I(x,y)=150-sqrt(2000*(M1-I(x,y))/var1);
  end
 end
end
% figure, imshow(uint8(I));title('归一化');
%图像切割
M=3;
H=m/M;
L=n/M;
H=round(H)
L=round(L)
aveg1=zeros(H,L);
var1=zeros(H,L);
%计算每一方向块的灰度平均值
for x=1:H;
 for y=1:L;
   aveg=0;var=0;
  for i=1:M;
   for j=1:M;
     aveg=I(i+(x-1)*M,j+(y-1)*M)+aveg;
   end
  end
  aveg1(x,y)=aveg/(M*M);
  %计算每一方向块的方差
  for i=1:M;
   for j=1:M;
      var=(I(i+(x-1)*M,j+(y-1)*M)-aveg1(x,y)).^2+var;
   end
  end
    var1(x,y)=var/(M*M);
 end
end
Gmean=0;Vmean=0;
for x=1:H
 for y=1:L
    Gmean=Gmean+aveg1(x,y);
    Vmean=Vmean+var1(x,y);
 end
end 
Gmean1=Gmean/(H*L);%所有块的平均值
Vmean1=Vmean/(H*L);%所有快的方差

gtemp=0;gtotle=0;vtotle=0;vtemp=0;
for x=1:H
 for y=1:L
  if Gmean1>aveg1(x,y)
     gtemp=gtemp+1;
     gtotle=gtotle+aveg1(x,y);
  end
  if Vmean1<var1(x,y)
     vtemp=vtemp+1;
     vtotle=vtotle+var1(x,y);
  end
 end
end
G1=gtotle/gtemp;V1=vtotle/vtemp;

gtemp1=0;gtotle1=0;vtotle1=0;vtemp1=0;
for x=1:H
 for y=1:L
  if G1<aveg1(x,y)
     gtemp1=gtemp1-1;
     gtotle1=gtotle1+aveg1(x,y);
  end
  if 0<var1(x,y)<V1
     vtemp1=vtemp1+1;
     vtotle1=vtotle1+var1(x,y);
  end
 end
end
G2=gtotle1/gtemp1;V2=vtotle1/vtemp1;

e=zeros(H,L);
for x=1:H
 for y=1:L
   if aveg1(x,y)>G2&&var1(x,y)<V2
     e(x,y)=1;
   end
   if aveg1(x,y)<G1-100&&var1(x,y)<V2
   e(x,y)=1;
   end
 end
end
for x=2:H-1
 for y=2:L-1
  if e(x,y)==1
   if (e(x-1,y)+e(x-1,y+1)+e(x,y+1)+e(x+1,y+1)+e(x+1,y)+e(x+1,y-1)+e(x,y-1)+e(x-1,y-1))<=4
    e(x,y)=0;
   end
  end
 end
end
Icc=ones(m,n);
for x=1:H
 for y=1:L
  if e(x,y)==1
   for i=1:M
    for j=1:M
       I(i+(x-1)*M,j+(y-1)*M)=G1;
       Icc(i+(x-1)*M,j+(y-1)*M)=0;
    end
   end
  end
 end
end 
% figure,imshow(uint8(I));title('分割');
%二值化
temp=(1/9)*[1 1 1;1 1 1;1 1 1];%均值滤波
 Im=double(I);
 In=zeros(m,n);
for a=2:m-1;
 for b=2:n-1;
  In(a,b)=Im(a-1,b-1)*temp(1,1)+Im(a-1,b)*temp(1,2)+Im(a-1,b+1)*temp(1,3)+Im(a,b-1)*temp(2,1)+Im(a,b)*temp(2,2)+Im(a,b+1)*temp(2,3)+Im(a+1,b-1)*temp(3,1)+Im(a+1,b)*temp(3,2)+Im(a+1,b+1)*temp(3,3);
 end
end
I=In;
Im=zeros(m,n);
%寻求纹线方向
for x=5:m-5;
 for y=5:n-5;
  sum1=I(x,y-4)+I(x,y-2)+I(x,y+2)+I(x,y+4);
  sum2=I(x-2,y+4)+I(x-1,y+2)+I(x+1,y-2)+I(x+2,y-4);
  sum3=I(x-2,y+2)+I(x-4,y+4)+I(x+2,y-2)+I(x+4,y-4);
  sum4=I(x-2,y+1)+I(x-4,y+2)+I(x+2,y-1)+I(x+4,y-2);
  sum5=I(x-2,y)+I(x-4,y)+I(x+2,y)+I(x+4,y);
  sum6=I(x-4,y-2)+I(x-2,y-1)+I(x+2,y+1)+I(x+4,y+2);
  sum7=I(x-4,y-4)+I(x-2,y-2)+I(x+2,y+2)+I(x+4,y+4);
  sum8=I(x-2,y-4)+I(x-1,y-2)+I(x+1,y+2)+I(x+2,y+4);
  sumi=[sum1,sum2,sum3,sum4,sum5,sum6,sum7,sum8];
  summax=max(sumi);
  summin=min(sumi);
  summ=sum(sumi);
  b=summ/8;
  if(summax+summin+4*I(x,y))>(3*summ/8)
   sumf=summin;
  else
   sumf=summax;
  end
  if sumf>b
   Im(x,y)=128;
  else
   Im(x,y)=255;
  end
 end
end
%将三个连成图分成单个图像   至于为何出现三个图像？？？？？？？
S=round(n)
Icc=Icc(1:m,1:S)
% imwrite(b,'part.jpg')
% figure,imshow(double(Icc));title('二值化1'); 
 for i=1:m
for j=1:S
    Icc(i,j)=Icc(i,j)*Im(i,j);
 end
 end
% figure,imshow(double(Icc));title('二值化2');

for i=1:m
 for j=1:S
  if(Icc(i,j)==128)
   Icc(i,j)=0;
  else
   Icc(i,j)=1;
  end
 end
end
% figure,imshow(double(Icc));title('二值化3'); 

%去除空洞与毛刺
u=Icc;
%去毛刺
[m,n]=size(u)
for x=2:m-1
for y=2:n-1
if u(x,y)==0
if u(x,y-1)+u(x-1,y)+u(x,y+1)+u(x+1,y)>=3
u(x,y)=1;
end 
else u(x,y)=u(x,y);
end
end
end 
% figure,imshow(u);title('去毛刺');
%去空洞
% % % % % % % % % % % 3乘3去除模板
for i=2:(m-1)
    for j=2:(n-1)
        if(u(i,j)==1&u(i+1,j)==0&u(i+1,j-1)==0&u(i,j-1)==0&u(i-1,j-1)==0&u(i-1,j)==0&u(i-1,j+1)==0&u(i,j+1)==0&u(i+1,j+1)==0)
            u(i,j)=0;
        end
    end
end
% % % % % % % % % % % % % 4乘4消除模板
for i=2:(m-2)
    for j=2:(n-2)
        kl=0;
        if(u(i,j)==1)     kl=kl+1;     end
        if(u(i,j+1)==1)   kl=kl+1;     end
        if(u(i+1,j)==1)   kl=kl+1;     end
        if(u(i+1,j+1)==1) kl=kl+1;     end
        if(kl>=2&u(i-1,j-1)==0&u(i-1,j)==0&u(i-1,j+1)==0&u(i-1,j+2)==0&u(i,j+2)==0&u(i+1,j+2)==0&u(i+2,j+2)==0&u(i+2,j+1)==0&u(i+2,j)==0&u(i+2,j-1)==0&u(i+1,j-1)==0&u(i,j-1)==0)
            u(i,j)=0;u(i,j+1)=0;u(i+1,j)=0;u(i+1,j+1)=0;
        end
    end
end
% % % % % % % % % % % % % 5乘5消除模板
for i=2:(m-4)
    for j=2:(n-4)
        kl=0;
        if(u(i,j)==1)          kl=kl+1;       end
        if(u(i,j+1)==1)        kl=kl+1;       end
        if(u(i,j+2)==1)        kl=kl+1;       end
        if(u(i+1,j)==1)        kl=kl+1;       end
        if(u(i+1,j+1)==1)      kl=kl+1;       end
        if(u(i+1,j+2)==1)      kl=kl+1;       end
        if(u(i+2,j)==1)        kl=kl+1;       end
        if(u(i+2,j+1)==1)      kl=kl+1;       end
        if(u(i+2,j+2)==1)      kl=kl+1;       end
        if(kl>=4&u(i-1,j-1)==0&u(i-1,j)==0&u(i-1,j+1)==0&u(i-1,j+2)==0&u(i-1,j+3)==0&u(i,j+3)==0&u(i+1,j+3)==0&u(i+2,j+3)==0&u(i+3,j+3)==0&u(i+3,j+2)==0&u(i+3,j+1)==0&u(i+3,j)==0&u(i+3,j-1)==0&u(i+2,j-1)==0&u(i+1,j-1)==0&u(i,j-1)==0)
            u(i,j)=0;u(i,j+1)=0;u(i,j+2)=0;u(i+1,j)=0;u(i+1,j+1)=0;u(i+1,j+2)=0;u(i+2,j)=0;u(i+2,j+1)=0;u(i+2,j+2)=0;
        end
    end
end
% % % % % % % % % % % % % 6乘6消除模板
for i=2:(m-3)
    for j=2:(n-3)
        kl=0;
        if(u(i,j)==1)      kl=kl+1;     end
        if(u(i,j+1)==1)    kl=kl+1;     end
        if(u(i,j+2)==1)    kl=kl+1;     end
        if(u(i,j+3)==1)    kl=kl+1;     end
        if(u(i+1,j)==1)    kl=kl+1;     end
        if(u(i+1,j+1)==1)  kl=kl+1;     end
        if(u(i+1,j+2)==1)  kl=kl+1;     end
        if(u(i+1,j+3)==1)  kl=kl+1;     end
        if(u(i+2,j)==1)    kl=kl+1;     end
        if(u(i+2,j+1)==1)  kl=kl+1;     end
        if(u(i+2,j+2)==1)  kl=kl+1;     end
        if(u(i+2,j+3)==1)  kl=kl+1;     end
        if(u(i+3,j)==1)    kl=kl+1;     end
        if(u(i+3,j+1)==1)  kl=kl+1;     end
        if(u(i+3,j+2)==1)  kl=kl+1;     end
        if(u(i+3,j+3)==1)  kl=kl+1;     end
        if(kl>=6&u(i-1,j-1)==0&u(i-1,j)==0&u(i-1,j+1)==0&u(i-1,j+2)==0&u(i-1,j+3)==0&u(i-1,j+4)==0&u(i,j+4)==0&u(i+1,j+4)==0&u(i+2,j+4)==0&u(i+3,j+4)==0&u(i+4,j+4)==0&u(i+4,j+3)==0&u(i+4,j+2)==0&u(i+4,j+1)==0&u(i+4,j)==0&u(i+4,j-1)==0&u(i+3,j-1)==0&u(i+2,j-1)==0&u(i+1,j-1)==0&u(i,j-1)==0)
            u(i,j)=0;u(i,j+1)=0;u(i,j+2)=0;u(i,j+3)=0;u(i+1,j)=0;u(i+1,j+1)=0;u(i+1,j+2)=0;u(i+1,j+3)=0;u(i+2,j)=0;u(i+2,j+1)=0;u(i+2,j+2)=0;u(i+2,j+3)=0;u(i+3,j)=0;u(i+3,j+1)=0;u(i+3,j+2)=0;u(i+3,j+3)=0;
        end
    end
end
% % % % % % % % % % % % % 4乘6消除模板
for i=2:(m-4)
    for j=2:(n-2)
        kl=0;
        if(u(i,j)==1)     kl=kl+1;     end
        if(u(i,j+1)==1)   kl=kl+1;     end
        if(u(i+1,j)==1)   kl=kl+1;     end
        if(u(i+1,j+1)==1) kl=kl+1;     end
        if(u(i+2,j)==1)   kl=kl+1;     end
        if(u(i+2,j+1)==1) kl=kl+1;     end
        if(u(i+3,j)==1)   kl=kl+1;     end
        if(u(i+3,j)==1)   kl=kl+1;     end
        if(kl>=5&u(i-1,j-1)==0&u(i-1,j)==0&u(i-1,j+1)==0&u(i-1,j+2)==0&u(i,j+2)==0&u(i+1,j+2)==0&u(i+2,j+2)==0&u(i+3,j+2)==0&u(i+4,j+2)==0&u(i+4,j+1)==0&u(i+4,j)==0&u(i+4,j-1)==0&u(i+3,j-1)==0&u(i+2,j-1)==0&u(i+1,j-1)==0&u(i,j-1)==0)
            u(i,j)=0;u(i,j+1)=0;u(i+1,j)=0;u(i+1,j+1)=0;u(i+2,j)=0;u(i+2,j+1)=0;u(i+3,j)=0;u(i+3,j+1)=0;
        end
    end
end
% % % % % % % % % % % % % 5乘6消除模板
for i=2:(m-3)
    for j=2:(n-4)
        kl=0;
        if(u(i,j)==1)        kl=kl+1;   end
        if(u(i,j+1)==1)      kl=kl+1;   end
        if(u(i,j+2)==1)      kl=kl+1;   end
        if(u(i,j+3)==1)      kl=kl+1;   end
        if(u(i+1,j)==1)      kl=kl+1;   end
        if(u(i+1,j+1)==1)    kl=kl+1;   end
        if(u(i+1,j+2)==1)    kl=kl+1;   end
        if(u(i+1,j+3)==1)    kl=kl+1;   end
        if(u(i+2,j)==1)      kl=kl+1;   end
        if(u(i+2,j+1)==1)    kl=kl+1;   end
        if(u(i+2,j+2)==1)    kl=kl+1;   end
        if(u(i+2,j+3)==1)    kl=kl+1;   end
        if(kl>=4&u(i-1,j-1)==0&u(i-1,j)==0&u(i-1,j+1)==0&u(i-1,j+2)==0&u(i-1,j+3)==0&u(i-1,j+4)==0&u(i,j+4)==0&u(i+1,j+4)==0&u(i+2,j+4)==0&u(i+3,j+4)==0&u(i+3,j+3)==0&u(i+3,j+2)==0&u(i+3,j+1)==0&u(i+3,j)==0&u(i+3,j-1)==0&u(i+2,j-1)==0&u(i+1,j-1)==0&u(i,j-1)==0)
            u(i,j)=0;u(i,j+1)=0;u(i,j+2)=0;u(i,j+3)=0;u(i+1,j)=0;u(i+1,j+1)=0;u(i+1,j+2)=0;u(i+1,j+3)=0;u(i+2,j)=0;u(i+2,j+1)=0;u(i+2,j+2)=0;u(i+2,j+3)=0;
        end
    end
end
% % % % % % % % % % % % % 5乘7消除模板
for i=2:(m-3)
    for j=2:(n-5)
        kl=0;
        if(u(i,j)==1)        kl=kl+1;   end
        if(u(i,j+1)==1)      kl=kl+1;   end
        if(u(i,j+2)==1)      kl=kl+1;   end
        if(u(i,j+3)==1)      kl=kl+1;   end
        if(u(i,j+4)==1)      kl=kl+1;   end
        if(u(i+1,j)==1)      kl=kl+1;   end
        if(u(i+1,j+1)==1)    kl=kl+1;   end
        if(u(i+1,j+2)==1)    kl=kl+1;   end
        if(u(i+1,j+3)==1)    kl=kl+1;   end
        if(u(i+1,j+4)==1)    kl=kl+1;   end
        if(u(i+2,j)==1)      kl=kl+1;   end
        if(u(i+2,j+1)==1)    kl=kl+1;   end
        if(u(i+2,j+2)==1)    kl=kl+1;   end
        if(u(i+2,j+3)==1)    kl=kl+1;   end
        if(u(i+2,j+4)==1)    kl=kl+1;   end
        if(kl>=6&u(i-1,j-1)==0&u(i-1,j)==0&u(i-1,j+1)==0&u(i-1,j+2)==0&u(i-1,j+3)==0&u(i-1,j+4)==0&u(i-1,j+5)==0&u(i,j+5)==0&u(i+1,j+5)==0&u(i+2,j+5)==0&u(i+3,j+5)==0&u(i+3,j+4)==0&u(i+3,j+3)==0&u(i+3,j+2)==0&u(i+3,j+1)==0&u(i+3,j)==0&u(i+3,j-1)==0&u(i+2,j-1)==0&u(i+1,j-1)==0&u(i,j-1)==0)
            u(i,j)=0;u(i,j+1)=0;u(i,j+2)=0;u(i,j+3)=0;u(i,j+4)=0;u(i+1,j)=0;u(i+1,j+1)=0;u(i+1,j+2)=0;u(i+1,j+3)=0;u(i+1,j+4)=0;u(i+2,j)=0;u(i+2,j+1)=0;u(i+2,j+2)=0;u(i+2,j+3)=0;u(i+2,j+3)=0;
        end
    end
end

figure(9)
imshow(u);
%细化
v=~u;%返回与u相同大小相反值的逻辑数组
img=bwmorph(v,'thin',Inf);%对二值化图像进行形态学细化操作直到Inf为止
for x=2:m-1
    for y=2:n-1
        if img(x,y)==1
            if (img(x-1,y)==1&&img(x,y-1)==1)||(img(x-1,y)==1&&img(x,y-1)==1)||(img(x,y-1)==1&&img(x+1,y)==1)||(img(x+1,y)==1&&img(x,y+1)==1)
                img(x,y)=0;
            end
        end
    end
end
X=img;

% % % % % % % % % % % % % % % % % % % % % % % % % 第二部分寻求特征点
[m,n]=size(X);
X1=X;
figure(7)
subplot(1,2,1)
imshow(~X);
hold on
% if(mod(m,2)==0)
%      l=m/2;
% else 
%      l=(m+1)/2;
% end
% if(mod(n,2)==0)
%      d=n/2;
% else 
%      d=(n+1)/2;
% end


M=zeros(200,2);count1=0;%端点的坐标   及    个数
N=zeros(200,2);count2=0;%分叉点的坐标  及   个数
X1=chuli(X1,m,n);%    将镜像图像缩小一个像素点
for a=(2):(m-1);
    for b=(2):(n-1);
% for a=l-50:l+50
%     for b=(d-50):(d+50)
        if(X1(a,b)==1)
            x=a;y=b;
            number=0;%判别起始位置是端点的值
            md=0;mdd=0;     %; 1. mdd分支情况中 超出边界的信号，为1，即超出，返回上一个分支点的位置；
            Last=zeros(50,3);%记录分支点的 坐标  及  方向点
            last=0;td=1;tt=0;count3=0;    %last记录上一次平移的方向；  td为循环的一个标志符；       tt为分支情况结束的标志；     count3记录分支点的数量       
            lastcf=[0,0]%记录上一次的扫描点，防止重复扫描
            ksize=0;
            c=0;   %真假特征点判别的阈值，此处多次设置  端点之间为7，小于7为断点  分叉点与端点之间为4   小于4则为毛刺。
% % % % % % % % % % % % % %  对第一个扫描点做独立的判断：           
            [type,K,count1,count2,mt]=find1(X,a,b,count1,count2)%mt为判别是否为独立点，1则是独立点
            if(type==1)
                number=count1;
                count1=count1-1;
                md=1;
            end
            if(type==2)
                count2=count2-1;
            end
%             while(0)
            while(~(tt==1|(type==1&(count1-number)>=(-1)&md==0)|mt==1)&(X1(x,y)==1))%情况判别：  1.存在分支情况，用tt判别    2.图像采集顺利，单条下来     3.独立点用mt判别        &md==0
                %对扫描点x，y进行范围设定
%                 if((x>=(l+50)|x<=(l-50)|y>=(d+50)|y<=(d-50)))  
                if((x>=(m-1)|x<=(2)|y>=(n-1)|y<=(2)))
                      break
                end
                   if(X(x,y)~=1)
                       break;
                   end
                
                [type,K,count1,count2,mt]=find1(X,x,y,count1,count2)
                %对于真假特征点的记录
                if(type~=0)
                    [M,N]=jilu(type,x,y,count1,count2,M,N)
                    
%                 [count1,count2]=quzha(count1,count2,X,x,y,type,c)
                end
               
                X1(x,y)=0; %取消相应的镜像图像
               %方向阵的有效长度
                for(i=1:4)
                    if(K(i,1)~=0)
                        ksize=ksize+1;
                    end
                end
               
                 lastcf(1,1)=x;%上一次的记录点，用于判别真假分叉点的
                 lastcf(1,2)=y;
                %纹线移动
                for(i=td:ksize)
                    if(K(i,1)>=7|K(i,1)<=3)%向下或者  平移
                        %防止重复平移
                        if(last==3&K(i,1)==7)
                            continue;
                        end
                        if(last==7&K(i,1)==3)
                            continue;
                        end
                        
                        [x,y]=yidong(x,y,K,i);
                        X1(x,y)=0;
%                          plot(y,x,'ro')   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                         
                        last=K(i,1);%记录上一个移动的位置，防止重复平移
                        %记录分支点的位置，让其返回
                        if(i~=ksize(1,1))
                            count3=count3+1;
                            Last(count3,1)=x;
                            Last(count3,2)=y;
                            Last(count3,3)=i+1;
                            %if(type==2)
                                %%%%%%%%%%%%%%%
                            break
                        end
                        %防止 1.分支情况 中扫描点出了图像的范围
%                         if(x>=(l+50)|x<=(l-50)|y>=(d+50)|y<=(d-50))
                          if((x>=(m-1)|x<=(2)|y>=(n-1)|y<=(2)))
 
                              mdd=1;%1. 分支情况中 超出边界的信号，为1，即超出，返回上一个分支点的位置
                              break
                        end
                        
                    end
                end
                %返回分支点的位置               
                if(count3~=0&type==1&md==0) 
                     x=Last(count3,1);
                     y=Last(count3,2);
                     td=Last(count3,3);%td记录的是分支点的方向位置，给循环的数的，即未完成的 Ki 的值
                     count3=count3-1;
                     if(count3==0)
                     tt=1;mdd=0;%tt为分支情况全扫描结束的一个标记，为count3从0到N再到0的跳变；
                     end
                end
                %判别该分叉点   是否为前面纹线已扫描过的点，用镜像图像反映
                if(type==2 & X1(x,y-1)==0 & X1(x+1,y-1)==0 & X1(x+1,y)==0 & X1(x+1,y+1)==0 & X1(x,y+1)==0)
                     break
                end
                % pause;
                
                %防止重复扫描
                if(lastcf(1,1)==x&lastcf(1,2)==y)
                    break
                end
            end
            
        end
    end
end
% % % % % % % % % % % % % % % % % % % % % % %  运用unique函数消除重复的阵列
M=unique(M,'rows')
[count1,dd]=size(M)
N=unique(N,'rows')
[count2,dd]=size(N)
M=M(1:count1,:)
N=N(1:count2,:)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 去除边界端点
 MNN=zeros(1200,2);%记录指纹图像边界
 mx=0;%记录除去边界端点的计数器
 [MNN,k]=qubianjie(X,m,n,MNN);
 for i=1:count1
     for j=1:k
         if((M(i,1)==MNN(j,1))&(M(i,2)==MNN(j,2)))
            bj=1;
            break;
         else
             bj=0;
         end
     end
     if (bj==0)
         mx=mx+1;
         M(mx,1)=M(i,1);
         M(mx,2)=M(i,2);
     end
 end
 count1=mx
 M=M(1:count1,:)
  clear MNN;
% % % % % % % % % % % % % % % % % % % % % %   移动判别是否为真特征点
mx1=1;nx1=1;%用于端点与分叉点的计数器
M1=zeros(50,2);
N1=zeros(50,2);
for i=1:count1
    startx=M(i,1);% 记录刚进来的端点位置
    starty=M(i,2);
    x=M(i,1);% 用于移动
    y=M(i,2);
    last11=0;
    c=0;
    bz=0;%做个记入标准，主要用来判别其已近运动
    for j=1:5
        [c,M1,N1,mx1,nx1,last11,x,y,bz]=yidongpanbie(M1,N1,X,x,y,mx1,nx1,c,startx,starty,last11,bz)
        if(c>=4)
            break;
        end
    end
end
% % % % % % 修改M、N阵里的参数
mx=0;nx=0;%计数器
for i=1:count1
     for j=1:(mx1-1)
         if((M(i,1)==M1(j,1))&(M(i,2)==M1(j,2)))
            bj=1;
            break;
         else
             bj=0;
         end
     end
     if (bj==0)
         mx=mx+1;
         M(mx,1)=M(i,1);
         M(mx,2)=M(i,2);
     end
end
% % % % % % % %记录N阵中的参数  
for i=1:count2
     for j=1:(nx1-1)
         if((N(i,1)==N1(j,1))&(N(i,2)==N1(j,2)))
            bj=1;
            break;
         else
             bj=0;
         end
     end
     if (bj==0)
         nx=nx+1;
         N(nx,1)=N(i,1);
         N(nx,2)=N(i,2);
     end
 end
 count1=mx
 M=M(1:count1,:)
 count2=nx      %%%%%%%%%%%%%%XIUGAI
 N=N(1:count2,:)%%%%%%%%%%%%%%%%XIUGAI 
% % % % % % % % % % % % % % % % % % % 去除距离较近的端点，因为其大概均为假端点
mx1=0 %记录假端点的个数,计数器
M1=zeros(50,2);
for i=1:(count1-1)
    for j=i:count1
        dist1=sqrt((M(i,1)-M(j,1))^2+(M(i,2)-M(j,2))^2)
        if(dist1<20&dist1>0)
            mx1=mx1+1;
            M1(mx1,1)=M(i,1);
            M1(mx1,2)=M(i,2);
            mx1=mx1+1;
            M1(mx1,1)=M(j,1);
            M1(mx1,2)=M(j,2);
        end
    end
end
mx=0;
for i=1:count1
     for j=1:(mx1-1)
         if((M(i,1)==M1(j,1))&(M(i,2)==M1(j,2)))
            bj=1;
            break;
         else
             bj=0;
         end
     end
     if (bj==0)
         mx=mx+1;
         M(mx,1)=M(i,1);
         M(mx,2)=M(i,2);
     end
end
count1=mx;
 M=M(1:count1,:)  
% 在采集过程中，由于采集的原因将原本的分叉点段开成一条纹线和一个端点
% 这部分的程序是将这个端点还原成分叉点，并在图像中修复纹线
mx1=0;M1=zeros(50,2);
for i=1:count1
    x=M(i,1);
    y=M(i,2);
    [type,K]=find2(X,x,y)
    [count2,N,M1,mx1]=lianjiexiugai(count2,mx1,M1,N,K,x,y,X);
end
% % % % % % % % % % % % % % % % 修改M阵内的数据
if (mx1>0)
    mx=0;
    for i=1:count1
        for j=1:mx1
            if((M(i,1)==M1(j,1))&(M(i,2)==M1(j,2)))
                  bj=1;
                  break;
            else
                  bj=0;
            end
        end
        if (bj==0)
                mx=mx+1;
                M(mx,1)=M(i,1);
                M(mx,2)=M(i,2);
        end
    end
    count1=mx;
    M=M(1:count1,:)  
end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % %处理采集时堆叠在小范围内的分叉点（含真假），取一个，其他删除
nx1=0;
N1=zeros(50,2)
for i=1:(count2-1)
    for j=(i+1):count2
        dist2=sqrt((N(i,1)-N(j,1))^2+(N(i,2)-N(j,2))^2);
        if(dist2<3)
            if(N(i,1)>N(j,1))
                nx1=nx1+1;
                N1(nx1,1)=N(i,1);
                N1(nx1,2)=N(i,2);
            end
            if(N(i,1)<N(j,1))
                nx1=nx1+1;
                N1(nx1,1)=N(j,1);
                N1(nx1,2)=N(j,2);
            end
            if(N(i,1)==N(j,1))
                if(N(i,2)>N(j,2))
                   nx1=nx1+1;
                   N1(nx1,1)=N(i,1);
                   N1(nx1,2)=N(i,2); 
                else
                    nx1=nx1+1;
                    N1(nx1,1)=N(j,1);
                    N1(nx1,2)=N(j,2);
                end
            end
        end
    end
end
N1=unique(N1,'rows')
[nx1,dd]=size(N1);
N1=N1(1:nx1,:)
% % % % % % % % % % % % % % % % 修改N阵内的数据
 nx=0;
 for i=1:count2
     for j=1:nx1
         if((N(i,1)==N1(j,1))&(N(i,2)==N1(j,2)))
               bj=1;
               break;
         else
               bj=0;
         end
     end
     if (bj==0)
         nx=nx+1;
         N(nx,1)=N(i,1);
         N(nx,2)=N(i,2);
     end
 end
 count2=nx;
 N=N(1:count2,:) 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % 除去距离较近的断桥
nx1=0;
N1=zeros(50,2)
for i=1:(count2-1)
    for j=(i+1):count2
        dist2=sqrt((N(i,1)-N(j,1))^2+(N(i,2)-N(j,2))^2);
        if(dist2<8&dist2>0)
            nx1=nx1+1;
            N1(nx1,1)=N(i,1);
            N1(nx1,2)=N(i,2);
            nx1=nx1+1;
            N1(nx1,1)=N(j,1);
            N1(nx1,2)=N(j,2);
        end
    end
end
N1=unique(N1,'rows')
[nx1,dd]=size(N1);
N1=N1(1:nx1,:)
% % % % % % % % % % % % % % % % 修改N阵内的数据
 nx=0;
 for i=1:count2
     for j=1:nx1
         if((N(i,1)==N1(j,1))&(N(i,2)==N1(j,2)))
               bj=1;
               break;
         else
               bj=0;
         end
     end
     if (bj==0)
         nx=nx+1;
         N(nx,1)=N(i,1);
         N(nx,2)=N(i,2);
     end
 end
 count2=nx;
 N=N(1:count2,:);

    
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 显示特征点
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
imshow(~X);
hold on
for i=1:count1
    plot(M(i,2),M(i,1),'ro');
end
for i=1:count2
    plot(N(i,2),N(i,1),'bo');
end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
subplot(1,2,2)
imshow(I2)
hold on
for i=1:count1
    plot(M(i,2),M(i,1),'ro');
end
for i=1:count2
    plot(N(i,2),N(i,1),'bo');
end



% % % % % % % % % % % % % % % % % % % % % % % % 配对数据
% % % % % % % % % % % % % % % % 数据扩充，将端点与分叉点加入同一个矩阵中做处理
MN=N;    %  MN为扩充矩阵
for i=1:count1
    MN(count2+i,1)=M(i,1)
    MN(count2+i,2)=M(i,2)
end
zongshu=count1+count2;  %总共的特征点数
sanjiaoxingshu=(zongshu*(zongshu-1)*(zongshu-2)/6)  %记录三角形个数  C （ZONGSHU）(3)  排列组合
% % % % % % % % % % % % % % % % % % %
NN=zeros(sanjiaoxingshu,3);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 三角配对
jl=0;%记录三角形个数的
for i=1:(zongshu-2)
    for j=(i+1):(zongshu-1)
        for k=(j+1):zongshu
          jl=jl+1;
          NN(jl,1)=sqrt((MN(i,1)-MN(j,1))^2+(MN(i,2)-MN(j,2))^2) ;
          NN(jl,2)=sqrt((MN(i,1)-MN(k,1))^2+(MN(i,2)-MN(k,2))^2) ;
          NN(jl,3)=sqrt((MN(j,1)-MN(k,1))^2+(MN(j,2)-MN(k,2))^2) ;
        end
    end
end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% 对NN矩阵中的三角形边长进行按小到大的排列
% 以下判别为  若最大最小的位置在1,2  则其和为3    记录第3个位子给tt
%            若最大最小的位置在1,3 则其和为4     记录第2个位子给tt
%            若最大最小的位置在2,3  则其和为5    记录第1个位子给tt
for i=1:jl
    NN1=NN(i,:)
    [min1 nwz1]=min(NN1);
    [max1 nwz2]=max(NN1);
    if((nwz1+nwz2)==3)
        nwz3=3;
    end
    if((nwz1+nwz2)==4)
        nwz3=2;
    end
    if((nwz1+nwz2)==5)
        nwz3=1;
    end
    tt=NN1(1,nwz3)
    NN(i,1)=min1;
    NN(i,2)=tt;
    NN(i,3)=max1;
end



