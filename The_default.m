clc
close all
M=0;var=0;
I2=imread('G:\ZKFinger SDK 5.0.0.20_20170424\ActiveX\samples\Delphi\Fingerprint.bmp');
[m,n] = size(I2);
I = double(I2);
%ͼ���һ��
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
% figure, imshow(uint8(I));title('��һ��');
%ͼ���и�
M=3;
H=m/M;
L=n/M;
H=round(H)
L=round(L)
aveg1=zeros(H,L);
var1=zeros(H,L);
%����ÿһ�����ĻҶ�ƽ��ֵ
for x=1:H;
 for y=1:L;
   aveg=0;var=0;
  for i=1:M;
   for j=1:M;
     aveg=I(i+(x-1)*M,j+(y-1)*M)+aveg;
   end
  end
  aveg1(x,y)=aveg/(M*M);
  %����ÿһ�����ķ���
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
Gmean1=Gmean/(H*L);%���п��ƽ��ֵ
Vmean1=Vmean/(H*L);%���п�ķ���

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
% figure,imshow(uint8(I));title('�ָ�');
%��ֵ��
temp=(1/9)*[1 1 1;1 1 1;1 1 1];%��ֵ�˲�
 Im=double(I);
 In=zeros(m,n);
for a=2:m-1;
 for b=2:n-1;
  In(a,b)=Im(a-1,b-1)*temp(1,1)+Im(a-1,b)*temp(1,2)+Im(a-1,b+1)*temp(1,3)+Im(a,b-1)*temp(2,1)+Im(a,b)*temp(2,2)+Im(a,b+1)*temp(2,3)+Im(a+1,b-1)*temp(3,1)+Im(a+1,b)*temp(3,2)+Im(a+1,b+1)*temp(3,3);
 end
end
I=In;
Im=zeros(m,n);
%Ѱ�����߷���
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
%����������ͼ�ֳɵ���ͼ��   ����Ϊ�γ�������ͼ�񣿣�����������
S=round(n)
Icc=Icc(1:m,1:S)
% imwrite(b,'part.jpg')
% figure,imshow(double(Icc));title('��ֵ��1'); 
 for i=1:m
for j=1:S
    Icc(i,j)=Icc(i,j)*Im(i,j);
 end
 end
% figure,imshow(double(Icc));title('��ֵ��2');

for i=1:m
 for j=1:S
  if(Icc(i,j)==128)
   Icc(i,j)=0;
  else
   Icc(i,j)=1;
  end
 end
end
% figure,imshow(double(Icc));title('��ֵ��3'); 

%ȥ���ն���ë��
u=Icc;
%ȥë��
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
% figure,imshow(u);title('ȥë��');
%ȥ�ն�
% % % % % % % % % % % 3��3ȥ��ģ��
for i=2:(m-1)
    for j=2:(n-1)
        if(u(i,j)==1&u(i+1,j)==0&u(i+1,j-1)==0&u(i,j-1)==0&u(i-1,j-1)==0&u(i-1,j)==0&u(i-1,j+1)==0&u(i,j+1)==0&u(i+1,j+1)==0)
            u(i,j)=0;
        end
    end
end
% % % % % % % % % % % % % 4��4����ģ��
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
% % % % % % % % % % % % % 5��5����ģ��
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
% % % % % % % % % % % % % 6��6����ģ��
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
% % % % % % % % % % % % % 4��6����ģ��
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
% % % % % % % % % % % % % 5��6����ģ��
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
% % % % % % % % % % % % % 5��7����ģ��
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
%ϸ��
v=~u;%������u��ͬ��С�෴ֵ���߼�����
img=bwmorph(v,'thin',Inf);%�Զ�ֵ��ͼ�������̬ѧϸ������ֱ��InfΪֹ
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

% % % % % % % % % % % % % % % % % % % % % % % % % �ڶ�����Ѱ��������
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


M=zeros(200,2);count1=0;%�˵������   ��    ����
N=zeros(200,2);count2=0;%�ֲ�������  ��   ����
X1=chuli(X1,m,n);%    ������ͼ����Сһ�����ص�
for a=(2):(m-1);
    for b=(2):(n-1);
