function j=def(X,x,y,i)
% 对单像素进行8领域进行定义
%         4       5        6 
%         3                7
%         2       1        8
% % % % % % % % % % % % % % % % %
switch(i)
    case 1
        j=X(x+1,y);
    case 2
        j=X(x+1,y-1);
    case 3
        j=X(x,y-1);
    case 4
        j=X(x-1,y-1);
    case 5
        j=X(x-1,y);
    case 6
        j=X(x-1,y+1);
    case 7
        j=X(x,y+1);
    case 8
        j=X(x+1,y+1);
end