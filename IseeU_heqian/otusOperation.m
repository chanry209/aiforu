function resI=otusOperation(G,nbrBlock)
resI=otus_block(G,nbrBlock);
[m,n]=size(resI);
%% search ourBands
% seconde method:find the more general, more obuvious bandes
idxBlack=find(resI(1,:)==0);
idx=zeros(2,size(idxBlack,2));
idx(1,:)=idxBlack(:,:);
idx(2,1)=idx(1,1);
idx(2,size(idxBlack,2))=idx(1,size(idxBlack,2));
for k=1:size(idx,2)-1
    if idx(1,k+1)-idx(1,k)~=1
        idx(2,k)=idx(1,k);
        idx(2,k+1)=idx(1,k+1);
    end
end
% remove the useless lines
for k=2:n-1
    if resI(1,k)==0 && resI(1,k-1)~=0 && resI(1,k+1)~=0 % the thinest band
        a=find(idx(2,:)==k);
        idx(2,a)=0;
    end
end

idxgap=unique(idx(2,:));
if idxgap(1)==0
     idxgap=idxgap(2:end);    % the foremost line
end

sizeThin=4; % size of thin band defined
if mod(sizeThin,2)==0
    error('the length of useless bandes must be a uneven number')
    break;
end

for k=1:2:size(idxgap,2)-1
    if abs(idxgap(k)-idxgap(k+1))<=sizeThin
        idxgap(k:k+1)=0;
    else
        ourBands(k)=fix((idxgap(k)+idxgap(k+1))/2);
    end
end

clear a;
clear d;
ourBands=unique(ourBands);


% remove the front and the rearmost bandes
 while ourBands(1,1)<=20
     ourBands=ourBands(2:end);
 end
 if ourBands(1,size(ourBands,2))>=(n-10)
     ourBands=ourBands(1:size(ourBands,2)-1);
 end

 % fuse the proache band 
 sizeFuse=15;
 for k=1:size(ourBands,2)-1
     if abs(ourBands(k)-ourBands(k+1))<=sizeFuse
         ourBands(k)=(ourBands(k)+ourBands(k+1))/2;
         ourBands(k+1)=ourBands(k);
     end
 end
 ourBands=unique(ourBands);

 figure;
 subplot(3,1,1); imshow(I);
 title(['Figure originale ',num2str(files(i).name(1:n1-1))])
 for j=1:size(ourBands,2)
     hold on;
     line([ourBands(j) ourBands(j)],[1 size(resI,2)],'Color',[0 1 0],'LineStyle','--');
 end
 for j=1:size(givenBands,2)
     bandLine=givenBands(j);
     hold on;
     line([bandLine bandLine],[1 size(resI,2)],'Color',[1 0 0],'LineStyle','-');
 end

 subplot(3,1,2); imshow(G);
 title('figure after preprocessing');

 subplot(3,1,3); imshow(resI);
 title(['Figure after Otsu segmentation with ',num2str(nbrBlock),' blocks ',...
     'gaussFilter = ',num2str(glpf_fc)]);

 for j=1:size(ourBands,2)
     hold on;
     line([ourBands(j) ourBands(j)],[1 size(resI,2)],'Color',[0 1 0],'LineStyle','--');
 end
 for j=1:size(givenBands,2)
     bandLine=givenBands(j);
     hold on;
     line([bandLine bandLine],[1 size(resI,2)],'Color',[1 0 0],'LineStyle','-');
 end
