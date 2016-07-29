<<<<<<< HEAD
function J=deletHighlight(I,coef)
=======
function J=deletHighlight(I,coef,indexFig)
% if indexFig==1 then show the image

>>>>>>> 80f0d437e488b6942c9a536731ab8045409bcca7
[m,n]=size(I);
L=256;
histo=zeros(L,1);
for i=1:m
    for j=1:n
        histo(I(i,j)+1)=histo(I(i,j)+1)+1;
    end
end
%% distribution of pixel of each column
% this operation is for observer distribution and the type of bruit
%meanI=zeros(1,n);
medianI = zeros(1,n);
% for j=1:n
%     meanI(j)=mean(I(:,j));
% end
for j=1:n
    medianI(j)=median(I(:,j));
end

%% Ignore the  top coef% highlights by the median of each colone  
J=I;
for j=1:n
    temp=sort(unique(I(:,j)));
    length=size(temp,1);
    threshold=temp(round(coef*length)+1);
    
    for i=1:m
        if J(i,j)>threshold
            J(i,j)=medianI(j);
        end
    end
end
<<<<<<< HEAD

figure;
subplot(2,1,1);
imshow(I);
title('Figure originale');
subplot(2,1,2)
imshow(J);
title(['Figure after ignore the top ', num2str(coef),'  highlights']);
=======
    if indexFig ==1 
    figure;
    subplot(2,1,1);
    imshow(I);
    title('Figure originale');
    subplot(2,1,2)
    imshow(J);
    title(['Figure after ignore the top ', num2str(coef),'  highlights']);
    end
>>>>>>> 80f0d437e488b6942c9a536731ab8045409bcca7
end