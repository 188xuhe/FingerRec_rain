%--------------------------------------------------------
%sub the image to make height and width multiples of N
%--------------------------------------------------------
function y = sub_image(x,N)
    [ht,wt] = size(x);
    padcol  = mod(wt,N);
    if(padcol ~= 0)  %need padding
        padleft = floor(padcol/2);
        padright= padcol-padleft;
        x       = x(:,padleft+1:wt-padright);
    else
        padcol  = 0;
    end
    padrow  = mod(ht,N);
    if(padrow~= 0) 
        padtop = floor(padrow/2);
        padbot = padrow-padtop;
        x      = x(padtop+1:ht-padbot,:);
    else        
        padrow = 0;
    end
    %---------------
    %changet ht,wt
    %--------------
    ht = ht+padrow;
    wt = wt+padcol;
    y=x;
%end function pad_image

