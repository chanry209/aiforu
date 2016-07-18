
function [resI,histo]=otus_block(I,glpf_fc, rectangleSize,weight, nbrBlock)
%% Image preprocessing
% glpf_fc=25;
% rectangleSize=[3,5];
% weight=[0.15,0.25, 0.20, 0.25,0.15];
[G,histo]=preTraitement(I,glpf_fc,rectangleSize,weight);
%close all;

%% diverse image into N blocks
%nbrBlock=20;
[m,n]=size(G);
length = fix(n/nbrBlock);
block=zeros(m,length,nbrBlock);

for i=1:nbrBlock     
    block(:,:,i)=G(:,(i-1)*length+1:i*length);
end

lastblock=zeros(m,n-length*nbrBlock);
lastblock=G(:,nbrBlock*length+1:end);

%% use otus4level for each block 

for k=1:nbrBlock
    [IDX,T1,T2,T3]=otus4level(block(:,:,k));
    
    [r,c]=size(IDX);
    prob_1=0;
    prob_2=0;
    prob_3=0;
    prob_4=0;
    
    for j=1:c
        for i=1:r
            if IDX(i,j)==1
                prob_1=prob_1+1;
            elseif IDX(i,j)==2
                prob_2=prob_2+1;
            elseif IDX(i,j)==3
                prob_3=prob_3+1;
            else
                prob_4=prob_4+1;
            end
        end
        prob_1=prob_1/(r*c);
        prob_2=prob_2/(r*c);
        prob_3=prob_3/(r*c);
        prob_4=prob_4/(r*c);
        class=max(max(max(prob_1,prob_2),prob_3),prob_4);
        
        if prob_1==class
            block(:,j,k)=0;
        elseif prob_2==class
            block(:,j,k)=85;
        elseif prob_3==class
            block(:,j,k)=170;
        else
            block(:,j,k)=255;
        end
    end
end

[IDX2,t1,t2,t3]=otus4level(lastblock);
[r2,c2]=size(IDX2);
prob_1=0;
prob_2=0;
prob_3=0;
prob_4=0;
    
for j=1:c2
    for i=1:r2
        if IDX2(i,j)==1
            prob_1=prob_1+1;
        elseif IDX2(i,j)==2
            prob_2=prob_2+1;
        elseif IDX2(i,j)==3
            prob_3=prob_3+1;
        else
            prob_4=prob_4+1;
        end
    end
    prob_1=prob_1/(r2*c2);
    prob_2=prob_2/(r2*c2);
    prob_3=prob_3/(r2*c2);
    prob_4=prob_4/(r2*c2);
    class=max(max(max(prob_1,prob_2),prob_3),prob_4);

    if prob_1==class
        lastblock(:,j)=0;
    elseif prob_2==class
        lastblock(:,j)=85;
    elseif prob_3==class
        lastblock(:,j)=170;
    else
        lastblock(:,j)=255;
    end
end


%% reconstruction image by blocks
resI=G;

for i=1:nbrBlock     
    resI(:,(i-1)*length+1:i*length)=block(:,:,i);
end
resI(:,i*length+1:n)=lastblock;

figure;
subplot(2,1,1);
imshow(I);
title(['Figure originale ',num2str(imagename)])
subplot(2,1,2);
imshow(resI);
title(['Figure after Otsu_block segmentation with ',num2str(nbrBlock),'blocks']);
end
