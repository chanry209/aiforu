function [Hist, img] = getImageHists(I)

% read RGB data and convertir it to HSV

img = I;
I = rgb2hsv(I);
[m,n,dim] = size(I);

range = 0.0:0.1:1.0;
Hist = zeros(length(range),length(range),length(range));  % initialize coordinate axis

% % show the different color of image
% Ir=I;
% Ir(:,:,2)=0;
% Ir(:,:,3)=0;
% 
% Ig=I;
% Ig(:,:,1)=0;
% Ig(:,:,3)=0;
% 
% Ib=I;
% Ib(:,:,1)=0;
% Ib(:,:,2)=0;
% 
% figure;
% subplot(2,2,1);image(Ir);
% subplot(2,2,2);image(Ig);
% subplot(2,2,3);image(Ib);
% subplot(2,2,4);image(img);
% title('original image');

% rgb convertir to hsv
for i=1:m
    for j=1:n                 
        channel1 = round(I(i,j,1) * 10)+1;
        channel2 = round(I(i,j,2) * 10)+1;        
        channel3 = round(I(i,j,3) * 10)+1;
        Hist(channel1, channel2, channel3) = Hist(channel1, channel2, channel3) + 1;
    end
end

Hist = Hist / (m*n);
end