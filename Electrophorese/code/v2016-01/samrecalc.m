function [scorec,imrecal,trs,bounds]=samrecalc(im)

if(~exist('im','var'))
    [f,p]=uigetfile('*.png;*.jpg');
    im=[p f];
end

if isnumeric(im)
    rawim=im;
else
    rawim=imread(im);
end
%rawim=rawim(1:2:end,1:8:end,:);
for i=1:3
    tmp=rawim(:,:,i);
    colorvec(:,i)=double(tmp(:));
end

m=mean(colorvec);
%colorvec=colorvec-ones(size(colorvec,1),1)*m;
[P,D]=eig(colorvec'*colorvec/size(colorvec,1));
[vmax,imax]=max(diag(D));
coef=P(:,i);


grayim=coef(1)*double(rawim(:,:,1))+coef(2)*double(rawim(:,:,2))+coef(3)*double(rawim(:,:,3));
grayim=(grayim-min(min(grayim)))/(max(max(grayim))-min(min(grayim)));

tic;[imrecal,trs,bounds]=recal1D(grayim);toc;


f=figure;
a1=axes('parent',f,'position',[0 0.3 1 0.7]);

score=median(grayim,2);
mid=ceil(size(grayim,2)/2);
%scoreb=mean(grayim(:,mid+(-5:5)),2);
scorec=median(imrecal,2);

plot(a1,1:length(score),score,bounds(1)+(1:length(scorec)),scorec);
set(a1,'xlim',[0 size(rawim,1)]);

a2=axes('parent',f,'position',[bounds(1)/size(grayim,1) 0.15 (bounds(2)-bounds(1))/size(grayim,1) 0.15]);
for i=1:3    
    imrecalplot(:,:,i)=uint8(round(255*imrecal'));
end
image(imrecalplot,'Parent',a2);
set(a2,'ytick',[],'xtick',[])

a3=axes('parent',f,'position',[0 0 1 0.15]);
for i=1:3
    rawimp(:,:,i)=rawim(:,:,i)';
end
image(rawimp,'Parent',a3);
set(a3,'ytick',[],'xtick',[])
