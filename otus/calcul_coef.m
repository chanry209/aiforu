function [resT,coef] = calcul_coef(I_gray)

I=double(I_gray);
[m,n]=size(I); 
L=256;
varT=var(I(:));

hist=zeros(L,1);
resT=0;

for i=1:m
    for j=1:n
        hist(I(i,j)+1)=hist(I(i,j)+1)+1;
    end
end
hist=hist/(m*n);

max_coef=0;
%uT=mean(mean(I));

for t=1:L
    T=t-1;
    w1=0;u1=0;u2=0;
    
    % calcul the average and the probas
    for i=1:t
        w1=w1+hist(i);
        u1=u1+(i-1)*hist(i);
    end
    
    if w1==0
        u1=0;
    else
        u1=u1/w1;
    end
    
    w2=1-w1;
    
    for j=t+1:L
        u2=u2+(j-1)*hist(j);
    end
    
    if w2==0
        u2=0;
    else
        u2=u2/w2;
    end
    
    varB=w1*w2*(u1-u2)^2;
   
    coef=varB/varT;
    
    if coef>max_coef
        max_coef=coef;
        resT=T;
    end
end   
coef=max_coef;
end
