function [type,K,count1,count2,mt]=find1(X,x,y,count1,count2)
% ���ڵ������ص��б�������һ��������
K=zeros(4,1);%�������ڵ�λ�÷���
s=0;type=0;%sΪ�������ڵĵ���
mt=0;%Ϊ������ı�־
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