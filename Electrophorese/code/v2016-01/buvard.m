classdef buvard < hgsetget
    properties(SetAccess=public)
        Fig
        Axes
        startclick
        Angle
        RawImage
        Image
        toggles
        profilobj
        rect
        pixelpercm
    end
    methods
        function obj=buvard(im)
            if(~exist('im','var'))
                [f,p]=uigetfile('*.png;*.jpg');
                im=[p f];
            end

            if isnumeric(im)
                obj.Image=im;
                obj.pixelpercm=236.22048;
            else
                obj.Image=imread(im);
                obj.pixelpercm=getresolution(im);
            end
            
            obj.RawImage=obj.Image;
            obj.Fig=figure('MenuBar','None','WindowButtonMotionFcn',@(src,evt) MouseMovement(obj),'WindowButtonDownFcn',@(src,evt) MouseDown(obj),'WindowButtonUpFcn',@(src,evt) MouseUp(obj));
            tbh = uitoolbar(obj.Fig);
            obj.toggles(1) = uitoggletool(tbh,'CData',imread('rotate.bmp'),'TooltipString','Rotate');
            obj.toggles(2) = uitoggletool(tbh,'CData',imread('square.bmp'),'TooltipString','Profil');

            obj.Axes=axes('parent',obj.Fig,'position',[0 0 1 1]);
            image(obj.Image,'Parent',obj.Axes,'XData',[1 size(obj.Image,2)],'YData',[size(obj.Image,1) 1]);
            set(obj.Axes,'ytick',[],'xtick',[], 'Ydir', 'normal')
            axis(obj.Axes,'image');
            obj.startclick=[];
            obj.Angle=0;
            obj.rect=rectangle('Parent',obj.Axes,'Position',[-1 -1 1 1]);
            obj.profilobj=[];
        end
        
        function mode=getMode(obj)
            mode=0;
            for i=1:length(obj.toggles)
                if(strcmp(get(obj.toggles(i),'State'),'on'))
                    mode=i;
                end
            end
        end
        
        function MouseMovement(obj)
            if(obj.getMode()==1 && ~isempty(obj.startclick))
                pos=get(obj.Axes,'CurrentPoint'); 
                centre=size(obj.Image)/2;centre=centre([2 1]);
                v1=obj.startclick-centre;v2=pos(1,1:2)-centre;
                A=acos( dot(v1,v2)/(norm(v1)*norm(v2)) );
                if(dot([v1(2) -v1(1)],v2)>0)
                    A=-A;
                end
                 
                %set(obj.Axes,'CameraViewAngle',A/pi*180)
                %rotate(obj.imobj,[1 0 0 ],5,[centre 0])

                B=fast_rotate(obj.Image,A/pi*180);
 
                image(B,'Parent',obj.Axes,'XData',[1 size(obj.Image,2)],'YData',[size(obj.Image,1) 1]);
                set(obj.Axes,'ytick',[],'xtick',[],'Ydir', 'normal')
                axis(obj.Axes,'image');
            elseif(obj.getMode()==2 && ~isempty(obj.startclick))
                pos=get(obj.Axes,'CurrentPoint');
                set(obj.rect,'Position',[min([obj.startclick;pos(1,1:2)]) ,abs(pos(1,1:2)-obj.startclick)+0.0001])
            end
        end
        function MouseDown(obj)
            pos=get(obj.Axes,'CurrentPoint');
            obj.startclick=pos(1,1:2);
            if(obj.getMode()==1)
                
                centre=size(obj.Image)/2;
                line(centre(2),centre(1),'Marker','+');
            end
        end
        function MouseUp(obj)
            pos=get(obj.Axes,'CurrentPoint'); 
            if(obj.getMode()==1)
                
                centre=size(obj.Image)/2;centre=centre([2 1]);
                v1=obj.startclick-centre;v2=pos(1,1:2)-centre;
                A=acos( dot(v1,v2)/(norm(v1)*norm(v2)) );
                if(dot([v1(2) -v1(1)],v2)>0)
                    A=-A;
                end
                
                obj.Angle=obj.Angle+A;
                obj.Image=fast_rotate(obj.RawImage, obj.Angle/pi*180);
                image(obj.Image,'Parent',obj.Axes,'XData',[1 size(obj.Image,2)],'YData',[size(obj.Image,1) 1]);
                set(obj.Axes,'ytick',[],'xtick',[],'Ydir', 'normal')
                axis(obj.Axes,'image');
                obj.rect=rectangle('Parent',obj.Axes,'Position',[-1 -1 1 1]);
            elseif(obj.getMode()==2)
                r=round([min([obj.startclick;pos(1,1:2)]);max([obj.startclick;pos(1,1:2)])]);
                
                imProfil=obj.Image(end+1-r(2,2):end+1-r(1,2),r(1,1):r(2,1),:);
                if(isempty(obj.profilobj) || ~isvalid(obj.profilobj))
                    obj.profilobj=profil(imProfil,obj.pixelpercm);
                else
                    obj.profilobj.setImage(imProfil,obj.pixelpercm);
                end
                
                
            end
            obj.startclick=[];
        end

    end
end



