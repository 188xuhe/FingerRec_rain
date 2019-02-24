function [a,d,m] = triangledetails(x,y)
[sizex,sizey] = size(x);
a = zeros(sizex,sizey);
m = zeros(sizex,sizey);
d = zeros(sizex,sizey);
n = 3;
for count = 1:sizex
    dist = zeros(n,n);
    for i = 1:n-1
        for j = i+1:n
            dist(i,j) = (sqrt((x(count,i)-x(count,j))^2+(y(count,i)-y(count,j))^2));
        end
    end
    dist = dist + dist';
    a1 = acosd((dist(1,2)^2+dist(1,3)^2-dist(2,3)^2)/(2*dist(1,2)*dist(1,3)));
    a2 = acosd((dist(1,2)^2+dist(2,3)^2-dist(1,3)^2)/(2*dist(1,2)*dist(2,3)));
    a3 = acosd((dist(3,2)^2+dist(1,3)^2-dist(1,2)^2)/(2*dist(3,2)*dist(1,3)));
    a(count,1:3) = int16([a1 a2 a3]);
    d(count,1:3) = ([dist(2,3),dist(3,1),dist(1,2)]);
    [d(count,1:3),tt] = sort(d(count,1:3),'descend');
    m(count,1:3) = tt;
    a(count,1:3) = a(count,tt);
end
d = int16(d);
end