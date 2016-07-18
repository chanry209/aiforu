clear; 
close all;
clc;

%% load
% addpath F:\Dropbox\aiforu\Electrophorese\
% folder = 'F:\Dropbox\aiforu\Electrophorese\profils\Etude avec Gerard\N\';
addpath C:\Users\qian\Dropbox\aiforu\Electrophorese\
folder = 'C:\Users\qian\Dropbox\aiforu\Electrophorese\profils\Etude avec Gerard\P\';

files=dir([folder '*.mat']);

data={'fichier' 'givenBands' 'ourBands' 'matchBands' 'Accuracy' 'TP matche Bande' 'FP bands ajoutes'...
    'FN bands oublies' };


glpf_fc=20;
rectangleSize=[5,7];
weight=[0.15,0.25, 0.20, 0.25,0.15];
nbrBlock=40;
 
%for i=1:length(files)
      i=21;
      g=load([folder files(i).name]);
      n1=find(files(i).name=='.',1,'first');
      n2=find(files(i).name=='_',1,'first');
      imagename=...
          ['C:\Users\qian\Dropbox\aiforu\Electrophorese\profils\Etude avec Gerard\P\' files(i).name(1:n1-1) '.png'];
      [infos]=sscanf(files(i).name(n2+2:end-4),'%d_%d-%dx%d-%d');
      I=imrotate(imread(imagename),infos(1)/10); % figure im contains many tubes
      
      G=preTraitement(I,glpf_fc,rectangleSize,weight);
      %close all;
      resI=otus_block(G,nbrBlock);
     %[resI,histo]=otus_block_old(I,glpf_fc, rectangleSize,weight, nbrBlock);

      [m,n]=size(resI);
      data{i+1,1}=files(i).name(1:end-3);
      data{i+1,2}=fix(g.bands);
      givenBands=fix(g.bands);
      %givenBands(:,:)=n-givenBands(:,:);
      if isempty(givenBands)
         %% search ourBands
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
         % remove the thinest band
         for k=2:n-1
             if resI(1,k)==0 && resI(1,k-1)~=0 && resI(1,k+1)~=0
                 a=find(idx(2,:)==k);
                 idx(2,a)=0;
             end
         end
         clear a;
         idxgap=unique(idx(2,:));
         if idxgap(1)==0
             idxgap=idxgap(2:end);
         end 
         % remove the thin band (size defini)
         sizeThin=3;
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
         ourBands=unique(ourBands);
      
        %remove the front and the rearmost bandes
         while ourBands(1,1)<=20
             ourBands=ourBands(2:end); 
         end
         if ourBands(1,size(ourBands,2))>=(n-15)
             ourBands=ourBands(1:size(ourBands,2)-1);
         end
         
         % fuse the proache band
         sizeFuse=12;
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
         
         subplot(3,1,2); imshow(G);
         title('figure after preprocessing');

         subplot(3,1,3); imshow(resI);
         title(['Figure after Otsu segmentation with ',num2str(nbrBlock),' blocks ',...
             'gaussFilter = ',num2str(glpf_fc)]);
         
         for j=1:size(ourBands,2)
             hold on;
             line([ourBands(j) ourBands(j)],[1 size(resI,2)],'Color',[0 1 0],'LineStyle','--');
         end
         
         text(10,110,'There is no givenBands','Color','red');
         % save the data 
          resultName =strcat( ['result_' files(i).name(1:end-4) '.mat' ]);
          resultName(find(isspace(resultName))) = [];
          parametresName=strcat(['parametres_' files(i).name(1:end-4) '.mat' ]);
          resultName(find(isspace(parametresName))) = [];
          save(parametresName,'glpf_fc', 'rectangleSize', 'weight', 'nbrBlock');
      
      else
          givenBands=sort(givenBands);          
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
         
         sizeThin=3; % size of thin band defined
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
      
      %% confusion matrice
         givenTemp=zeros(1,n);
         oursTemp=zeros(1,n);
         temp=1:n;
      
         for k=1:n
             for t=1:size(givenBands,2)
                 if temp(k)==givenBands(t)
                     givenTemp(k)=givenBands(t);
                 end
             end
         end
      
         for k=1:n
             for t=1:size(ourBands,2)
                 if temp(k)==ourBands(t)
                     oursTemp(k)=ourBands(t);
                 end
             end
         end
      
      % calulate the differents kinds of rate      
         matchBands=zeros(1,size(givenBands,2));
         dist=zeros(1,size(ourBands,2));
         sizeProach=15
         for k=1:size(givenBands,2)
             for t=1:size(ourBands,2)
                 dist(1,t)=abs(givenBands(k)-ourBands(t));
                 if dist(1,t)>=0 && dist(1,t)<=sizeProach
                     matchBands(k)=givenBands(k);
                 end
             end
         end
      matchBands=unique(matchBands);
            if matchBands(1,1)==0
             matchBands=matchBands(2:end);  % TP
            end
      
         data{i+1,4}=matchBands;  
      
         TP=size(matchBands,2);
         FN = size(givenBands,2)-size(matchBands,2); % bandes oubl¨¦es
         FP = size(ourBands,2)-size(matchBands,2); % bandes ajout¨¦es
         if FP>=0
             FP=FP;
         else
             FP=0;
         end
   
      % begin to calculate the elements of confusion matrix (the rates)
         Accuracy=TP/(TP+FP+FN);
         data{i+1,5}=Accuracy;
         data{i+1,6}=FP;
         data{i+1,7}=FN;
         data{i+1,8}=TP;
      
         myConfusionMatrix=[TP,FN;FP,0];
         
          text(-10,120,['FN (Band oublie) =',num2str(size(givenBands,2)-size(matchBands,2)),'; FP (Band ajoute) =', num2str(FP),...
              '; match band = ',num2str(size(matchBands,2))])
          text(-10,140,['gaussFilter = ',num2str(glpf_fc),'; nbrBlock = ',num2str(nbrBlock),...
              '; rectangleSize = [ ',num2str(rectangleSize),']']);
   %save the resultat and the parametres
          resultName =strcat( ['result_' files(i).name(1:end-4) '.mat' ]);
          resultName(find(isspace(resultName))) = [];
          parametresName=strcat(['parametres_' files(i).name(1:end-4) '.mat' ]);
          resultName(find(isspace(parametresName))) = [];
          save(parametresName,'glpf_fc', 'rectangleSize', 'weight', 'nbrBlock');
          save(resultName,'givenBands','ourBands','matchBands','Accuracy','FP','FN','TP');
      end
%end




