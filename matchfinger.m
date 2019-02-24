%rank = zeros(100,1);
siMatrix = zeros(400,100);
temprank = zeros(4,1);
trv = 1;
rv = 1;
rv1 = 1;
thres = 5;
for count = 1:100
    for count2 = 1:2:7
       % if(count == 32 && count2 == 7)
       %     rv = rv+1;
       %     continue;
       % end
        filename = strcat('C:\Users\Vamshi\Desktop\Fingerprint\Database\FVC2002\Dbs\DB1_A\',num2str(count),'_',num2str(count2),'.txt');
        [co,n] = getMinutiaDetails(filename);
        ETSU = getExtendedSet(co,n);
        [sizex,sizey] = size(ETSU);
        x= zeros(sizex,3);
        Y= zeros(sizex,3);
        for i = 1:sizex
            x(i,1:3) = co(ETSU(i,1:3),1);
            y(i,1:3) = co(ETSU(i,1:3),2);
        end
        [ang,mval] = triangledetails(x,y);
        tsign = ones(sizex,1);
        hashT= zeros(400,1);
        for i = 1:sizex
            temptsign(1:3) = co(ETSU(i,mval(i,1:3)),4)-1;
            te1 = 2;
            for te = 1:3
                tsign(i) = tsign(i)+temptsign(te)*(2^te1);
                te1 = te1-1;
            end
            ta1 = ang(i,1)+1;
            ta2 = ang(i,2)+1;
            temphashTemplate = zeros(400,1);
            temphashTemplate1 = zeros(400,1);
            for j1 = -thres:thres
                for j2 = -thres:thres
                    if((ta1+j1)>0 && (ta2+j2)>0 && (ta1+j1)<182 && (ta2+j2)<182)
                    temphashTemplate1(1:400,1) =(Htable(tsign(i),ta1+j1,ta2+j2,:)>0);
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
        rv = rv+1;
        %[sortedValues,sortIndex] = sort(hashT1,'descend');
        %te = find(sortedValues==hashT1(count));
        %temprank(trv) = te(1);
        %trv = trv+1;
    end
        %rank(rv) = min(temprank);
        %rv = rv + 1;
        %trv = 1;
end
[prv,hvv] = createhrprg(siMatrix,thres);
%r = hist(rank,1:100);
%r = cumsum(r);
%r = r*100/100;
%plot([1:100],r);