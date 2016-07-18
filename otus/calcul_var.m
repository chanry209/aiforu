function [u1,u2,w1,w2,var1,var2,varB] = calcul_var(I,T)
% T=T1;
% I=G;
I=double(I);
[m,n]=size(I);
L=256;

hist=zeros(L,1);
for i=1:m
    for j=1:n
        hist(I(i,j)+1)=hist(I(i,j)+1)+1;
    end
end
hist=hist/(m*n);

% calcul the average and the probas
w1=0;u1=0;u2=0;
var1=0; var2=0;
for i=1:T
    w1=w1+hist(i);
    u1=u1+(i-1)*hist(i);
end

if w1==0
    u1=0;
else
    u1=u1/w1;
end

w2=1-w1;

for j=T+1:L
    u2=u2+(j-1)*hist(j);
end

if w2==0
    u2=0;
else
    u2=u2/w2;
end

varB=w1*w2*(u1-u2)^2;

% calcul the variance 
for i=1:T
    if w1==0
        var1=0;
    else
        var1=((i-u1)*hist(i)/w1).^2 + var1;
    end
end

for j=T+1:L
     if w2==0
        var2=0;
    else
        var2=((j-u2)*hist(j)/w2).^2 + var2;
    end
end

%varW= w1*var1+w2*var2;

end