function [data,total,truebands,falsebands]=sensibilityvpp(folder)
    %folder = 'C:\Users\qian\Dropbox\stage\Electrophorese\profils\Etude avec Gerard\P\'    
    files=dir([folder '*.mat']);
    
    tolerance=15;
    data={'fichier' 'Xpert' 'Auto' 'match Xpert' 'match Auto' 'VP' 'FN bandes oubliées' 'FP bandes ajoutées' '(taux de bande detect?' '(taux de vrai bandes)' 'NXpert' 'NMethode' 'mean' 'stdH' 'wbands'};
    total=[0 0 0 0 0 0];
    truebands=zeros(4,0);
    falsebands=zeros(4,0);
    
    for f=1:length(files)
        g=load([folder files(f).name]);   % band
        n=find(files(f).name=='_',1,'first');
       %imagename=['C:\Users\ZF\Desktop\Electrophorese\buvards\' files(f).name(1:n-1) '.jpg\'];
        imagename=['C:\Users\qian\Dropbox\stage\Electrophorese\buvards\' files(f).name(1:n-1) '.jpg'];
        [infos]=sscanf(files(f).name(n+2:end-4),'%d_%d-%dx%d-%d');
        im=fast_rotate(imread(imagename),infos(1)/10);  % figure im contains many tubes
        [bands,ImProfild,pixelpercm,imrecal,scorec,scorefilt,mm,scorefilt2,pun,trs,seuils0,bounds,scorecold,nanimage,d]...
            =bandsproc([folder files(f).name(1:end-3) 'png']);
        % use Butterworth filter 
        [art,imbands,leftsig,rightsig]=whiteband(im,infos(2:5),pixelpercm);
        art=size(ImProfild,1)-art;
        
        resultName =strcat( ['result_' files(f).name(1:n-1) '.mat' ]);
        resultName(find(isspace(resultName))) = [];
        save(resultName,'scorefilt2','scorec','scorecold','scorefilt')
        
        wbands=[];
        for i=1:length(art)
            wbands=[wbands pun(abs(bands-art(i))<=15)];
            pun=pun(abs(bands-art(i))>15);
            bands=bands(abs(bands-art(i))>15);
        end
        bands=sort(bands);
        data{f+1,1}=files(f).name(1:end-3);
        data{f+1,2}=g.bands;
        data{f+1,3}=bands;
        data{f+1,13}=falsebands;
        
        %g.bands=[5   70  110 115  160 165      211                264   360 365];
        %bands=[4   40    111          164      210 215        260 265   364 369];
        

        match1=zeros(1,length(g.bands));
        match2=zeros(1,length(bands));
        
        
        if(~isempty(match1)&&~isempty(match2))
            for i=1:length(g.bands)
                [v,j]=min(abs(g.bands(i)-bands));
                if(v<=tolerance)
                    match1(i)=j;
                end
            end
            for i=1:length(bands)
                js=find(match1==i);
                if length(js)>=1
                    [~,n]=min(abs(bands(i)-g.bands(js)));
                    match2(i)=js(n);
                    match1(js([1:n-1 n+1:end]))=0;
                end
            end
        end
        data{f+1,4}=match1;
        data{f+1,5}=match2;
        truebands=[truebands d(:,match2>0)];
        falsebands=[falsebands d(:,match2==0)];
        data{f+1,6}=sum(match1>0);
        total(1)=total(1)+data{f+1,6};
        data{f+1,7}=sum(match1==0);
        total(2)=total(2)+data{f+1,7};
        data{f+1,8}=sum(match2==0);
        total(3)=total(3)+data{f+1,8};
        
        
        
        data{f+1,9}=data{f+1,6}/(data{f+1,6}+data{f+1,7});
        data{f+1,10}=data{f+1,6}/(data{f+1,6}+data{f+1,8});
        data{f+1,11}=data{f+1,6}+data{f+1,7};
        data{f+1,12}=data{f+1,6}+data{f+1,8};
        
        total(6)=total(6)+(data{f+1,12}>=3);
        
        
        
        %fi=figure('units','pixels','position',[1680 -30 1680 1188],'MenuBar','None','PaperUnits','centimeters','PaperPosition',[0 0 29.7 21],'PaperSize',[29.7 21]);
        fi=figure('units','pixels','MenuBar','None','PaperUnits','centimeters','PaperSize',[29.7 21]);
        uicontrol(fi,'Style','text','string',[files(f).name sprintf('\nVP:%d   FN(bandes oubliées):%d   FP(bandes ajoutés):%d   NBXpert:%d   NBMethode:%d',data{f+1,6},data{f+1,7},data{f+1,8},data{f+1,6}+data{f+1,7},data{f+1,6}+data{f+1,8})],'units','normalized','position',[0 .96 1 .04],'FontSize',12);
        AxIm=axes('Parent',fi,'units','normalized','position',[0 0.36 .5 .6]);
        
        image(im,'Parent',AxIm,'XData',[1 size(im,2)],'YData',[size(im,1) 1])
        set(AxIm,'ytick',[],'xtick',[], 'Ydir', 'normal')
        axis(AxIm,'image');
        rectangle('Parent',AxIm,'Position',[infos(2) infos(4) infos(3)-infos(2) infos(5)-infos(4)] );
        

        u8bands=uint8(zeros(size(imbands,1),size(imbands,2),3));
        for i=1:3
            u8bands(:,:,i)=round(imbands);
        end
        
        s=size(imrecal);
        s2=size(ImProfild);
        set(fi,'units','pixel')
        dim=get(fi,'position');
        
        Xdim=0.09*s(1)/s(2)*dim(4)/dim(3);
        Xdim2=0.09*s2(1)/s2(2)*dim(4)/dim(3);
        deltaX=.5*(Xdim2-Xdim);
        set(fi,'units','normalized')
        
        AxCurve=axes('Parent',fi,'units','normalized','position',[0.5+deltaX 0.36 Xdim .6]);
        x=1:length(scorec);
        plot(AxCurve,x,max(scorec)-scorec,x,max(scorec)-scorecold,x,max(scorec)-scorefilt,x,max(scorec)-mm,x,-scorefilt2,pun,-scorefilt2(pun),'+',[0 length(scorec)],[seuils0 seuils0],1:length(leftsig),-leftsig,1:length(leftsig),-rightsig)
        set(AxCurve,'xlim',[0 length(scorec)])
        
        ImProfil=imread([folder files(f).name(1:end-3) 'png']);
        imtmp=0.3*double(ImProfil(:,:,1))+double(ImProfil(:,:,2))+.6*double(ImProfil(:,:,3));
        data{f+1,13}=mean(mean(imtmp));
        data{f+1,14}=median(std(double(imtmp),[],2));
        
        
        AxProfil=axes('Parent',fi,'units','normalized','position',[0.5 0.27 Xdim2 .09]);
        image(permute(ImProfil,[2 1 3]),'Parent',AxProfil,'XData',[1 size(ImProfil,1)],'YData',[size(ImProfil,2) 1])
        %axis(AxProfil,'image');
        set(AxProfil,'YTick',[],'XTick',[], 'Ydir', 'normal')
        
        AxProfilClean=axes('Parent',fi,'units','normalized','position',[0.5 0.18 Xdim2 .09]);
        image(permute(u8bands,[2 1 3]),'Parent',AxProfilClean,'XData',[1 size(ImProfil,1)],'YData',[size(ImProfil,2) 1])
        %axis(AxProfilClean,'image');
        set(AxProfilClean,'ytick',[],'xtick',[], 'Ydir', 'normal')
        
        for i=1:size(nanimage,1)
            for j=1:size(nanimage,2)
                if(isnan(nanimage(i,j)))
                    ImProfil(i-trs(j),j,1)=0;
                    ImProfil(i-trs(j),j,2)=0;
                    ImProfil(i-trs(j),j,3)=255;
                end
            end
        end
        AxProfilClean=axes('Parent',fi,'units','normalized','position',[0.5 0.09 Xdim2 .09]);
        image(permute(ImProfil,[2 1 3]),'Parent',AxProfilClean,'XData',[1 size(ImProfil,1)],'YData',[size(ImProfil,2) 1])
        %axis(AxProfilClean,'image');
        set(AxProfilClean,'ytick',[],'xtick',[], 'Ydir', 'normal')
        
        imrecalMaxed=(imrecal-min(min(imrecal)))/(max(max(imrecal))-min(min(imrecal)));
        u8recal=uint8(zeros(size(imrecalMaxed,1),size(imrecalMaxed,2),3));
        %u8bands=uint8(zeros(size(imbands,1),size(imbands,2),3));
        for i=1:3
            u8recal(:,:,i)=round(imrecalMaxed*255);
        end
        
        AxProfilRecal=axes('Parent',fi,'units','normalized','position',[0.5+deltaX 0 Xdim .09]);
        image(permute(u8recal,[2 1 3]),'Parent',AxProfilRecal,'XData',[1 size(u8recal,1)],'YData',[size(u8recal,2) 1])
        %axis(AxProfilRecal,'image');
        set(AxProfilRecal,'ytick',[],'xtick',[], 'Ydir', 'normal')
                
        for i=1:length(g.bands)
            if(match1(i))
                line((size(ImProfil,1)-g.bands(i))*[1 1],[1 size(ImProfil,2)],'Parent',AxProfil,'Color',[0 1 0])
            else
                line((size(ImProfil,1)-g.bands(i))*[1 1],[1 size(ImProfil,2)],'Parent',AxProfil,'Color',[0 1 0],'LineStyle','--')
            end
        end
        
        
        for i=1:length(bands)
            if(match2(length(bands)+1-i))
                line(pun(i)-trs,size(ImProfil,2):-1:1,'Parent',AxProfil,'Color',[0 0 1])
            else
                line(pun(i)-trs,size(ImProfil,2):-1:1,'Parent',AxProfil,'Color',[0 0 1],'LineStyle','--')
            end
        end
        
        for i=1:length(art)
            line((size(ImProfil,1)-art(i))*[1 1],[1 size(ImProfil,2)],'Parent',AxProfil,'Color',[1 0 0])
            
        end
        for i=1:length(wbands)
            line(wbands(i)-trs,size(ImProfil,2):-1:1,'Parent',AxProfil,'Color',[0.2 0.2 0.2])
            
        end
        
        saveas(fi,[folder files(f).name(1:end-3) '.pdf'],'pdf')
        close(fi);
        if(any(g.bands(2:end)-g.bands(1:end-1)<=tolerance) && any(bands(2:end)-bands(1:end-1)<=tolerance))
            disp('warning: Confusion de bande possible')
            disp(files(f).name(1:end-3));
            disp([1:length(g.bands);g.bands;match1])
            disp([1:length(bands);bands;match2])
            disp('');
        end
    end
    total(4)=(total(1)+total(2));
    total(5)=(total(1)+total(3));

end