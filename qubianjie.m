function [MNN,k]=qubianjie(X,m,n,MNN)
% % % % % % % % ȥ��ͼ��߽�
k=1;
% ����߿�ʼɨ��
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
% ���ұ߿�ʼɨ��
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
% ���±߱߿�ʼɨ��
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