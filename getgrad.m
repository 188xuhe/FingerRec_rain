function [gradx,grady,grad] = getgrad(image,m,n,r)
%GETGRAD 此处显示有关此函数的摘要
%   此处显示详细说明
%% 
EPI	= 57.29578;     %360/2pi，角度和弧度的换算
Vx = zeros(m,n);
Vy = zeros(m,n);
grad = zeros(m,n);
gradx = zeros(m,n);
grady = zeros(m,n);
angle = zeros(m,n);
f_temp = image;
for x = 1:m
    for y = 1: n
         vx = 0;
         vy = 0;
         lvx = 0;
         lvy = 0;
         num = 0;
            %%%%%%%%%%%%%%%%%%%r * r 窗下的处理%%%%%%%%%%%%%%%%%%%
            for i = -r:r
                %%%%%%%%%%%%%%%%%% 边界处理 %%%%%%%%%%%%%%%%%%%%%
                if(x + i -1 < 1 || x + i + 1 > m )
                    continue;
                end
                    for j = -r:r
                        if (y + j -1 < 1 || y + j + 1 > n)
                            continue;
                        end
                         Vx(x+i,y+j) = f_temp(x+i+1,y+j+1) - f_temp(x+i+1,y+j-1) + f_temp(x+i,y+j+1)*2 - f_temp(x+i,y+j-1)*2 + f_temp(x+i-1,y+j+1) - f_temp(x+i-1,y+j-1);
                         Vy(x+i,y+j) = (f_temp(x+i-1,y+j+1) - f_temp(x+i+1,y+j+1)) + (f_temp(x+i-1,y+j)*2 - f_temp(x+i+1,y+j)*2) + (f_temp(x+i-1,y+j-1) - f_temp(x+i+1,y+j-1) );
                         vx = vx + abs(Vx(x+i,y+j));
                         vy = vy + abs(Vy(x+i,y+j));                        
                         num=num+1;                         
                    end
            end
            if num==0
                num=1;
            end
            grad(x,y) = (vx + vy)/num;     %图像梯度
            gradx(x,y) = vx/num;
            grady(x,y) = vy/num;
    end
end


