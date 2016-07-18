function nanimage=pictureartifacts(im,szwinx,szwiny,thre,dx,dy)
    nanimage=im;

    
    for i=1+floor(szwinx/2):size(im,1)-floor(szwinx/2)
        for j=1:size(im,2)
            xwin=max(1,i-szwinx):min(size(im,1),i+szwinx);
            m=0;
            n=0;
            for x=xwin
                d=round(sqrt(1-((x-i)/szwinx)^2)*szwiny);
                ywin=max(1,j-d):min(size(im,2),j+d);
                m=m+sum(im(x,ywin));
                n=n+length(ywin);
            end
            m=m/n;
            
            if(abs(im(i,j)-m)>thre)
                nanimage(i,j)=NaN;
                xwin=max(1,i-dx):min(size(im,1),i+dx);
                for x=xwin
                    d=round(sqrt(1-((x-i)/dx)^2)*dy);
                    ywin=max(1,j-d):min(size(im,2),j+d);
                    nanimage(x,ywin)=NaN;
                end
            end
            
        end
    end
    for i=1:size(nanimage,1)
        if(sum(isnan(nanimage(i,:)))/size(nanimage,2)>0.5)
            nanimage(i,:)=NaN;
        end
    end

end