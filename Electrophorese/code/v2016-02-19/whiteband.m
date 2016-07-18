function [art,imbands,leftsig,rightsig]=whiteband(imbuvard,position,pixelpercm)

    imbuvard=(0.3*double(imbuvard(:,:,1))+double(imbuvard(:,:,2))+.6*double(imbuvard(:,:,3)))/1.9;
    bbw=imbuvard(end-position(4):end-position(3),:);
    %figure,image(bbw);
    mbuvard=butterfilt(median(bbw),pixelpercm,0,10,4,1);
    lsig=mbuvard(1:position(1)-1);
    dsig=mbuvard(position(2)+1:end);
    mgauche=find(lsig(2:end-1)>200 & lsig(1:end-2)<lsig(2:end-1) & lsig(3:end)<=lsig(2:end-1) ,1,'last')+1;
    mdroite=find(dsig(2:end-1)>200 & dsig(1:end-2)<dsig(2:end-1) & dsig(3:end)<=dsig(2:end-1) ,1,'first')+1+position(2);
    
    leftsig=butterfilt(median(imbuvard(end-position(4):end-position(3),mgauche-5:mgauche+5)'),pixelpercm,0,15,4,1);
    mm=-rollingball(-leftsig,35,20);
    leftsig=mm-leftsig;
    rightsig=butterfilt(median(imbuvard(end-position(4):end-position(3),mdroite-5:mdroite+5)'),pixelpercm,0,15,4,1);
    mm=-rollingball(-rightsig,35,20);
    rightsig=mm-rightsig;
    
    artleft=find(leftsig(2:end-1)>7 & leftsig(1:end-2)<leftsig(2:end-1) & leftsig(3:end)<=leftsig(2:end-1) )+1;
    
    imbands=[imbuvard(end-position(4):end-position(3),mgauche-5:mgauche+5) zeros(position(4)-position(3)+1,1) imbuvard(end-position(4):end-position(3),mdroite-5:mdroite+5)];
    
    artright=find(rightsig(2:end-1)>7 & rightsig(1:end-2)<rightsig(2:end-1) & rightsig(3:end)<=rightsig(2:end-1) )+1;
    art=sort([artleft artright]);
    %figure, plot([leftsig;rightsig]')
end