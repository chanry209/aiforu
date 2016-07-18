classdef profil < hgsetget
    properties(SetAccess=public)
        Fig
        AxesOriginal
        AxesACP
        AxesRecal
        AxesArt
        AxesCurve
        AxesCurveFiltered
        txtFile
        Image
        btnBrowse
        pixelpercm
        edtHigh
        edtSeuil
        edtACP
        chkACP
        rdSam
        rdrollerBall
        rdlowpass
        rdNone
        edtP1
        edtP2
        
    end
    methods
        function obj=profil(im,ppcm)
            obj.Fig=figure('MenuBar','None','CloseRequestFcn',@(src,evts) delete(obj));
            
            obj.txtFile=uicontrol(obj.Fig,'style','edit','Units','normalized','position',[0 .95 .95 .05],'BackgroundColor',[1 1 1]);
            obj.btnBrowse=uicontrol(obj.Fig,'style','pushbutton','Units','normalized','position',[.95 .95 .05 .05],'String','...','Callback',@(src,evt) browse(obj));
            
            if(~exist('im','var'))
                [f,p]=uigetfile('*.png;*.jpg');
                im=[p f];
            end
            
            if isnumeric(im)
                obj.Image=im;
                obj.pixelpercm=ppcm;
            else
                obj.Image=imread(im);
                obj.pixelpercm=getresolution(im);
                set(obj.txtFile,'String',im);
            end
            
            
            
            
            tbh = uitoolbar(obj.Fig);
            uipushtool(tbh,'CData',imread('save.bmp'),'TooltipString','Save','ClickedCallback',@(src,evt) save(obj));
            
            panel=uipanel('Parent',obj.Fig,'position',[0 0.1 1 .85]);
            obj.AxesOriginal=axes('parent',panel,'position',[0 0 0.1 1]);
            obj.AxesACP=axes('parent',panel,'position',[0.1 0 0.1 1]);
            obj.AxesRecal=axes('parent',panel,'position',[0.2 0 0.1 1]);
            %obj.AxesCurve=axes('parent',panel,'position',[0.3 0 0.35 1]);
            obj.AxesCurve=axes('parent',obj.Fig,'position',[0.3 0.1 0.35 .85]);
            obj.AxesCurveFiltered=axes('parent',obj.Fig,'position',[0.65 0.1 0.35 .85]);
            
            uicontrol(obj.Fig,'Style','text','units','normalized','position',[0.01 0.005 .05 .04],'String','RGB:')
            obj.chkACP=uicontrol(obj.Fig,'Style','checkbox','units','normalized','position',[0.06 0.005 .05 .04],'value',0,'String','auto');
            obj.edtACP=uicontrol(obj.Fig,'Style','edit','units','normalized','position',[0.12 0.005 .1 .04],'String','0.3 1 0.6');
            uicontrol(obj.Fig,'Style','text','units','normalized','position',[0.24 0.005 .05 .04],'String','PB:')
            obj.edtHigh=uicontrol(obj.Fig,'Style','edit','units','normalized','position',[0.3 0.005 .05 .04],'String','10.0');
            uicontrol(obj.Fig,'Style','text','units','normalized','position',[0.37 0.005 .04 .04],'String','BL:')
            b=uibuttongroup(obj.Fig,'units','normalized','position',[0.42 0.0 .18 .05]);
            obj.rdSam=uicontrol(b,'Style','radio','units','normalized','position',[0 .1 .25 .8],'String','Sam');
            obj.rdrollerBall=uicontrol(b,'Style','radio','units','normalized','position',[.25 .1 .25 .8],'String','ball','Value',1);
            obj.rdlowpass=uicontrol(b,'Style','radio','units','normalized','position',[.5 .1 .25 .8],'String','LP');
            obj.rdNone=uicontrol(b,'Style','radio','units','normalized','position',[.75 .1 .25 .8],'String','none');
            obj.edtP1=uicontrol(obj.Fig,'Style','edit','units','normalized','position',[0.62 0.005 .05 .04],'String','35');
            obj.edtP2=uicontrol(obj.Fig,'Style','edit','units','normalized','position',[0.68 0.005 .05 .04],'String','20');
            
            uicontrol(obj.Fig,'Style','text','units','normalized','position',[0.75 0.005 .06 .04],'String','Seuil:')
            obj.edtSeuil=uicontrol(obj.Fig,'Style','edit','units','normalized','position',[0.82 0.005 .06 .04],'String','6 2500');
            
            uicontrol(obj.Fig,'Style','pushbutton','units','normalized','position',[0.9 0.005 .1 .04],'String','Recalculer','Callback',@(src,evt) setImage(obj));
            
            obj.setImage();
        end
        
        function setImage(obj,img,pixelpercm)
            if(exist('img','var'))
                obj.Image=img;
            end
            if(exist('pixelpercm','var'))
                obj.pixelpercm=pixelpercm;
            end
            if get(obj.chkACP,'Value')
                [greyim,m,c]=imageACP(obj.Image);
                set(obj.edtACP,'String',sprintf('%.2f %2.f %.2f',c))
            else
                %greyim=zeros(size(obj.Image,1),size(obj.Image,2));
                c=eval(['[' get(obj.edtACP,'String') ']']);
                
                im=double(obj.Image);
                m=[mean(mean(im(:,:,1))) mean(mean(im(:,:,2))) mean(mean(im(:,:,3)))];
                greyim=c(1)*(im(:,:,1)-m(1))+c(2)*(im(:,:,2)-m(2))+c(3)*(im(:,:,3)-m(3));
                %greyim=(greyim-min(min(greyim)))/(max(max(greyim))-min(min(greyim)));
            end
            
            [p,im,pixelpercm,imrecal,scorec,scorefilt,mm,scorefilt2,pun,trs,seuils0,bounds]=bandsproc(obj.Image);
            im=double(im);
            m=[mean(mean(im(:,:,1))) mean(mean(im(:,:,2))) mean(mean(im(:,:,3)))];
            greyim=c(1)*(im(:,:,1)-m(1))+c(2)*(im(:,:,2)-m(2))+c(3)*(im(:,:,3)-m(3));
            
            %[imrecal,trs,bounds]=recal1D(double(greyim));
            set(obj.AxesACP,'position',[0.1 bounds(1)/size(greyim,1) 0.1 (bounds(2)-bounds(1))/size(greyim,1)])
            set(obj.AxesRecal,'position',[0.2 bounds(1)/size(greyim,1) 0.1 (bounds(2)-bounds(1))/size(greyim,1)])
            score=median(greyim,2);
            %scorec=median(imrecal,2);
            %scorefilt=butterfilt(scorec',obj.pixelpercm,0,str2double(get(obj.edtHigh,'String')),4,1);
%             if get(obj.rdSam,'Value')
%                 mm=medgliss(scorefilt,round(str2double(get(obj.edtP1,'String'))*obj.pixelpercm*2+1),0.9);
%             	mm=medgliss(mm,round(str2double(get(obj.edtP1,'String'))*obj.pixelpercm*2+1),0.1);
%             elseif get(obj.rdrollerBall,'Value')
%                 mm=-rollingball(-scorefilt,str2double(get(obj.edtP1,'String')),str2double(get(obj.edtP2,'String')));
%             elseif get(obj.rdlowpass,'Value')
%                 mm=butterfilt(scorefilt,obj.pixelpercm,0,str2double(get(obj.edtP1,'String')),4,1);
%             else
%                 mm=zeros(size(scorefilt));
%             end
            
            %scorefilt=scorefilt-mm;
            %scorefilt=butterfilt((scorec-mm)',obj.pixelpercm,0,str2double(get(obj.edtHigh,'String')),4,1);
            %scorefilt=butterfilt(scorec',obj.pixelpercm,str2double(get(obj.edtLow,'String')),str2double(get(obj.edtHigh,'String')),4,1);
            
%             seuils=eval([ '[' get(obj.edtSeuil,'String') ']']);
%             if length(seuils)==2
%                 seuilsd2=seuils(2);
%                 seuils0=seuils(1);
%             else
%                 seuilsd2=seuils;
%                 seuils0=-100000;
%             end
%             
%             p=findpeaks(scorefilt,obj.pixelpercm,seuilsd2);
%             
%             p=p(scorefilt(p)<-seuils0);
            
            
            plot(obj.AxesCurve,score,1:length(score),[scorec';mm;scorefilt],bounds(1)+(1:length(scorec)));
            set(obj.AxesCurve,'ylim',[0 size(greyim,1)],'ytick',[], 'Ydir', 'reverse');
            
            plot(obj.AxesCurveFiltered,scorefilt2,bounds(1)+(1:length(scorec)),scorefilt2(pun),bounds(1)+pun,'+',[0 0],[1 size(greyim,1)],'k-',-[seuils0 seuils0],[1 size(greyim,1)],'b-');
            set(obj.AxesCurveFiltered,'ylim',[0 size(greyim,1)],'ytick',sort(size(obj.Image,1):-obj.pixelpercm/5:0),'yticklabel',{}, 'Ydir', 'reverse');
            
            %greyimMaxed=(greyim-min(min(greyim)))/(max(max(greyim))-min(min(greyim)));
            
            nanimage=pictureartifacts(imrecal,5,10,12,2,2);
            
            nanimageMaxed=(nanimage-min(min(imrecal)))/(max(max(imrecal))-min(min(imrecal)));
            
            imrecalMaxed=(imrecal-min(min(imrecal)))/(max(max(imrecal))-min(min(imrecal)));
            imscore=scorefilt2'*ones(1,size(imrecal,2));
            imscoreMaxed=(imscore-min(min(imscore)))/(max(max(imscore))-min(min(imscore)));
            u8recal=uint8(zeros(size(imrecalMaxed,1),size(imrecal,2),3));
            u8nan=uint8(zeros(size(imrecalMaxed,1),size(imrecal,2),3));            
            u8score=uint8(zeros(size(imscoreMaxed,1),size(imscoreMaxed,2),3));
            for i=1:3
                u8score(:,:,i)=round(imscoreMaxed*255);
                u8recal(:,:,i)=round(imrecalMaxed*255);
            end
            u8nan=u8recal;
            for i=1:size(u8nan,1)
                for j=1:size(u8nan,2)
                    if(isnan(nanimage(i,j)))
                        u8nan(i,j,1)=0;u8nan(i,j,2)=0;u8nan(i,j,3)=255;
                    end
                end
            end

            image(obj.Image,'Parent',obj.AxesOriginal,'XData',[1 size(obj.Image,2)],'YData',[size(obj.Image,1) 1]);
            for i=1:length(p)
                line(1:size(obj.Image,2),size(obj.Image,1)-pun(i)+trs,'Parent',obj.AxesOriginal)
            end
            
            
            set(obj.AxesOriginal,'ytick',0:obj.pixelpercm/5:size(obj.Image,1),'yticklabel',{},'xtick',[], 'Ydir', 'normal')
            
            
            
%             image(u8grey,'Parent',obj.AxesACP,'XData',[1 size(obj.Image,2)],'YData',[size(obj.Image,1) 1]);
%             set(obj.AxesACP,'ytick',0:obj.pixelpercm/5:size(obj.Image,1),'yticklabel',{},'xtick',[], 'Ydir', 'normal')
            image(u8recal,'Parent',obj.AxesACP,'XData',[1 size(u8recal,2)],'YData',[size(u8recal,1) 1]);
            set(obj.AxesACP,'ytick',[],'xtick',[], 'Ydir', 'normal')
            image(u8nan,'Parent',obj.AxesRecal,'XData',[1 size(u8score,2)],'YData',[size(u8score,1) 1]);
            set(obj.AxesRecal,'ytick',[],'xtick',[], 'Ydir', 'normal')
            %axis(obj.AxesOriginal,'image');
        end
        
       function delete(obj)
            h = obj.Fig;
            if ishandle(h)
                delete(h);
            else
                return
            end
       end
       function browse(obj)
           [f,p]=uiputfile('*.png');
           set(obj.txtFile,'String',[p f])
       end
       function save(obj)
           file=get(obj.txtFile,'String');
           imwrite(obj.Image,file,'png','ResolutionUnit','meter','XResolution',round(100*obj.pixelpecm),'YResolution',round(100*obj.pixelpecm));
       end
    end
end



