function [resI]=otus_block(I,nbrBlock)
%% diverse image into N blocks
%nbrBlock=20;
nbr = mod(nbrBlock,2);
while nbr == 1
    disp('amount of block must be a even number');
    break;
end

[m,n]=size(I);
length = fix(2*n/nbrBlock);
block=zeros(m,length,nbrBlock);
upBlock=zeros(fix(m/2),length);
downBlock=zeros(m-fix(m/2),length);
nbrBlock=nbrBlock/2;

for i=1:nbrBlock     
    block(:,:,i)=I(:,(i-1)*length+1:i*length);
    upBlock(:,:,i)=block(1:m/2,:,i);
    downBlock(:,:,i)=block(fix(m/2)+1:end,:,i);
end

lastblock=I(:,nbrBlock*length+1:end);
upLastBlock(:,:)=lastblock(1:fix(m/2),:);
downLastBlock(:,:)=lastblock(fix(m/2)+1:end,:);

%% use otus4level for each block 

for k=1:nbrBlock
    %[IDX,T1,T2,T3]=otus4level(block(:,:,k));
    [IDX1,T11,T21,T31]=otus4level(upBlock(:,:,k));
    [IDX2,T12,T22,T32]=otus4level(downBlock(:,:,k));
    
    [r1,c1]=size(IDX1);
    [r2,c2]=size(IDX2);
    prob_11=0; prob_12=0;
    prob_21=0; prob_22=0;
    prob_31=0; prob_32=0;
    prob_41=0; prob_42=0;
    upclass=zeros(1,c1);
    downclass=zeros(1,c2);
 %% otus operation on upBlocks   
     for j=1:c1
        for i=1:r1
            if IDX1(i,j)==1
                prob_11=prob_11+1;
            elseif IDX1(i,j)==2
                prob_21=prob_21+1;
            elseif IDX1(i,j)==3
                prob_31=prob_31+1;
            else
                prob_41=prob_41+1;
            end
        end
        prob_11=prob_11/(r1*c1);
        prob_21=prob_21/(r1*c1);
        prob_31=prob_31/(r1*c1);
        prob_41=prob_41/(r1*c1);
        upclass(j)=max(max(max(prob_11,prob_21),prob_31),prob_41);
        
        if prob_11==upclass(j)
            upBlock(:,j,k)=0;
        elseif prob_21==upclass(j)
            upBlock(:,j,k)=85;
        elseif prob_31==upclass(j)
            upBlock(:,j,k)=170;
        else
            upBlock(:,j,k)=255;
        end
     end
 %% otus operation on dowmBlocks
    for j=1:c2
        for i=1:r2
            if IDX2(i,j)==1
                prob_12=prob_12+1;
            elseif IDX2(i,j)==2
                prob_22=prob_22+1;
            elseif IDX2(i,j)==3
                prob_32=prob_32+1;
            else
                prob_42=prob_42+1;
            end
        end
        prob_12=prob_12/(r2*c2);
        prob_22=prob_22/(r2*c2);
        prob_32=prob_32/(r2*c2);
        prob_42=prob_42/(r2*c2);
        downclass(j)=max(max(max(prob_12,prob_22),prob_32),prob_42);
        
        if prob_12==downclass(j)
            downBlock(:,j,k)=0;
        elseif prob_22==downclass(j)
            downBlock(:,j,k)=85;
        elseif prob_32==downclass(j)
            downBlock(:,j,k)=170;
        else
            downBlock(:,j,k)=255;
        end
    end   
end

% operation on last blocks of image
[IDX3,t11,t21,t31]=otus4level(upLastBlock);
[r3,c3]=size(IDX3);
prob_13=0;
prob_23=0;
prob_33=0;
prob_43=0;
upLastclass=zeros(1,c3);
    
for j=1:c3
    for i=1:r3
        if IDX3(i,j)==1
            prob_13=prob_13+1;
        elseif IDX3(i,j)==2
            prob_23=prob_23+1;
        elseif IDX3(i,j)==3
            prob_33=prob_33+1;
        else
            prob_43=prob_43+1;
        end
    end
    prob_13=prob_13/(r3*c3);
    prob_23=prob_23/(r3*c3);
    prob_33=prob_33/(r3*c3);
    prob_43=prob_43/(r3*c3);
    upLastclass(j)=max(max(max(prob_13,prob_23),prob_33),prob_43);

    if prob_13==upLastclass(j)
        upLastBlock(:,j)=0;
    elseif prob_23==upLastclass(j)
        upLastBlock(:,j)=85;
    elseif prob_33==upLastclass(j)
        upLastBlock(:,j)=170;
    else
        upLastBlock(:,j)=255;
    end
end

[IDX4,t12,t22,t32]=otus4level(downLastBlock);
[r4,c4]=size(IDX4);
prob_14=0;
prob_24=0;
prob_34=0;
prob_44=0;
downLastclass=zeros(1,c4);
    
for j=1:c4
    for i=1:r4
        if IDX4(i,j)==1
            prob_14=prob_14+1;
        elseif IDX4(i,j)==2
            prob_24=prob_24+1;
        elseif IDX4(i,j)==3
            prob_34=prob_34+1;
        else
            prob_44=prob_44+1;
        end
    end
    prob_14=prob_14/(r4*c4);
    prob_24=prob_24/(r4*c4);
    prob_34=prob_34/(r4*c4);
    prob_44=prob_44/(r4*c4);
    downLastclass(j)=max(max(max(prob_14,prob_24),prob_34),prob_44);

    if prob_14==downLastclass
        downLastBlock(:,j)=0;
    elseif prob_24==downLastclass(j)
        downLastBlock(:,j)=85;
    elseif prob_34==downLastclass(j)
        downLastBlock(:,j)=170;
    else
        downLastBlock(:,j)=255;
    end
end

%% reconstruction image by blocks
resI=I;

for i=1:nbrBlock     
    resI(1:fix(m/2),(i-1)*length+1:i*length)=upBlock(:,:,i);
    resI(fix(m/2)+1:end,(i-1)*length+1:i*length)=downBlock(:,:,i);
end
resI(1:fix(m/2),nbrBlock*length+1:end)=upLastBlock;
resI(fix(m/2)+1:m,nbrBlock*length+1:end)=downLastBlock;

for j=1:n
    if resI(1,j)~=255 && resI(fix(m/2)+1,j)~=255
        resI(:,j)=min(resI(1,j),resI(fix(m/2)+1,j));
    else
        resI(:,j)=255;
    end
end
            

% figure;
% subplot(2,1,1);
% imshow(I);
% title(['Figure originale ',num2str(imagename)])
% subplot(2,1,2);
% imshow(resI);
% title(['Figure after Otsu_block segmentation with ',num2str(nbrBlock),'blocks']);
end