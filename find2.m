function [type,K]=find2(X,x,y)
% ���ڵ������ص��б�������һ��������
K=zeros(4,1);%�������ڵ�λ�÷���
s=0;type=0;%sΪ�������ڵĵ���
for(i=1:8)
    j=def(X,x,y,i)
    if(j==1)
        s=s+1;
        K(s,1)=i;
    end
end
if(s==1)
    type=1;
end
if(s==3)
    if(~(K(1,1)==1&K(3,1)==8))
        if((K(3,1)-K(2,1)~=1)&(K(2,1)-K(1,1)~=1))
            type=2;
        end
    end
end
