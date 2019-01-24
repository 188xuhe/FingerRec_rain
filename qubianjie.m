function [MNN,k]=qubianjie(X,m,n,MNN)
% % % % % % % % 去除图像边界
k=1;
% 从左边开始扫描
for i=2:(m-1)
   for j=2:(n-1)
        if X(i,j)==1
            MNN(k,1)=i;
            MNN(k,2)=j;
            k=k+1;
            break;
        end
    end
end
% 从右边开始扫描
for i=2:(m-1)
     for j=(n-1):-1:2
        if X(i,j)==1
            MNN(k,1)=i;
            MNN(k,2)=j;
            k=k+1;
            break;
        end
    end
end
% 从下边边开始扫描
for i=2:(n-1)
     for j=(m-1):-1:2
        if X(j,i)==1
            MNN(k,1)=j;
            MNN(k,2)=i;
            k=k+1;
            break;
        end
    end
end