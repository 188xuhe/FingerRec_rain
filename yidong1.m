function [x,y]=yidong1(x,y,K,i)
% �ƶ�����  ��c�˴�����8������������ƶ�
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
    case 4
        x=x-1;
        y=y-1;
    case 5
        x=x-1;
        y=y;
    case 6
        x=x-1;
        y=y+1;
end