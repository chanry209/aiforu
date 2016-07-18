function [p,im,pixelpercm,imrecal,scorec,scorefilt,mm,scorefilt2,pun,trs,seuils0,bounds,scorecold,nanimage,d]=bandsproc(file)
    c=[0.3 1 0.6];
    lowpass=15;
    P1=35;
    P2=20;
    seuilsd2=2500;
    
    if(ischar(file))
        im=double(imread(file));
        pixelpercm=getresolution(file);
    else
        im=double(file);
        pixelpercm=236.22;
    end
        
    %pixelpercm=getresolution(file);
    
    
    imtmp=0.3*double(im(:,:,1))+double(im(:,:,2))+.6*double(im(:,:,3));
    s=mean(std(double(imtmp),[],2));
    m=mean(mean(imtmp));
% 
%     if(m<=340)
%         seuils0=4.5;%(550-m)/100*2;
%     elseif(m<=375)
%         seuils0=6;
%     else
%         seuils0=8;
%     end
    seuils0=4.2;
    
    
    m=[mean(mean(im(:,:,1))) mean(mean(im(:,:,2))) mean(mean(im(:,:,3)))];
    greyim=c(1)*(im(:,:,1)-m(1))+c(2)*(im(:,:,2)-m(2))+c(3)*(im(:,:,3)-m(3));
    [imrecal,trs,bounds]=recal1D(double(greyim));
    trs=trs-bounds(1)+1;
    bounds=bounds-bounds(1)+1;
    scorecold=median(imrecal,2);
    nanimage=pictureartifacts(imrecal,5,10,12,2,2);
    scorec=nanscore(nanimage);
    
    
    scorefilt=butterfilt(scorec',pixelpercm,0,lowpass,4,1);
    mm=-rollingball(-scorefilt,P1,P2);
    
    scorefilt2=scorefilt-mm;
    [p,d2,d,larg]=findpeaks(scorefilt2,pixelpercm,seuils0);
    
    d=[scorefilt2(p);d2;d;larg];
    
    pun=p;
    
    p=size(im,1)-p+mean(trs);
    
    
end