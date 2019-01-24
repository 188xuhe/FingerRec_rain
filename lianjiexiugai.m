%在采集过程中，由于采集的原因将原本的分叉点段开成一条纹线和一个端点，这部分的程序是将这个端点还原成分叉点，并在图像中修复纹线
function [count2,N,M1,mx]=lianjiexiugai(count2,mx,M1,N,K,x,y,X)
switch  K(1,1)
% % % % % % % % % % % % % % % % % % %     第一模板
    case 2
        if(X((x-2),(y+1))==1&X((x-1),(y+2))==1)
            X((x-1),(y+1))=1;
            count2=count2+1;
            N(count2,1)=x-1;
            N(count2,2)=y+1;
            mx=mx+1;
            M1(mx,1)=x;
            M1(mx,2)=y;
        end
        case 4
        if(X((x+1),(y+2))==1&X((x+2),(y+1))==1)
            X((x+1),(y+1))=1;
            count2=count2+1;
            N(count2,1)=x+1;
            N(count2,2)=y+1;
            mx=mx+1;
            M1(mx,1)=x;
            M1(mx,2)=y;
        end
        case 6
        if(X((x+1),(y-2))==1&X((x+2),(y-1))==1)
            X((x+1),(y-1))=1;
            count2=count2+1;
            N(count2,1)=x+1;
            N(count2,2)=y-1;
            mx=mx+1;
            M1(mx,1)=x;
            M1(mx,2)=y;
        end
        case 8
        if(X((x-1),(y-2))==1&X((x-2),(y-1))==1)
            X((x-1),(y-1))=1;
            count2=count2+1;
            N(count2,1)=x-1;
            N(count2,2)=y-1;
            mx=mx+1;
            M1(mx,1)=x;
            M1(mx,2)=y;
        end
% % % % % % % % % % % % % % % % % % %         第二模板
    case 1
        if(X((x-1),(y-2))==1&X((x-2),(y-1))==1)
            X((x-1),(y-1))=1;
            count2=count2+1;
            N(count2,1)=x-1;
            N(count2,2)=y-1;
            mx=mx+1;
            M1(mx,1)=x;
            M1(mx,2)=y;
        end
        if(X((x-1),(y+2))==1&X((x-2),(y+1))==1)
            X((x-1),(y+1))=1;
            count2=count2+1;
            N(count2,1)=x-1;
            N(count2,2)=y+1;
            mx=mx+1;
            M1(mx,1)=x;
            M1(mx,2)=y;
        end
        case 3
        if(X((x-2),(y+1))==1&X((x-1),(y+2))==1)
            X((x-1),(y+1))=1;
            count2=count2+1;
            N(count2,1)=x-1;
            N(count2,2)=y+1;
            mx=mx+1;
            M1(mx,1)=x;
            M1(mx,2)=y;
        end
        if(X((x+1),(y+2))==1&X((x+2),(y+1))==1)
            X((x+1),(y+1))=1;
            count2=count2+1;
            N(count2,1)=x+1;
            N(count2,2)=y+1;
            mx=mx+1;
            M1(mx,1)=x;
            M1(mx,2)=y;
        end
        case 5
        if(X((x+1),(y-2))==1&X((x+2),(y-1))==1)
            X((x+1),(y-1))=1;
            count2=count2+1;
            N(count2,1)=x+1;
            N(count2,2)=y-1;
            mx=mx+1;
            M1(mx,1)=x;
            M1(mx,2)=y;
        end
        if(X((x+1),(y+2))==1&X((x+2),(y+1))==1)
            X((x+1),(y+1))=1;
            count2=count2+1;
            N(count2,1)=x+1;
            N(count2,2)=y+1;
            mx=mx+1;
            M1(mx,1)=x;
            M1(mx,2)=y;
        end
        case 7
        if(X((x-1),(y-2))==1&X((x-2),(y-1))==1)
            X((x-1),(y-1))=1;
            count2=count2+1;
            N(count2,1)=x-1;
            N(count2,2)=y-1;
            mx=mx+1;
            M1(mx,1)=x;
            M1(mx,2)=y;
        end
        if(X((x+1),(y-2))==1&X((x+2),(y-1))==1)
            X((x+1),(y-1))=1;
            count2=count2+1;
            N(count2,1)=x+1;
            N(count2,2)=y-1;
            mx=mx+1;
            M1(mx,1)=x;
            M1(mx,2)=y;
        end
end
        
            
            