function [res]=preTraitement(I,glpf_fc, rectangleSize,weight)
if (ndims(I)==3)  
    I_gray=rgb2gray(I);
else
    I_gray=I;
end

%% Histo of probalities pixels
I=I_gray;
[m,n]=size(I);
L=256;
histo=zeros(L,1);

for i=1:m
    for j=1:n
        histo(I(i,j)+1)=histo(I(i,j)+1)+1;
    end
end

histo1=histo/(m*n);


figure;
subplot(2,1,1);
colormap gray;
imagesc(I);
%imshow(I);
title('Figure in Gray')
subplot(2,1,2)
plot(histo1);
title('Histo of probalities pixels')
xlabel('Frequency')
ylabel('Amount')


%% distribution of pixel of each column
% this operation is for observer distribution and the type of bruit
meanI=zeros(1,n);
medianI = zeros(1,n);
for j=1:n
    meanI(j)=mean(I(:,j));
end

for j=1:n
    medianI(j)=median(I(:,j));
end

figure;
subplot(2,1,1);
colormap gray;
imagesc(I);
title('Figure Original')
subplot(2,1,2)
plot(meanI);
xlimitHere = size(I,2);
hold on
plot(medianI,'r');
xlim([0,xlimitHere])
legend('mean','median')
title('Mean of Pixel by column')

%% Ignore the highlights  (top 20%)
Inew=I;
for j=1:n
    temp=sort(unique(I(:,j)));
    length=size(temp,1);
    threshold=temp(round(0.2*length)+1);
    
    for i=1:m
        if Inew(i,j)>threshold
            Inew(i,j)=medianI(j);
        end
    end
end

figure;
subplot(2,1,1);
imshow(I);
title('Figure originale');
subplot(2,1,2)
imshow(Inew);
title('Figure after ignore the highlights');

%% padding edges
Inew2=Inew;
halfL=fix(m/2);
for i=1:m
    idxnotzero=find(Inew2(i,:)~=0);
    a=size(idxnotzero,2);
    if a~=0
        for k=1:a
            if i<=halfL
                Inew2(1:i-1,idxnotzero(k))=Inew2(i,idxnotzero(k));
            else
                Inew2(i+1:end,idxnotzero(k))=Inew2(i,idxnotzero(k));
            end
        end
    end
end

for j=1:fix(n/2)
    for i=1:m
        if Inew2(i,j)==0
            Inew2(i,j)=Inew2(i,j+1);
        end
    end
end
for j=fix(n/2)+1:n
    for i=1:m
        if Inew2(i,j)==0
            Inew2(i,j)=Inew2(i,j-1);
        end
    end
end

figure;
subplot(2,1,1);
colormap gray;
imagesc(Inew);
title('Figure after ignore the highlights')
subplot(2,1,2)
colormap gray;
imagesc(Inew2);
title('Figure after padding edges');

%% increases the contrast of image by adjust image intensity values
%Inew2=imadjust(Inew,[0.05,0.95]);
Inew=imadjust(Inew2);

figure;
subplot(2,1,1);
imshow(Inew2);
title('Figure after padding edges');
subplot(2,1,2)
imshow(Inew);
title('Figure after increase contrast');

%% filtre base-pass gaussian (Glpf:Gaussian low pass filter)
%glpf_fc=25;
Iglpf = gaussian_lowpass_filter(Inew,glpf_fc);
G=uint8(real(Iglpf));

%% Enhance contrast using histogram equalization (maximise l'entropie)
G=histeq(G);    

figure;
subplot(2,1,1);
imshow(Inew);
title('Figure after increase contrast');
subplot(2,1,2)
imshow(G);
title(['Figure after gauss low pass filter ',num2str(glpf_fc)]);

%% closing morphological operation for bridge the emply of band
% use rectangular structure element of  m x n pixels
a=rectangleSize(1);
b=rectangleSize(2);
J=imclose(G,strel('rectangle',[a,b]));

figure;
subplot(2,1,1);
imshow(G);
title(['Figure after gauss low pass filter ',num2str(glpf_fc)]);
subplot(2,1,2)
imshow(J);
title('Figure after closing operation');

res=J;
%% weighted operation
% w=weight;
% long=fix(m/10);
% Iweighted=J;
% for i=1:m
%     for j=1:n
%         if i<long
%             Iweighted(i,j)=J(i,j).*w(1);
%         elseif  long<=i&&i<4*long
%             Iweighted(i,j)=J(i,j).*w(2);
%         elseif  4*long<=i&&i<6*long
%             Iweighted(i,j)=J(i,j).*w(3);
%         elseif  6*long<=i&&i<9*long
%             Iweighted(i,j)=J(i,j).*w(4);
%         else
%             Iweighted(i,j)=J(i,j).*w(5);
%         end
%     end        
% end
% 
% G2=Iweighted;
% G2=uint8(real(G2));
% 
% figure;
% subplot(2,1,1);
% imshow(J);
% subplot(2,1,2)
% colormap gray;
% imagesc(G2);
% title('image after weighted');
% %%
% res=G2;
end