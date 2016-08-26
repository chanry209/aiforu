function varargout = ISEEU_TREATEMENT(varargin)
% ISEEU_TREATEMENT MATLAB code for ISEEU_TREATEMENT.fig
%      ISEEU_TREATEMENT, by itself, creates a new ISEEU_TREATEMENT or raises the existing
%      singleton*.
%
%      H = ISEEU_TREATEMENT returns the handle to a new ISEEU_TREATEMENT or the handle to
%      the existing singleton*.
%
%      ISEEU_TREATEMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ISEEU_TREATEMENT.M with the given input arguments.
%
%      ISEEU_TREATEMENT('Property','Value',...) creates a new ISEEU_TREATEMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ISEEU_TREATEMENT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ISEEU_TREATEMENT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ISEEU_TREATEMENT

% Last Modified by GUIDE v2.5 26-Aug-2016 03:01:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ISEEU_TREATEMENT_OpeningFcn, ...
                   'gui_OutputFcn',  @ISEEU_TREATEMENT_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before ISEEU_TREATEMENT is made visible.
function ISEEU_TREATEMENT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ISEEU_TREATEMENT (see VARARGIN)

% Choose default command line output for ISEEU_TREATEMENT
handles.output = hObject;
% Update handles structure

guidata(hObject, handles);

% UIWAIT makes ISEEU_TREATEMENT wait for user response (see UIRESUME)
% uiwait(handles.iseeu_treatement);

% --- Outputs from this function are returned to the command line.
function varargout = ISEEU_TREATEMENT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function loadPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loadPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in loadbutton.
function loadbutton_Callback(hObject, eventdata, handles)
% hObject    handle to loadbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.textLoading,'string','Loading.................')
pause(1)
%----------------------- ----------------------------
% 1) Import the figure
fileName=handles.datauser.fileName; % Read the path
if isempty(fileName)
    set(handles.textLoading,'string','Nothing is requested ?!')
    return
end

% ---------------------------------------------------
% 2) Read file
figure(1)
I = imread(fileName); % load the Figure
[I2, rect] = imcrop(I); % crop the figure, remember copy the new figure
I2 = imrotate(I2, 90); % rotation of the figure
newFig = I2; % n;ew figure data

% save
handles.datauser.oldFig = I;
handles.datauser.newFig = newFig;

% show the oldFig
axes(handles.oldFig)
imagesc(I);
title('Orignal Figure')
axis image
axis auto
axis off

% show the oldFig
axes(handles.newFig)
imagesc(I2);
%title('Crop Figure')
axis image % zoom the figure to original scale
axis auto
axis off

set(handles.x1,'string',rect(1))
set(handles.y1,'string',rect(2))
set(handles.x2,'string',rect(3))
set(handles.y2,'string',rect(4))

% SAVE
set(hObject,'string','OK');
set(handles.textLoading,'string','Loading Completed','BackGroundColor',[1 0 0])
pause(1)
set(hObject,'string','Load');
set(handles.textLoading,'string','Load the Next','BackGroundColor',[0.7 0.7 0.7])
guidata(hObject,handles);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over loadPath.
function loadPath_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to loadPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sel = get(gcf,'selectiontype');
if isequal(sel,'open')
    [file path index ] = uigetfile({'*.png;*.jpg;*.tif'},'File Selector');
    if index==0
        return
    end
    if (index)&&(ischar(file)) 
        str = [path file];
        set(hObject,'string',str);
    end      
    if isempty(str)
        return
    end
    handles.datauser.fileName = str;
end

guidata(hObject,handles);


