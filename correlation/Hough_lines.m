function [resI, theta, p]=Hough_lines(I,Icontours)

[m,n]=size(I);

pMax = floor(sqrt(m^2+n^2))+1;
tempI=zeros(pMax,180);

Icontours=Icanny;

for i=1:m
    for j=1:n
        if(Icontours(i,j))== 1
            for k=1:180                       % 180 lignes max
                theta=pi/180*k;
                p= i*cos(theta)+j*sin(theta);
                pInt=round(p/2+pMax/2);
                
                tempI(pInt,k)=tempI(pInt,k)+1;
            end
        end
    end
end

% chercher le nombre de ligne >=100

idx=0;
for p=1:pMax
    for k=1:180
        if tempI(p,k)>=60
            idx=idx+1;
            hm(idx)=p;
            hn(idx)=k;
        end
    end
end

% visualiser les lignes

resI=zeros(m,n);
for i=1:m
    for j=1:n
        if Icontours(i,j)==1
            for k=1:180
                theta=pi/180*k;
                p= i*cos(theta)+j*sin(theta);
                pInt=round(p/2+pMax/2);
                for m=1:idx
                    if hm(m)==pInt && hn(m)==k
                        resI(i,j)=1;
                    end
                end
            end
        end
    end
end


figure;
imshow(resI);
title('Image after Hough Transform');


end