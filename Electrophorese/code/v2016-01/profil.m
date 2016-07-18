classdef profil < hgsetget
    properties(SetAccess=public)
        Fig
        AxesOriginal
        AxesACP
        AxesRecal
        AxesCurve
        AxesCurveFiltered
        txtFile
        Image
        btnBrowse
        pixelpercm
        edtLow
        edtHigh
        edtSeuil
        
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
            
            panel=uipanel('Parent',obj.Fig,'position',[0 0.05 1 .9]);
            obj.AxesOriginal=axes('parent',panel,'position',[0 0 0.1 1]);
            obj.AxesACP=axes('parent',panel,'position',[0.1 0 0.1 1]);
            obj.AxesRecal=axes('parent',panel,'position',[0.2 0 0.1 1]);
            obj.AxesCurve=axes('parent',panel,'position',[0.3 0 0.35 1]);
            obj.AxesCurveFiltered=axes('parent',panel,'position',[0.65 0 0.35 1]);
            
            
            uicontrol(obj.Fig,'Style','text','units','normalized','position',[0.01 0.005 .1 .04],'String','Filtre :')
            obj.edtLow=uicontrol(obj.Fig,'Style','edit','units','normalized','position',[0.12 0.005 .1 .04],'String','0.5');
            obj.edtHigh=uicontrol(obj.Fig,'Style','edit','units','normalized','position',[0.23 0.005 .1 .04],'String','10.0');
            uicontrol(obj.Fig,'Style','text','units','normalized','position',[0.35 0.005 .08 .04],'String','Seuil d2:')
            obj.edtSeuil=uicontrol(obj.Fig,'Style','edit','units','normalized','position',[0.45 0.005 .1 .04],'String','2500');
            
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
            [greyim,m,c]=imageACP(obj.Image);
            [imrecal,trs,bounds]=recal1D(double(greyim));
            set(obj.AxesRecal,'position',[0.2 bounds(1)/size(greyim,1) 0.1 (bounds(2)-bounds(1))/size(greyim,1)])
            score=median(greyim,2);
            scorec=median(imrecal,2);
            
            scorefilt=butterfilt(scorec',obj.pixelpercm,str2double(get(obj.edtLow,'String')),str2double(get(obj.edtHigh,'String')),4,1);
            
            p=findpeaks(scorefilt,obj.pixelpercm,str2double(get(obj.edtSeuil,'String')));
            
            
            plot(obj.AxesCurve,score,1:length(score),scorec,bounds(1)+(1:length(scorec)));
            set(obj.AxesCurve,'ylim',[0 size(greyim,1)],'ytick',[], 'Ydir', 'reverse');
            
            plot(obj.AxesCurveFiltered,scorefilt,bounds(1)+(1:length(scorec)),scorefilt(p),bounds(1)+p,'+');
            set(obj.AxesCurveFiltered,'ylim',[0 size(greyim,1)],'ytick',sort(size(obj.Image,1):-obj.pixelpercm/5:0),'yticklabel',{}, 'Ydir', 'reverse');
            
            greyimMaxed=(greyim-min(min(greyim)))/(max(max(greyim))-min(min(greyim)));
            imrecalMaxed=(imrecal-min(min(imrecal)))/(max(max(imrecal))-min(min(imrecal)));
            u8grey=uint8(zeros(size(greyimMaxed,1),size(greyimMaxed,2),3));
            u8recal=uint8(zeros(size(imrecalMaxed,1),size(imrecal,2),3));
            for i=1:3
                u8grey(:,:,i)=round(greyimMaxed*255);
                u8recal(:,:,i)=round(imrecalMaxed*255);
            end

            image(obj.Image,'Parent',obj.AxesOriginal,'XData',[1 size(obj.Image,2)],'YData',[size(obj.Image,1) 1]);
            for i=1:length(p)
                line(1:size(obj.Image,2),size(obj.Image,1)-p(i)+trs,'Parent',obj.AxesOriginal)
            end
            
            
            set(obj.AxesOriginal,'ytick',0:obj.pixelpercm/5:size(obj.Image,1),'yticklabel',{},'xtick',[], 'Ydir', 'normal')
            
            
            
            image(u8grey,'Parent',obj.AxesACP,'XData',[1 size(obj.Image,2)],'YData',[size(obj.Image,1) 1]);
            set(obj.AxesACP,'ytick',0:obj.pixelpercm/5:size(obj.Image,1),'yticklabel',{},'xtick',[], 'Ydir', 'normal')
            image(u8recal,'Parent',obj.AxesRecal,'XData',[1 size(u8recal,2)],'YData',[size(u8recal,1) 1]);
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



