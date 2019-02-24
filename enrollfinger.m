clear all;
Htable = zeros(8,181,181,400);
ccount = 1;
for count = 1:100
    for count2 = 2:2:8
         %if(count == 32 && count2 == 7)
         %ccount = ccount + 1;
         %    continue;
         %end
        filename = strcat('C:\Users\Vamshi\Desktop\Fingerprint\Database\FVC2002\Dbs\DB1_A\',num2str(count),'_',num2str(count2),'.txt');
        [co,n] = getMinutiaDetails(filename);
        ETSU = getExtendedSet(co,n);
        sizex = size(ETSU,1);
        x = zeros(sizex,3);
        y = zeros(sizex,3);
        for i = 1:sizex
            x(i,1:3) = co(ETSU(i,1:3),1);
            y(i,1:3) = co(ETSU(i,1:3),2);
        end
        [ang,mval] = triangledetails(x,y);
        tsign = ones(sizex,1);
        for i = 1:sizex
            temptsign(1:3) = co(ETSU(i,mval(i,1:3)),4)-1;
            te1 = 2;
            for te = 1:3
                tsign(i) = tsign(i)+temptsign(te)*(2^te1);
                te1 = te1 - 1;
            end
            Htable(tsign(i),ang(i,1)+1,ang(i,2)+1,ccount) = Htable(tsign(i),ang(i,1)+1,ang(i,2)+1,ccount)+1;
        end
        ccount = ccount + 1;
    end
end