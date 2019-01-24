function [x,y]=yidong(x,y,K,i)
% 移动函数  ，但是只进行平移和下移
switch (K(i,1))
    case 3
        x=x;
        y=y-1;
    case 7
        x=x;
        y=y+1;
    case 2
        x=x+1;
        y=y-1;
    case 1
        x=x+1;
        y=y;
    case 8
        x=x+1;
        y=y+1;
end