% --- Executes on button press in saveNewFig.
function saveNewFig_Callback(hObject, eventdata, handles)
% hObject    handle to saveNewFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path = pwd;
pathFig = strcat(path,'\CropFigures\',date);

% make a folder named date to place the figures 
% s = mkdir(pathFig);
% if s~=1
%     msgbox('There is problem of building a new folder for figures!')
%     return
% end
%%% ---------save Figure ----------------------------------------%%%
name = get(handles.newFigName, 'string');
name = strcat(pathFig,'-', name);
I = handles.datauser.newFig;
I=im2uint8(I);  % convert image to 8bit unsighed integers

n=find(name=='\',1,'last');
nameFig=name([(n+1):end]);
figure(2);
imshow(I);
%title(['crop Figure-',nameFig]);

save(name,'I');
%saveas(gcf,name);
%cropFigName=figure2;
%print(cropFigName,'-djpeg',name);
set(handles.saveNewFig,'string','be Saving')
pause(1);
set(handles.saveNewFig,'string','Save')
handles.datauser.nameFig=nameFig;
guidata(hObject,handles);


function newFigName_Callback(hObject, eventdata, handles)
% hObject    handle to newFigName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of newFigName as text
%        str2double(get(hObject,'String')) returns contents of newFigName as a double


% --- Executes during object creation, after setting all properties.
function newFigName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to newFigName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pathImTreated_Callback(hObject, eventdata, handles)
% hObject    handle to pathImTreated (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pathImTreated as text
%        str2double(get(hObject,'String')) returns contents of pathImTreated as a double


% --- Executes during object creation, after setting all properties.
function pathImTreated_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pathImTreated (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in loadImTreated.
function loadImTreated_Callback(hObject, eventdata, handles)
% hObject    handle to loadImTreated (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function loadButton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to load1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over loadButton1.
function loadButton1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to loadButton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sel = get(gcf,'selectiontype');
if isequal(sel,'open')
    %[file path index ] = uigetfile({'*.png;*.jpg;*.tif;*.mat'},'File Selector');
    [file path index ] = uigetfile({'*.png;*.jpg;*.tif'},'File Selector');
    if index==0
        return
    end
    if isequal(file,0)
        disp('please select your figure');
    else
        str=[path file]; 
        treatFig=imread(str);
        handles.datauser.fileName = str;
        axes(handles.figDelSpot);
        imagesc(treatFig);
        axis image;
        axis normal;
        axis off;
    end
    str=handles.datauser.fileName;
    n=find(str=='\',1,'last');
    nameFig=str([(n+1):end]);
    figure(2);
    imshow(treatFig);
    title(['crop Figure-',nameFig]);

    handles.datauser.treatFig = treatFig;
    handles.datauser.figPath=str;
    handles.datauser.nameFig=nameFig;

end



guidata(hObject,handles);

% --- Executes on button press in previousLoad1.
function previousLoad1_Callback(hObject, eventdata, handles)
% hObject    handle to previousLoad1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

J=handles.datauser.newFig;
handles.datauser.treatFig=J;

imshow(J);
% title(['crop Figure-',nameFig]);
axes(handles.figDelSpot);
colormap gray;
imagesc(J);
axis image; % zoom the figure to original scale
axis auto;
axis off;

guidata(hObject,handles);

% --- Executes on button press in inpaint.
function inpaint_Callback(hObject, eventdata, handles)
% hObject    handle to inpaint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

J=handles.datauser.treatFig;
figName=handles.datauser.nameFig;

if ndims(J)==3
    J=rgb2gray(J);
end
J = im2uint8(J);

coef_str=get(handles.delSpotVal,'string');
coef=str2double(coef_str);

resI=deletHighlight(J,coef,0);
inpaintFig=resI;
%figName=handles.datauser.nameFig;

axes(handles.figDelSpot);
colormap gray;
imagesc(inpaintFig);
axis image % zoom the figure to original scale
axis normal
axis off

figure;
colormap gray;
imagesc(inpaintFig);
title(['bright spot inpainted Figure-',figName]);
%print(inpainFig,'-djpeg',['bright spot inpainted Figure-',figName])
%print(getimage(handles.figDelSpot),'-djpeg',['bright spot inpainted Figure-',figName])
handles.datauser.inpaintFig=inpaintFig;

guidata(hObject,handles);


function delSpotVal_Callback(hObject, eventdata, handles)
% hObject    handle to delSpotVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of delSpotVal as text
%        str2double(get(hObject,'String')) returns contents of delSpotVal as a double


% --- Executes during object creation, after setting all properties.
function delSpotVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to delSpotVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in takeOut1.
function takeOut1_Callback(hObject, eventdata, handles)
% hObject    handle to takeOut1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figName=handles.datauser.nameFig;

figure;
colormap gray;
imagesc(handles.datauser.inpaintFig);
title(['bright spot inpainted Figure-',figName]);
%print(inpainFig,'-djpeg',['bright spot inpainted Figure-',figName])
%print(getimage(handles.figDelSpot),'-djpeg',['bright spot inpainted Figure-',figName])

guidata(hObject,handles);


% --- Executes on button press in previousLoad2.
function previousLoad2_Callback(hObject, eventdata, handles)
% hObject    handle to previousLoad2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

J=handles.datauser.inpaintFig;

axes(handles.figAjustContrast);
colormap gray;
imagesc(J);
axis image; % zoom the figure to original scale
axis auto;
axis off;

handles.datauser.treatFig2=J;
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function loadButton2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loadButton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over loadButton2.
function loadButton2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to loadButton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

sel = get(gcf,'selectiontype');
if isequal(sel,'open')
    %[file path index ] = uigetfile({'*.png;*.jpg;*.tif;*.mat'},'File Selector');
    [file path index ] = uigetfile({'*.png;*.jpg;*.tif'},'File Selector');
    if index==0
        return
    end
    if isequal(file,0)
        disp('please select your figure');
    else
        str=[path file]; 
        %treatFig=load(str);
        treatFig=imread(str);
        handles.datauser.fileName = str;
        axes(handles.figAjustContrast);
        imagesc(treatFig);
        axis image;
        axis normal;
        axis off;
    end
    str=handles.datauser.fileName;
    n=find(str=='\',1,'last');
    nameFig=str([(n+1):end]);
    figure(2);
    imshow(treatFig);
    title(['crop Figure-',nameFig]);

    handles.datauser.treatFig2 = treatFig;
    handles.datauser.figPath=str;
    handles.datauser.nameFig=nameFig;
end

guidata(hObject,handles);



% --- Executes on button press in ajustContast.
function ajustContast_Callback(hObject, eventdata, handles)
% hObject    handle to ajustContast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

J=handles.datauser.treatFig2;
resI=adjustContrast(J);
ajustContrastFig=resI;

figName=handles.datauser.nameFig;
axes(handles.figAjustContrast);
colormap gray;
imagesc(ajustContrastFig);
axis image % zoom the figure to original scale
axis normal
axis off

figure;
imshow(ajustContrastFig);
title(['contrast increased Figure-',figName]);

handles.datauser.ajustContrastFig=ajustContrastFig;
guidata(hObject,handles);

% --- Executes on button press in takeOut2.
function takeOut2_Callback(hObject, eventdata, handles)
% hObject    handle to takeOut2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figName=handles.datauser.nameFig;

figure;
colormap gray;
imagesc(handles.datauser.ajustContrastFig);
title(['contrast increased Figure-',figName]);
%print(inpainFig,'-djpeg',['bright spot inpainted Figure-',figName])
%print(getimage(handles.figDelSpot),'-djpeg',['bright spot inpainted Figure-',figName])

guidata(hObject,handles);

% --- Executes on button press in previousLoad3.
function previousLoad3_Callback(hObject, eventdata, handles)
% hObject    handle to previousLoad3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

J=handles.datauser.ajustContrastFig;

axes(handles.figMorph);
colormap gray;
imagesc(J);
axis image; % zoom the figure to original scale
axis auto;
axis off;

handles.datauser.treatFig3=J;
handles.datauser.treatFig4=J;
guidata(hObject,handles);


% --- Executes on button press in loadButton3.
function loadButton3_Callback(hObject, eventdata, handles)
% hObject    handle to loadButton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over loadButton3.
function loadButton3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to loadButton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

sel = get(gcf,'selectiontype');
if isequal(sel,'open')
    %[file path index ] = uigetfile({'*.png;*.jpg;*.tif;*.mat'},'File Selector');
    [file,path,index ] = uigetfile({'*.png;*.jpg;*.tif'},'File Selector');
    if index==0
        return
    end
    if isequal(file,0)
        disp('please select your figure');
    else
        str=[path,file]; 
        %treatFig=load(str);
        treatFig=imread(str);
        % show figure in the axes
        handles.datauser.fileName = str;
        axes(handles.figMorph);
        imagesc(treatFig);
        axis image;
        axis normal;
        axis off;
    end
    str=handles.datauser.fileName;
    n=find(str=='\',1,'last');
    nameFig=str([(n+1):end]);
    figure(3);
    imshow(treatFig);
    title(['treat Figure-',nameFig]);

    handles.datauser.treatFig3 = treatFig;
    handles.datauser.figPath=str;
    handles.datauser.nameFig=nameFig;
end

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function loadButton3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loadButton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function closeDiskSize_Callback(hObject, eventdata, handles)
% hObject    handle to closeDiskSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of closeDiskSize as text
%        str2double(get(hObject,'String')) returns contents of closeDiskSize as a double



% --- Executes during object creation, after setting all properties.
function closeDiskSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to closeDiskSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in morphClose.
function morphClose_Callback(hObject, eventdata, handles)
% hObject    handle to morphClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

J=handles.datauser.treatFig3;
figName=handles.datauser.nameFig;

if ndims(J)==3
    J=rgb2gray(J);
end
J = im2uint8(J);

a=get(handles.closeDiskSize,'string');
a=str2double(a);
resI=closeOperation(J,a);
closeMorphFig=resI;

axes(handles.figMorph);
colormap gray;
imagesc(closeMorphFig);
axis image % zoom the figure to original scale
axis normal
axis off

figure;
imshow(closeMorphFig);
title(['close Morph Figure-',figName]);
handles.datauser.closeMorphFig=closeMorphFig;
handles.datause.treatFig4=handles.datauser.closeMorphFig;
guidata(hObject,handles);


function closeSize_Callback(hObject, eventdata, handles)
% hObject    handle to closeSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of closeSize as text
%        str2double(get(hObject,'String')) returns contents of closeSize as a double


% --- Executes during object creation, after setting all properties.
function closeSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to closeSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in openMorph.
function openMorph_Callback(hObject, eventdata, handles)
% hObject    handle to openMorph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

J=handles.datauser.treatFig4;

aStr=get(handles.openSize1,'string');
bStr=get(handles.openSize2,'string');
a=str2double(aStr); 
b=str2double(bStr); 

resI=openOperation(J,a,b);
openMorphFig=resI;

figName=handles.datauser.nameFig;
axes(handles.figMorph);
colormap gray;
imagesc(openMorphFig);
axis image % zoom the figure to original scale
axis normal
axis off

figure;
imshow(openMorphFig);
title(['open Morph Figure-',figName]);
%print(inpainFig,'-djpeg',['bright spot inpainted Figure-',figName])
%print(getimage(handles.figDelSpot),'-djpeg',['bright spot inpainted Figure-',figName])
handles.datauser.openMorphFig=openMorphFig;
% end
handles.datause.treatFig4=handles.datauser.openMorphFig;
guidata(hObject,handles);


function openSize1_Callback(hObject, eventdata, handles)
% hObject    handle to openSize1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of openSize1 as text
%        str2double(get(hObject,'String')) returns contents of openSize1 as a double


% --- Executes during object creation, after setting all properties.
function openSize1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to openSize1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function openSize2_Callback(hObject, eventdata, handles)
% hObject    handle to openSize2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of openSize2 as text
%        str2double(get(hObject,'String')) returns contents of openSize2 as a double


% --- Executes during object creation, after setting all properties.
function openSize2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to openSize2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in takeOut3.
function takeOut3_Callback(hObject, eventdata, handles)
% hObject    handle to takeOut3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figName=handles.datauser.nameFig;
J=handles.datauser.treatFig4;

figure;
colormap gray;
imagesc(J);
title(['morph operation-',figName]);
%print(inpainFig,'-djpeg',['bright spot inpainted Figure-',figName])
%print(getimage(handles.figDelSpot),'-djpeg',['bright spot inpainted Figure-',figName])

guidata(hObject,handles);

% --- Executes on button press in previousLoad4.
function previousLoad4_Callback(hObject, eventdata, handles)
% hObject    handle to previousLoad4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

J=handles.datauser.treatFig4;

axes(handles.figGaussFilter);
colormap gray;
imagesc(J);
axis image; % zoom the figure to original scale
axis normal;
axis off;

handles.datauser.treatFig5=J;
guidata(hObject,handles);



% --- Executes on button press in loadButton4.
function loadButton4_Callback(hObject, eventdata, handles)
% hObject    handle to loadButton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function loadButton4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to loadButton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

sel = get(gcf,'selectiontype');
if isequal(sel,'open')
    [file,path,index ] = uigetfile({'*.png;*.jpg;*.tif'},'File Selector');
    if index==0
        return
    end
    if isequal(file,0)
        disp('please select your figure');
    else
        str=[path,file]; 
        %treatFig=load(str);
        treatFig=imread(str);
        % show figure in the axes
        handles.datauser.fileName = str;
        axes(handles.figGaussFilter);
        imagesc(treatFig);
        axis image;
        axis normal;
        axis off;
    end
    str=handles.datauser.fileName;
    n=find(str=='\',1,'last');
    nameFig=str([(n+1):end]);
    figure(4);
    imshow(treatFig);
    title(['treat Figure-',nameFig]);

   handles.datauser.treatFig5 = treatFig;
   handles.datauser.figPath=str;
   handles.datauser.nameFig=nameFig;
end

guidata(hObject,handles);


% --- Executes on button press in gaussFilter.
function gaussFilter_Callback(hObject, eventdata, handles)
% hObject    handle to gaussFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

J=handles.datauser.treatFig5;

freq=get(handles.gauSlideVal,'value');
freq=int32(freq);
resI = gaussian_lowpass_filter(J,freq);

gaussFilterFig=resI;
axes(handles.figGaussFilter);
colormap gray;
%imagesc(gaussFilterFig);
imagesc(1+log(abs(resI)));
%imagesc(1+log(abs(gaussFilterFig)));
axis image % zoom the figure to original scale
axis normal
axis off

figName=handles.datauser.nameFig;
figure;
colormap gray;
imagesc(1+log(abs(resI)));
title(['guass filter Figure-',figName]);


handles.datauser.gaussFilterFig=gaussFilterFig;
handles.datause.treatFig6=handles.datauser.gaussFilterFig;
guidata(hObject,handles);

function gauSlideVal_Callback(hObject, eventdata, handles)
% hObject    handle to openSize2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of openSize2 as text
%        str2double(get(hObject,'String')) returns contents of openSize2 as a double
gauFilterVal=get(handles.gauSlideVal,'value');
gauFilterVal=int32(gauFilterVal);
set(handles.editSlide,'string',num2str(gauFilterVal));


guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function gauSlideVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to openSize2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editSlide_Callback(hObject, eventdata, handles)
% hObject    handle to editSlide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSlide as text
%        str2double(get(hObject,'String')) returns contents of editSlide as a double
gauFilterVal=get(handles.gauSlideVal,'val');
gauFilterVal=str2num(gauFilterVal);
if (isempty(gauFilterVal) || gauFilterVal < 10 || gauFilterVal > 100)
    set(handles.gauSlideVal,'Value',0);
    set(handles.sliderVal,'Value',0);
else
    set(handles.sliderVal,'Value',gauFilterVal);
end



% --- Executes on button press in takeOut4.
function takeOut4_Callback(hObject, eventdata, handles)
% hObject    handle to takeOut4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

J=handles.datauser.gaussFilterFig
figName=handles.datauser.nameFig;
figure;
colormap gray;
imagesc(1+log(abs(J)));
title(['gauss filter operation-',figName]);

guidata(hObject,handles);



% --- Executes on button press in edgePadding.
function edgePadding_Callback(hObject, eventdata, handles)
% hObject    handle to edgePadding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

J=handles.datauser.treatFig6;
resI=paddingEdge(J);

edgesPaddingFig=resI;

axes(handles.figEdgesPadding);
colormap gray;
imagesc(resI);
%imagesc(edgesPaddingFig);
axis image % zoom the figure to original scale
axis normal
axis off

figName=handles.datauser.nameFig;
figure;
colormap gray;
imagesc(edgesPaddingFig);
title(['edges padding Figure -',figName]);


handles.datauser.edgesPaddingFig=edgesPaddingFig;
handles.datause.treatFig7=handles.datauser.edgesPaddingFig;
guidata(hObject,handles);


% --- Executes on button press in takeOut5.
function takeOut5_Callback(hObject, eventdata, handles)
% hObject    handle to takeOut5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

J=handles.datauser.edgesPaddingFig;
figName=handles.datauser.nameFig;
figure;
colormap gray;
imagesc(J);
title(['edges padding Figure -',figName]);

guidata(hObject,handles);


% --- Executes on button press in previousLoad5.
function previousLoad5_Callback(hObject, eventdata, handles)
% hObject    handle to previousLoad5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


J=handles.datause.treatFig6;

axes(handles.figEdgesPadding);
colormap gray;
imagesc(1+log(abs(J)));
axis image; % zoom the figure to original scale
axis normal;
axis off;

handles.datauser.treatFig6=J;
guidata(hObject,handles);


% --- Executes on button press in loadButton5.
function loadButton5_Callback(hObject, eventdata, handles)
% hObject    handle to loadButton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over loadButton5.
function loadButton5_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to loadButton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

sel = get(gcf,'selectiontype');
if isequal(sel,'open')
    [file,path,index ] = uigetfile({'*.png;*.jpg;*.tif'},'File Selector');
    if index==0
        return
    end
    if isequal(file,0)
        disp('please select your figure');
    else
        str=[path,file]; 
        %treatFig=load(str);
        treatFig=imread(str);
        % show figure in the axes
        handles.datauser.fileName = str;
        axes(handles.figEdgesPadding);
        imagesc(treatFig);
        axis image;
        axis normal;
        axis off;
    end

    str=handles.datauser.fileName;
    n=find(str=='\',1,'last');
    nameFig=str([(n+1):end]);
    figure(5);
    imshow(treatFig);
    title(['treat Figure-',nameFig]);

    handles.datauser.treatFig6 = treatFig;
    handles.datauser.figPath=str;
    handles.datauser.nameFig=nameFig;

end
guidata(hObject,handles);


function inpaintVal2_Callback(hObject, eventdata, handles)
% hObject    handle to inpaintVal2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inpaintVal2 as text
%        str2double(get(hObject,'String')) returns contents of inpaintVal2 as a double


% --- Executes during object creation, after setting all properties.
function inpaintVal2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inpaintVal2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in autoLoadButton.
function autoLoadButton_Callback(hObject, eventdata, handles)
% hObject    handle to autoLoadButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over autoLoadButton.
function autoLoadButton_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to autoLoadButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sel = get(gcf,'selectiontype');
if isequal(sel,'open')
    [file,path,index ] = uigetfile({'*.png;*.jpg;*.tif'},'File Selector');
    if index==0
        return
    end
    if isequal(file,0)
        disp('please select your figure');
    else
        str=[path,file]; 
        %treatFig=load(str);
        treatFig=imread(str);
        % show figure in the axes
        handles.datauser.fileName = str;
        axes(handles.figAlloperation);
        imagesc(treatFig);
        axis image;
        axis normal;
        axis off;
    end
    str=handles.datauser.fileName;
    n=find(str=='\',1,'last');
    nameFig=str([(n+1):end]);
%     figure(4);
%     imshow(treatFig);
%     title(['treat Figure-',nameFig]);

   handles.datauser.treatFig5 = treatFig;
   handles.datauser.figPath=str;
   handles.datauser.nameFig=nameFig;
end

guidata(hObject,handles);


% --- Executes on button press in autoPrecessingButton.
function autoPrecessingButton_Callback(hObject, eventdata, handles)
% hObject    handle to autoPrecessingButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

I= handles.datauser.treatFig5;
if (ndims(I)==3)  
    I=rgb2gray(I);
end

% histogramme and the distribution of pixel of each column
[m,n]=size(I);
L=256;
histo=zeros(L,1);

for i=1:m
    for j=1:n
        histo(I(i,j)+1)=histo(I(i,j)+1)+1;    % histogramme
    end
end

histo1=histo/(m*n);   

meanI=zeros(1,n);  
medianI = zeros(1,n);
for j=1:n
    meanI(j)=mean(I(:,j));   % mean pixel of each column
end

for j=1:n
    medianI(j)=median(I(:,j));   % median pixel of each column
end


%%%  Ignore the top 20% highlights defaut
Inew1=I;
%percent=0.2
for j=1:n
    temp=sort(unique(I(:,j)));
    length=size(temp,1);
    threshold=temp(round(0.2*length)+1);
    
    for i=1:m
        if Inew1(i,j)>threshold
            Inew1(i,j)=medianI(j);
        end
    end
end

figure;
subplot(2,1,1);
imshow(I);
title('Figure originale');
subplot(2,1,2)
imshow(Inew1);
title('Figure after ignore the highlights');


%%% increases the contrast of image by adjust image intensity values
Inew2=imadjust(Inew1);
Inew2=histeq(Inew2); % enhance contrast by histogram equalization (maxi l'entropie) 
figure;
colormap gray;
imagesc(Inew2);
title('Figure afpter increase contrast');

%%% operation open and close
Inew3=closeOperation(Inew2,3);
Inew4=openOperation(Inew3,3,5);

%%%% filtre base-pass gaussian (Glpf:Gaussian low pass filter)
glfp_fc=10:10:100;
% global Inew3_1;
% global Inew3_2;
% global Inew3_3;
% global Inew3_4;
% global Inew3_5;
% global Inew3_6;
% global Inew3_7;
% global Inew3_8;
% global Inew3_9;
% global Inew3_10;
Inew5_1 = gaussian_lowpass_filter(Inew4,glfp_fc(1)); 
Inew5_2 = gaussian_lowpass_filter(Inew4,glfp_fc(2));
Inew5_3 = gaussian_lowpass_filter(Inew4,glfp_fc(3));
Inew5_4 = gaussian_lowpass_filter(Inew4,glfp_fc(4));
Inew5_5 = gaussian_lowpass_filter(Inew4,glfp_fc(5));
Inew5_6 = gaussian_lowpass_filter(Inew4,glfp_fc(6));
Inew5_7 = gaussian_lowpass_filter(Inew4,glfp_fc(7));
Inew5_8 = gaussian_lowpass_filter(Inew4,glfp_fc(8));
Inew5_9 = gaussian_lowpass_filter(Inew4,glfp_fc(9));
Inew5_10 = gaussian_lowpass_filter(Inew4,glfp_fc(10));

figure;
subplot(2,2,1);
colormap gray;
imagesc(Inew2);
title('Figure after increase contrast');
hold on;
subplot(2,2,2)
colormap gray;
imagesc(1+log(abs(Inew5_1)));
title(['Figure 1,freq ',num2str(glfp_fc(1))]);
hold on;
subplot(2,2,3)
colormap gray;
imagesc(1+log(abs(Inew5_2)));
title(['Figure 2 freq ',num2str(glfp_fc(2))]);
hold on;
subplot(2,2,4)
colormap gray;
imagesc(1+log(abs(Inew5_3)));
title(['Figure 3 freq ',num2str(glfp_fc(3))]);

figure;
subplot(2,2,1);
colormap gray;
imagesc(1+log(abs(Inew5_4)));
title(['Figure 4 freq ',num2str(glfp_fc(4))]);
hold on
subplot(2,2,2);
colormap gray;
imagesc(1+log(abs(Inew5_5)));
title(['Figure 5 freq ',num2str(glfp_fc(5))]);
hold on;
subplot(2,2,3)
colormap gray;
imagesc(1+log(abs(Inew5_6)));
title(['Figure 6 freq ',num2str(glfp_fc(6))]);
hold on;
subplot(2,2,4)
colormap gray;
imagesc(1+log(abs(Inew5_7)));
title(['Figure 7, freq ',num2str(glfp_fc(7))]);

figure;
subplot(3,1,1);
colormap gray;
imagesc(1+log(abs(Inew5_8)));
title(['Figure 8 freq ',num2str(glfp_fc(8))]);
subplot(3,1,2)
colormap gray;
imagesc(1+log(abs(Inew5_9)));
title(['Figure 9 freq ',num2str(glfp_fc(9))]);
subplot(3,1,3)
colormap gray;
imagesc(1+log(abs(Inew5_10)));
title(['Figure 10 freq ',num2str(glfp_fc(10))]);

figure;
imshow('message.jpg');


handles.datauser.Inew5_1=Inew5_1;
handles.datauser.Inew5_2=Inew5_2;
handles.datauser.Inew5_3=Inew5_3;
handles.datauser.Inew5_4=Inew5_4;
handles.datauser.Inew5_4=Inew5_4;
handles.datauser.Inew5_5=Inew5_5;
handles.datauser.Inew5_6=Inew5_6;
handles.datauser.Inew5_7=Inew5_7;
handles.datauser.Inew5_8=Inew5_8;
handles.datauser.Inew5_9=Inew5_9;
handles.datauser.Inew5_10=Inew5_10;
% open('message.fig');
% pause(5);

guidata(hObject,handles);



function gaussChoiceNum_Callback(hObject, eventdata, handles)
% hObject    handle to gaussChoiceNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gaussChoiceNum as text
%        str2double(get(hObject,'String')) returns contents of gaussChoiceNum as a double
% close all;

% --- Executes during object creation, after setting all properties.
function gaussChoiceNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gaussChoiceNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gaussChoiceButton.
function gaussChoiceButton_Callback(hObject, eventdata, handles)
% hObject    handle to gaussChoiceButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%close all;
guidata(hObject, handles);
numFig=get(handles.gaussChoiceNum,'Value');
if numFig==1
    Inew5=handles.datauser.Inew5_1;
elseif numFig==2
    Inew5=handles.datauser.Inew5_2;
elseif numFig==3
    Inew5=handles.datauser.Inew5_3;
elseif numFig==4
    Inew5=handles.datauser.Inew5_4;
elseif numFig==5
    Inew5=handles.datauser.Inew5_5;
elseif numFig==6
    Inew5=handles.datauser.Inew3_6;
elseif numFig==7
    Inew5=handles.datauser.Inew5_7;
elseif numFig==8
    Inew5=handles.datauser.Inew5_8;
elseif numFig==9
    Inew5=handles.datauser.Inew5_9;
elseif numFig==10
    Inew5=handles.datauser.Inew5_10;
else
    disp('please entre the correct number of figure');
end

%%% padding the edges of image
Inew5=uint8(real(Inew5)); 
resIauto=paddingEdge(Inew5);

close Figure 1; close Figure 2;
close Figure 3; close Figure 4;
close Figure 5; close Figure 6; 
% close Figure 7; close Figure 8;
% close Figure 9; close Figure 10; close Figure 11;

figure;
colormap gray;
imagesc(resIauto);
title('result automatique with gauss filter');
%title(['result automatique with gauss filter'],num2str(glfp_fc(numFig)));


% --- Executes on button press in runNextButton.
function runNextButton_Callback(hObject, eventdata, handles)
% hObject    handle to runNextButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(gcf)
open('mainOperations.fig');
