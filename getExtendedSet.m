function ETSU = getExtendedSet(co,n)
TR1 = delaunay(co(1:n,1),co(1:n,2));
ETS = TR1;
for k = 1:n
    [i,j] = find(TR1==k);
    temp = TR1(i,1:3);
    temp1 = unique(temp);
    temp1 = temp1(temp1~=k);
    temp2 = co(temp1,1:2);
    [sizex] = size(temp2,1);
    if(sizex>=3)
        tempTR = delaunay(temp2);
        ETS = vertcat(ETS,tempTR);
    end
end
ETSU = sort(ETS,2);
ETSU = unique(ETSU,'rows');
end