% for a=l-50:l+50
%     for b=(d-50):(d+50)
        if(X1(a,b)==1)
            x=a;y=b;
            number=0;%�б���ʼλ���Ƕ˵��ֵ
            md=0;mdd=0;     %; 1. mdd��֧����� �����߽���źţ�Ϊ1����������������һ����֧���λ�ã�
            Last=zeros(50,3);%��¼��֧��� ����  ��  �����
            last=0;td=1;tt=0;count3=0;    %last��¼��һ��ƽ�Ƶķ���  tdΪѭ����һ����־����       ttΪ��֧��������ı�־��     count3��¼��֧�������       
            lastcf=[0,0]%��¼��һ�ε�ɨ��㣬��ֹ�ظ�ɨ��
            ksize=0;
            c=0;   %����������б����ֵ���˴��������  �˵�֮��Ϊ7��С��7Ϊ�ϵ�  �ֲ����˵�֮��Ϊ4   С��4��Ϊë�̡�
% % % % % % % % % % % % % %  �Ե�һ��ɨ������������жϣ�           
            [type,K,count1,count2,mt]=find1(X,a,b,count1,count2)%mtΪ�б��Ƿ�Ϊ�����㣬1���Ƕ�����
            if(type==1)
                number=count1;
                count1=count1-1;
                md=1;
            end
            if(type==2)
                count2=count2-1;
            end
%             while(0)
            while(~(tt==1|(type==1&(count1-number)>=(-1)&md==0)|mt==1)&(X1(x,y)==1))%����б�  1.���ڷ�֧�������tt�б�    2.ͼ��ɼ�˳������������     3.��������mt�б�        &md==0
                %��ɨ���x��y���з�Χ�趨
%                 if((x>=(l+50)|x<=(l-50)|y>=(d+50)|y<=(d-50)))  
                if((x>=(m-1)|x<=(2)|y>=(n-1)|y<=(2)))
                      break
                end
                   if(X(x,y)~=1)
                       break;
                   end
                
                [type,K,count1,count2,mt]=find1(X,x,y,count1,count2)
                %�������������ļ�¼
                if(type~=0)
                    [M,N]=jilu(type,x,y,count1,count2,M,N)
                    
%                 [count1,count2]=quzha(count1,count2,X,x,y,type,c)
                end
               
                X1(x,y)=0; %ȡ����Ӧ�ľ���ͼ��
               %���������Ч����
                for(i=1:4)
                    if(K(i,1)~=0)
                        ksize=ksize+1;
                    end
                end
               
                 lastcf(1,1)=x;%��һ�εļ�¼�㣬�����б���ٷֲ���
                 lastcf(1,2)=y;
                %�����ƶ�
                for(i=td:ksize)
                    if(K(i,1)>=7|K(i,1)<=3)%���»���  ƽ��
                        %��ֹ�ظ�ƽ��
                        if(last==3&K(i,1)==7)
                            continue;
                        end
                        if(last==7&K(i,1)==3)
                            continue;
                        end
                        
                        [x,y]=yidong(x,y,K,i);
                        X1(x,y)=0;
%                          plot(y,x,'ro')   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                         
                        last=K(i,1);%��¼��һ���ƶ���λ�ã���ֹ�ظ�ƽ��
                        %��¼��֧���λ�ã����䷵��
                        if(i~=ksize(1,1))
                            count3=count3+1;
                            Last(count3,1)=x;
                            Last(count3,2)=y;
                            Last(count3,3)=i+1;
                            %if(type==2)
                                %%%%%%%%%%%%%%%
                            break
                        end
                        %��ֹ 1.��֧��� ��ɨ������ͼ��ķ�Χ
%                         if(x>=(l+50)|x<=(l-50)|y>=(d+50)|y<=(d-50))
                          if((x>=(m-1)|x<=(2)|y>=(n-1)|y<=(2)))
 
                              mdd=1;%1. ��֧����� �����߽���źţ�Ϊ1����������������һ����֧���λ��
                              break
                        end
                        
                    end
                end
                %���ط�֧���λ��               
                if(count3~=0&type==1&md==0) 
                     x=Last(count3,1);
                     y=Last(count3,2);
                     td=Last(count3,3);%td��¼���Ƿ�֧��ķ���λ�ã���ѭ�������ģ���δ��ɵ� Ki ��ֵ
                     count3=count3-1;
                     if(count3==0)
                     tt=1;mdd=0;%ttΪ��֧���ȫɨ�������һ����ǣ�Ϊcount3��0��N�ٵ�0�����䣻
                     end
                end
                %�б�÷ֲ��   �Ƿ�Ϊǰ��������ɨ����ĵ㣬�þ���ͼ��ӳ
                if(type==2 & X1(x,y-1)==0 & X1(x+1,y-1)==0 & X1(x+1,y)==0 & X1(x+1,y+1)==0 & X1(x,y+1)==0)
                     break
                end
                % pause;
                
                %��ֹ�ظ�ɨ��
                if(lastcf(1,1)==x&lastcf(1,2)==y)
                    break
                end
            end
            
        end
    end
