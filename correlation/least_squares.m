% correlation par min moindres carres

clear all;
clc;

I=imread('image.jpg'); 

if (ndims(I)==3)  
    I_gray=rgb2gray(I);
else
    I_gray=I;
end
I=I_gray;
figure;
imshow(I);       

I=im2bw(I,0.3);   % Binarisation
[m,n]=size(I); 
I=ones(m,n)-1*I; 
I=double(I);

figure;
subplot(2,1,1);
imshow(I_gray);
subplot(2,1,2);
imshow(I);

[m,n]=find(I);    % Find indices of nonzero elements.
min_l=min(m); 
max_l=max(m); 
min_col=min(n); 
max_col=max(n); 

% Construction of a new target image
Inew=I(min_l:max_l,min_col:max_col); 
% open operation for remove the small salient points
Inew=imopen(Inew,strel('disk',1));  

figure;
subplot(2,1,1);
imshow(I);
subplot(2,1,2);
imshow(Inew);

[m,n]=size(Inew); 
A=0; B=0;C=0;D=0;        
N=0;  

for i=1:m 
    for j=1:n 
        A=A+Inew(i,j)*i*j; 
        B=B+Inew(i,j)*i; 
        C=C+Inew(i,j)*j; 
        D=D+Inew(i,j)*j*j; 
        N=Inew(i,j)+N;     
    end 
end 
 
U=N*A-C*B; 
V=N*D-C*C; 
a=U/V;                   % pente
rotate=atan(a); 

rotate=rotate*180/pi; 

G=imrotate(Inew,rotate);  
G=ones(size(G,1),size(G,2))-G;
figure;
imshow(G); 
title('image after least_squares');