close all
clear all

Htable = zeros(8,181,181,400);
ccount = 1;
thres = 5;
siMatrix = zeros(400,100);
trv = 1;
rv = 1;
rv1 = 1;

f = strcat('point.txt');
fileID = fopen(f,'r');
formatSpec = '%d';
co=textread('point.txt');
n=size(co,1);
% co = zeros(n,2);
% for i=1:n
%     co(i,1:2) = fscanf(fileID,formatSpec,2);
% end
TR1 = delaunay(co(1:n,1),co(1:n,2));
ETS = TR1;
ETSU = sort(ETS,2);
ETSU = unique(ETSU,'rows');
sizex = size(ETSU,1);
x = zeros(sizex,3);
y = zeros(sizex,3);
for i = 1:sizex
    x(i,1:3) = co(ETSU(i,1:3),1);
    y(i,1:3) = co(ETSU(i,1:3),2);
end
[ang,dist,mval] = triangledetails(x,y);
tsign = ones(sizex,1);
for i = 1:sizex
    temptsign(1:3) = co(ETSU(i,mval(i,1:3)),3);
    te1 = 2;
    for te = 1:3
        tsign(i) = tsign(i)+temptsign(te)*(2^te1);
        te1 = te1 - 1;
    end
    Htable(tsign(i),ang(i,1)+1,ang(i,2)+1,ccount) = Htable(tsign(i),ang(i,1)+1,ang(i,2)+1,ccount)+1;
end
%%%%%%%%%%%%%%%%%%%%%%


tsign1 = ones(sizex,1);
hashT= zeros(400,1);
for i = 1:sizex
    temptsign(1:3) = co(ETSU(i,mval(i,1:3)),3);
    te1 = 2;
    for te = 1:3
        tsign1(i) = tsign1(i)+temptsign(te)*(2^te1);
        te1 = te1-1;
    end
    ta1 = ang(i,1)+1;
    ta2 = ang(i,2)+1;
    temphashTemplate = zeros(400,1);
    temphashTemplate1 = zeros(400,1);
    for j1 = -thres:thres
        for j2 = -thres:thres
            if((ta1+j1)>0 && (ta2+j2)>0 && (ta1+j1)<182 && (ta2+j2)<182)
            temphashTemplate1(1:400,1) =(Htable(tsign1(i),ta1+j1,ta2+j2,:)>0);
            temphashTemplate = temphashTemplate + temphashTemplate1;
            end
        end
    end
    hashT = hashT + (temphashTemplate>0);
end
hashT = reshape(hashT,4,100);
hashT = hashT';
[hashT1,y1] = max(hashT,[],2);
siMatrix(rv,:)=hashT1/size(ETSU,1);















