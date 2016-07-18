function entropyMax=calculer_entropie(I,h)
I=double(I); 
[m,n]=size(I); 
%h=1; 
J=zeros(m,n); 
G=I;

for i=1:m 
    for j=1:n 
        for k=-h:h 
            for w=-h:h; 
                p=i+k; 
                q=j+w; 
                if (p<=0)|( p>m) 
                    p=i; 
                end 
                if (q<=0)|(q>n) 
                    q=j; 
                end 
                 J(i,j)=I(p,q)+J(i,j); 
             end 
        end
        G(i,j)=uint8(1/9*J(i,j));
    end 
end 
figure;
colormap gray;
imagesc(G);
figure;
colormap gray;
imagesc(J);
fxy=zeros(256,256); 

G=double(G);
for i=1:m 
    for j=1:n  
        fxy(I(i,j)+1,G(i,j)+1)=fxy(I(i,j)+1,G(i,j)+1)+1; 
    end 
end 
Pxy=fxy/(m*n);    

% calcule H1
Hl=0; 
for i=1:256 
    for j=1:256 
            if Pxy(i,j)>0.00001 
                Hl=Hl-Pxy(i,j)*log(Pxy(i,j)); 
            else 
                Hl=Hl; 
            end      
    end 
end 
 
PA=zeros(256,256); 
HA=zeros(256,256); 
PB=zeros(256,256); 
 
PA(1,1)=Pxy(1,1); 
if PA(1,1)<1e-4 
    HA(1,1)=0; 
else 
    HA(1,1)=-PA(1,1)*log(PA(1,1)); 
end 
for i=2:256 
    PA(i,1)=PA(i-1,1)+Pxy(i,1); 
    if Pxy(i,1)>0.00001 
           HA(i,1)=HA(i-1,1)-Pxy(i,1)*log(Pxy(i,1)); 
    else 
           HA(i,1)=HA(i-1,1);    
    end 
end 
for j=2:256 
    PA(1,j)=PA(1,j-1)+Pxy(1,j); 
    if Pxy(1,j)>0.00001 
           HA(1,j)=HA(1,j-1)-Pxy(1,j)*log(Pxy(1,j)); 
    else 
           HA(1,j)=HA(1,j-1);    
    end 
end 
 
for i=2:256    
    for j=2:256         
        PA(i,j)=PA(i-1,j)+PA(i,j-1)-PA(i-1,j-1)+Pxy(i,j);  
        if Pxy(i,j)>0.00001 
              HA(i,j)=HA(i-1,j)+HA(i,j-1)-HA(i-1,j-1)-Pxy(i,j)*log(Pxy(i,j)); 
        else 
              HA(i,j)=HA(i-1,j)+HA(i,j-1)-HA(i-1,j-1); 
    
        end 
    end 
end 
 
 
% calculer max entropie 
 
PB=1-PA; 
h=zeros(256,256); 
entropyMax=0; 
 
for i=1:256 
    for j=1:256 
            if abs(PA(i,j))>0.00001&abs(PB(i,j))>0.00001 
               h(i,j)=log(PA(i,j)*PB(i,j))+HA(i,j)/PA(i,j)+(Hl-HA(i,j))/PB(i,j); 
            else 
               h(i,j)=0; 
            end 
            if h(i,j)>entropyMax 
               entropyMax=h(i,j); 
               s=i-1; 
               t=j-1;               
            end
    end
end 
% z=ones(m,n);   
% for i=1:m 
%     for j=1:n 
%        if I(i,j)<=s&G(i,j)<=t  
%           z(i,j)=0;    
%        else 
%            z(i,j)=255; 
%        end
%     end
% end 
entropyMax 
s 
t 
subplot(1,2,1); 
imshow(I); 
subplot(1,2,2); 
imshow(z); 
end
