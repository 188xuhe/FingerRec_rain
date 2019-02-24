function [prv1,hvv] = createhrprg(siMatrix,th)
sizex = size(siMatrix,1);
pr = zeros(sizex,100);
hv =zeros(sizex,100);
count = 1;
for i = 0.01:0.01:1
    pr(:,count) = sum(siMatrix>=i,2);
    for j = 1:sizex
        hv(j,count) = siMatrix(j,floor((j-1)/4)+1)>=i;
        if(count==128)
        hv(j,count) = 1;    
        end
        
    end
    count = count+1;
end 
%prv = zeros(100,100);
%for i = 1:100
 %     pr1 = reshape(pr(1:400,i),4,100);
 %     pr1 = pr1';
 %     [pr2,y1] = min(pr1,[],2);
 %     prv(1:100,i) = pr2; 
%end
pr1 = pr.*hv;
pr1 = sum(pr1);
pr1 = pr1./sum(hv);
prv1 = mean(pr)/100*100;
hvv = (sum(hv)/sizex)*100;
figure,
plot(pr1,hvv);
title(strcat('Hit Rate Vs Penentration Rate for Neighbour Search =',num2str(th)));
xlabel('Penentration Rate')
ylabel('Hit Rate')
end