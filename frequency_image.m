function f = frequency_image(img,oimg,m,n,N)
%FREQUENCY_IMAGE 此处显示有关此函数的摘要
%   此处显示详细说明
[x,y]           =   meshgrid(-8:7,-16:15);
[blkht,blkwt]   =   size(oimg);
yidx = 1; %index of the row block
for i = 0:blkht-1
    row     = (i*N+N/2);%+N for the pad
    xidx    = 1; %index of the col block
    for j = 0:blkwt-1   
        col = (j*N+N/2);
        %row,col indicate the index of the center pixel
        th  = oimg(yidx,xidx);
        u = x*cos(th)-y*sin(th);
        v = x*sin(th)+y*cos(th);
        u           =   round(u+col); u(u<1)  = 1; u(u>n) = n;
        v           =   round(v+row); v(v<1)  = 1; v(v>m) = m;
        %find oriented block
        idx         =   sub2ind(size(img),v,u);
        blk         =   img(idx);
        blk         =   reshape(blk,[32,16]);
        %find x signature
        xsig        =   sum(blk,2);
        f(yidx,xidx) = find_peak_distance(xsig);
        xidx = xidx +1;
    end
    yidx = yidx +1;
end
end

