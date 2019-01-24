function [type,K,count1,count2,mt]=find1(X,x,y,count1,count2)
% 对于单个像素点判别其是哪一种特征点
K=zeros(4,1);%八领域内的位置方向
s=0;type=0;%s为八领域内的点数
mt=0;%为独立点的标志
for(i=1:8)
    j=def(X,x,y,i)
    if(j==1)
        s=s+1;
        K(s,1)=i;
    end
end
if(s==1)
    type=1;
    count1=count1+1;
end
if(s==3)
    if(~(K(1,1)==1&K(3,1)==8))
        if((K(3,1)-K(2,1)~=1)&(K(2,1)-K(1,1)~=1))
            type=2;
            count2=count2+1;
        end
    end
end
if(s==0)
    mt=1;
end