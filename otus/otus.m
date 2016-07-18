% methode Otus: max variance between 2 classes
%  varB = w1*(u1-uT)^2+w2*(u2-uT)^2 =w1*w2*(u1-u2)^2
%  w1,w2: probability distribution of pixels of class1 et 2 in the image
%  u1,u2,u5: average of pixel

function resT = otus(I)

I=double(I);
[m,n]=size(I);
L=256;
resT=0;
histo=zeros(L,1);

for i=1:m
    for j=1:n
        histo(I(i,j)+1)=histo(I(i,j)+1)+1;
    end
end
histo=histo/(m*n);
max_var=0;

for t=1:L
    T=t-1; % seuil de segmentation
    w1=0;u1=0;u2=0;
    
    for i=1:t
        w1=w1+histo(i);
        u1=u1+(i-1)*histo(i);
    end
    
    if w1==0
        u1=0;
    else
        u1=u1/w1;
    end
    
    w2=1-w1;
    
    for j=t+1:L
        u2=u2+(j-1)*histo(j);
    end
    
    if w2==0
        u2=0;
    else
        u2=u2/w2;
    end
    
    var=w1*w2*(u1-u2)^2;
    
    if var>max_var
        max_var=var;
        resT=T;
    end    
end

% varT=max_var;
%resT;
%varT

end