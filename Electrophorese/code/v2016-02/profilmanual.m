classdef profilmanual < hgsetget
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
        bands
        
    end
    methods
        function obj=profilmanual(im,ppcm,filename)
            obj.Fig=figure('MenuBar','None','CloseRequestFcn',@(src,evts) delete(obj),'WindowButtonDownFcn',@(src,evt) MouseDown(obj));
            if(~exist('filename','var'))
                filename='';
            end
            obj.txtFile=uicontrol(obj.Fig,'style','edit','Units','normalized','position',[0 .95 .95 .05],'BackgroundColor',[1 1 1],'String',filename);
            obj.btnBrowse=uicontrol(obj.Fig,'style','pushbutton','Units','normalized','position',[.95 .95 .05 .05],'String','...','Callback',@(src,evt) browse(obj));
            
            if(~exist('im','var'))
                [f,p]=uigetfile('*.png;*.jpg');
                im=[p f];
            end
            obj.bands=[];
            if isnumeric(im)
                obj.Image=im;
                obj.pixelpercm=ppcm;
            else
                obj.Image=imread(im);
                load([im(1:end-3) 'mat']);
                obj.bands=bands;
                obj.pixelpercm=getresolution(im);
                set(obj.txtFile,'String',im);
            end
            
            tbh = uitoolbar(obj.Fig);
            uipushtool(tbh,'CData',imread('save.bmp'),'TooltipString','Save','ClickedCallback',@(src,evt) save(obj));
            
            panel=uipanel('Parent',obj.Fig,'position',[0 0 1 .95]);
            obj.AxesOriginal=axes('parent',panel,'position',[.45 0 0.1 1]);
      
            obj.setImage();
        end
        
        function setfilename(obj,f)
            set(obj.txtFile,'String',f);
        end
        
        function setImage(obj,img,pixelpercm)
            if(exist('img','var'))
                obj.Image=img;
                set(obj.txtFile,'String','')
                obj.bands=[];
            end
            if(exist('pixelpercm','var'))
                obj.pixelpercm=pixelpercm;
            end
            
            image(obj.Image,'Parent',obj.AxesOriginal,'XData',[1 size(obj.Image,2)],'YData',[size(obj.Image,1) 1]);
            for i=1:length(obj.bands)
                line([1 size(obj.Image,2)],(obj.bands(i))*[1 1],'Parent',obj.AxesOriginal)
            end
            set(obj.AxesOriginal,'ytick',0:obj.pixelpercm/5:size(obj.Image,1),'yticklabel',{},'xtick',[], 'Ydir', 'normal')
            
            
        end
        function MouseDown(obj)
            pos=get(obj.AxesOriginal,'CurrentPoint');
            ylim=get(obj.AxesOriginal,'Ylim');
            xlim=get(obj.AxesOriginal,'Xlim');
            if pos(1,1)>=xlim(1) && pos(1,1)<=xlim(2) && pos(1,2)>=ylim(1) && pos(1,2)<=ylim(2)
                if(strcmp(get(obj.Fig,'SelectionType'),'alt'))
                    [~,n]=min(abs(obj.bands-pos(1,2)));
                    obj.bands=obj.bands([1:n-1 n+1:end]);
                else
                    obj.bands=sort([obj.bands pos(1,2)]);
                end
                obj.setImage();
            end
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
           obj.save();
       end
       function save(obj)
           file=get(obj.txtFile,'String');
           imwrite(obj.Image,file,'png','ResolutionUnit','meter','XResolution',round(100*obj.pixelpercm),'YResolution',round(100*obj.pixelpercm));
           fileband=[file(1:end-3) 'mat'];
           bands=obj.bands;
           save(fileband,'bands');
       end
    end
end



