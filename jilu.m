function [M,N]=jilu(type,x,y,count1,count2,M,N)
% 记录端点与分叉点的位置
if(type==1)
    M(count1,1)=x;
    M(count1,2)=y;
    plot(y,x,'ro');
end
if(type==2)
    N(count2,1)=x;
    N(count2,2)=y;
    plot(y,x,'bo');
end