function [x,y]=yidong(x,y,K,i)
% �ƶ�����  ������ֻ����ƽ�ƺ�����
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