end
% % % % % % % % % % % % % % % % % % % % % % %  ����unique���������ظ�������
M=unique(M,'rows')
[count1,dd]=size(M)
N=unique(N,'rows')
[count2,dd]=size(N)
M=M(1:count1,:)
N=N(1:count2,:)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % ȥ���߽�˵�
 MNN=zeros(1200,2);%��¼ָ��ͼ��߽�
 mx=0;%��¼��ȥ�߽�˵�ļ�����
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
% % % % % % % % % % % % % % % % % % % % % %   �ƶ��б��Ƿ�Ϊ��������
mx1=1;nx1=1;%���ڶ˵���ֲ��ļ�����
M1=zeros(50,2);
N1=zeros(50,2);
for i=1:count1
    startx=M(i,1);% ��¼�ս����Ķ˵�λ��
    starty=M(i,2);
    x=M(i,1);% �����ƶ�
    y=M(i,2);
    last11=0;
    c=0;
    bz=0;%���������׼����Ҫ�����б����ѽ��˶�
    for j=1:5
        [c,M1,N1,mx1,nx1,last11,x,y,bz]=yidongpanbie(M1,N1,X,x,y,mx1,nx1,c,startx,starty,last11,bz)
        if(c>=4)
            break;
        end
    end
end
% % % % % % �޸�M��N����Ĳ���
mx=0;nx=0;%������
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
% % % % % % % %��¼N���еĲ���  
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
% % % % % % % % % % % % % % % % % % % ȥ������Ͻ��Ķ˵㣬��Ϊ���ž�Ϊ�ٶ˵�
mx1=0 %��¼�ٶ˵�ĸ���,������
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
% �ڲɼ������У����ڲɼ���ԭ��ԭ���ķֲ��ο���һ�����ߺ�һ���˵�
% �ⲿ�ֵĳ����ǽ�����˵㻹ԭ�ɷֲ�㣬����ͼ�����޸�����
mx1=0;M1=zeros(50,2);
for i=1:count1
    x=M(i,1);
    y=M(i,2);
    [type,K]=find2(X,x,y)
    [count2,N,M1,mx1]=lianjiexiugai(count2,mx1,M1,N,K,x,y,X);
end
% % % % % % % % % % % % % % % % �޸�M���ڵ�����
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
% % % % % % % % % %����ɼ�ʱ�ѵ���С��Χ�ڵķֲ�㣨����٣���ȡһ��������ɾ��
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
% % % % % % % % % % % % % % % % �޸�N���ڵ�����
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
% % % % % % % % % % % % % % % % % % % % ��ȥ����Ͻ��Ķ���
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
% % % % % % % % % % % % % % % % �޸�N���ڵ�����
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

    
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % ��ʾ������
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



% % % % % % % % % % % % % % % % % % % % % % % % �������
% % % % % % % % % % % % % % % % �������䣬���˵���ֲ�����ͬһ��������������
MN=N;    %  MNΪ�������
for i=1:count1
    MN(count2+i,1)=M(i,1)
    MN(count2+i,2)=M(i,2)
end
zongshu=count1+count2;  %�ܹ�����������
sanjiaoxingshu=(zongshu*(zongshu-1)*(zongshu-2)/6)  %��¼�����θ���  C ��ZONGSHU��(3)  �������
% % % % % % % % % % % % % % % % % % %
NN=zeros(sanjiaoxingshu,3);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % �������
jl=0;%��¼�����θ�����
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
% ��NN�����е������α߳����а�С���������
% �����б�Ϊ  �������С��λ����1,2  �����Ϊ3    ��¼��3��λ�Ӹ�tt
%            �������С��λ����1,3 �����Ϊ4     ��¼��2��λ�Ӹ�tt
%            �������С��λ����2,3  �����Ϊ5    ��¼��1��λ�Ӹ�tt
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



